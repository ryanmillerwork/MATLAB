clear

DataDB = sqlite('C:\Users\Ryan\Documents\Data\graspHuman.db');
ObjectsDB = sqlite('L:\stimuli\grasp\objects.db');

%Get shape info for all shapes now
shapeMat=[];
for i=1:100
    try
        sampleInfo=fetch(ObjectsDB, ['Select x, y, pad FROM shapeTable' num2str(i)]);
        this=[ones(size(sampleInfo,1),1).*i cell2mat(sampleInfo(:,1:2)) double(cell2mat(sampleInfo(:,3)))];
        shapeMat=[shapeMat; this];
    catch
    end
end
clear sampleInfo this i

% create list of duplicate objects
groupsFull=fetch(ObjectsDB, ['SELECT GROUP_CONCAT(blobID), blobName, unitsPerMM, pointsPerRad, nContacts, slotDepth, slotWidth, maxWidth, symmetric, pair, leftPair, COUNT(*) c FROM objectsTable GROUP BY blobName, unitsPerMM, pointsPerRad, nContacts, slotDepth, slotWidth, maxWidth, symmetric, pair, leftPair HAVING c > 1']);
groups=nan(size(groupsFull,1),2);
for i=1:size(groupsFull,1)
    this=strsplit(groupsFull{i,1} ,',');
    for ii=1:size(this,2)
        groups(i,ii)=str2double(this{ii});
    end
end
clear groupsFull i ii this


%Make list of hand side (0 for left) and trial ID
t=double(cell2mat(fetch(DataDB, 'Select UniqueTrial FROM trialsTable')));
tm=fetch(DataDB, 'Select TouchMode FROM trialsTable');
index = find(contains(tm,'right'));
trials=zeros(size(t,1),1);
trials(index)=1;
trials=[trials t];


for i=1:size(trials,1) %For each trial
    thisTrial=num2str(trials(i,2));
    thisSide=trials(i,1);
    
    %% eyes
    %Get data about eye position
    eyePos=double(cell2mat(fetch(DataDB, ['Select x, y FROM eyeTable' thisTrial ' WHERE x IS NOT NULL'])));
    eyeState=double(cell2mat(fetch(DataDB, ['Select saccade, blink FROM eyeTable' thisTrial ' WHERE x IS NOT NULL'])));
    eyes=[eyePos eyeState];
    clear eyePos eyeState
    
    %Get data about vis stim
    sampleInfo=fetch(DataDB, ['Select SampleID, SampleScale, SampleRotation FROM trialsTable WHERE UniqueTrial = ' num2str(thisTrial)]);
    
    %Get sample shape info and adjust
    sampleShape=shapeMat(shapeMat(:,1)==sampleInfo{1},2:4);
    sampleShape(:,1:2)=sampleShape(:,1:2).*sampleInfo{2};
    [sampleShape(:,1), sampleShape(:,2)]=rotatePoints(sampleShape(:,1),sampleShape(:,2),-deg2rad(double(sampleInfo{3})),0,0);
    
    %find the center of each pad
    means=[];
    for ii=1:max(sampleShape(:,3))
        means = [means; ii mean(sampleShape(sampleShape(:,3)==ii,1)) mean(sampleShape(sampleShape(:,3)==ii,2))];
    end
    
    %for each eye position sample, calculate the distance to each pad
    eyeDists=zeros(size(eyes,1),12);
    for ii=1:size(eyes,1)
        for iii=1:12
            eyeDists(ii,iii)=sqrt((means(iii,2)-eyes(ii,1)).^2 + (means(iii,3)-eyes(ii,2)).^2);
        end
    end
    
    % add column for time at the beginning
    ISI=double(cell2mat(fetch(DataDB, ['Select Rate FROM eyeTable' thisTrial ' WHERE Rate IS NOT NULL'])));
    eyes=[((0:size(eyes,1)-1)*1000/ISI)' eyes];
    clear ISI means
    
    %% touch
    if ~thisSide
        graspInfo=double(cell2mat(fetch(DataDB, ['Select Choice1ID, Choice1Rotation FROM trialsTable WHERE UniqueTrial = ' num2str(thisTrial)])));
        graspVals=double(cell2mat(fetch(DataDB,['SELECT StimTime, pctPad1_1, pctPad1_2, pctPad1_3, pctPad1_4, pctPad1_5, pctPad1_6, pctPad1_7, pctPad1_8, pctPad1_9, pctPad1_10, pctPad1_11, pctPad1_12 FROM graspTable' thisTrial ' WHERE TrialPeriod = 1'])));
    else
        graspInfo=double(cell2mat(fetch(DataDB, ['Select Choice2ID, Choice2Rotation FROM trialsTable WHERE UniqueTrial = ' num2str(thisTrial)])));
        graspVals=double(cell2mat(fetch(DataDB,['SELECT StimTime, pctPad2_1, pctPad2_2, pctPad2_3, pctPad2_4, pctPad2_5, pctPad2_6, pctPad2_7, pctPad2_8, pctPad2_9, pctPad2_10, pctPad2_11, pctPad2_12 FROM graspTable' thisTrial ' WHERE TrialPeriod = 1'])));
    end
    graspTimes=graspVals(:,1);
    graspVals=graspVals(:,2:end);
    
    
    %% construct matrices for locations of vis and haptic exploration for this trial
    eyeMat=[];
    graspMat=[];
    
    for ii=1:size(graspTimes,1)
        if ~sum(graspVals(ii,:)>15) %If there aren't any pads touched, ignore this sample
            continue;
        end
        
        time=[graspTimes(ii)-10 graspTimes(ii)+10];                                                 %Range of time around this touchsample to grab eye data
        eyeSamples=find(eyes(:,1)>=time(1) & eyes(:,1)<=time(2) & eyes(:,4)==0 & eyes(:,5)==0);   %Samples of eye data within our time window when they weren't blinking or saccading
        
        if isempty(eyeSamples) %If there isn't any valid eye position data around the time of this grasp sample, skip it
            continue;
        end
        
        theseEyeDs=mean(eyeDists(eyeSamples,:),1) .^ 2;                  %Mean distance to each pad during this sample period
        
        eyeMat=[eyeMat; theseEyeDs];
        graspMat=[graspMat; graspVals(ii,:)];
        
    end
    c=corr2(eyeMat,graspMat);
    
    
    
end


close(DataDB)
close(ObjectsDB)



