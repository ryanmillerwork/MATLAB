clear all

ObjectsDB = sqlite('L:\stimuli\grasp\objects.db');
DataDB = sqlite('C:\Users\Ryan\Documents\Data\graspHuman.db');

difficultyMat=[];

for objectID=1:40
    %% Setup
    % objectID=1;

    
    %% Read in data for relevant trials when the object was expected
    % Find unique trial IDs we're interested in for this object
    
    %     wherestring=['ExcludeSubject = 0 AND RespClass = "hit" AND Choice2Rotation IS NOT NULL AND Choice2Rotation = 0 AND ExcludeTrialGrasp = 0 AND Target = ' thisTarg];
    
    trialsLeft=double(cell2mat(fetch(DataDB, ['SELECT UniqueTrial FROM trialsTable WHERE ExcludeSubject = 0 AND ExcludeTrialGrasp = 0 AND Congruent = 1 AND SampleID = "' num2str(objectID) '" AND Choice1ID = "' num2str(objectID) '"'])));
    trialsRight=double(cell2mat(fetch(DataDB, ['SELECT UniqueTrial FROM trialsTable WHERE ExcludeSubject = 0 AND ExcludeTrialGrasp = 0 AND Congruent = 1 AND SampleID = "' num2str(objectID) '" AND Choice2ID = "' num2str(objectID) '"'])));
    
    if isempty(trialsLeft) && isempty(trialsRight)
        disp('No trials matching specified criteria');
        continue;
    end
    
    dataLeft= fetch(DataDB, ['SELECT UniqueTrial, StimOn, ReactionTime, Answer, Response, SampleRotation, Choice1Rotation FROM trialsTable WHERE ExcludeSubject = 0 AND ExcludeTrialGrasp = 0 AND Congruent = 1 AND SampleID = "' num2str(objectID) '" AND Choice1ID = "' num2str(objectID) '"']);
    dataRight=fetch(DataDB, ['SELECT UniqueTrial, StimOn, ReactionTime, Answer, Response, SampleRotation, Choice2Rotation FROM trialsTable WHERE ExcludeSubject = 0 AND ExcludeTrialGrasp = 0 AND Congruent = 1 AND SampleID = "' num2str(objectID) '" AND Choice2ID = "' num2str(objectID) '"']);
    
    %Add in grasp data
    col=size(dataLeft,2)+1;
    for i=1:size(trialsLeft,1)
        grasp=fetch(DataDB, ['SELECT Time_1, pctPad1_1, pctPad1_2, pctPad1_3, pctPad1_4, pctPad1_5, pctPad1_6, pctPad1_7, pctPad1_8, pctPad1_9, pctPad1_10, pctPad1_11, pctPad1_12 FROM graspTable' num2str(trialsLeft(i)) ' WHERE TrialPeriod = 1']);
        dataLeft(i,col)={grasp};
    end
    col=size(dataRight,2)+1;
    for i=1:size(trialsRight,1)
        grasp=fetch(DataDB, ['SELECT Time_2, pctPad2_1, pctPad2_2, pctPad2_3, pctPad2_4, pctPad2_5, pctPad2_6, pctPad2_7, pctPad2_8, pctPad2_9, pctPad2_10, pctPad2_11, pctPad2_12 FROM graspTable' num2str(trialsRight(i)) ' WHERE TrialPeriod = 1']);
        dataRight(i,col)={grasp};
    end
    clear grasp
    
    %Add in eye data
    col=size(dataLeft,2)+1;
    for i=1:size(trialsLeft,1)
        eye=fetch(DataDB, ['SELECT X, Y, Saccade FROM eyeTable' num2str(trialsLeft(i)) ' WHERE X IS NOT NULL']);
        rate=double(cell2mat(fetch(DataDB, ['SELECT Rate FROM eyeTable' num2str(trialsLeft(i)) ' WHERE Rate IS NOT NULL'])));
        eye=[[0 : 1000/rate : (size(eye,1)-1)*1000/rate]' cell2mat(eye(:,1:2)) double(cell2mat(eye(:,3)))];
        dataLeft(i,col)={eye};
    end
    col=size(dataRight,2)+1;
    for i=1:size(trialsRight,1)
        eye=fetch(DataDB, ['SELECT X, Y, Saccade FROM eyeTable' num2str(trialsRight(i)) ' WHERE X IS NOT NULL']);
        rate=double(cell2mat(fetch(DataDB, ['SELECT Rate FROM eyeTable' num2str(trialsRight(i)) ' WHERE Rate IS NOT NULL'])));
        eye=[[0 : 1000/rate : (size(eye,1)-1)*1000/rate]' cell2mat(eye(:,1:2)) double(cell2mat(eye(:,3)))];
        dataRight(i,col)={eye};
    end
    
    rows=size(dataLeft,1) + size(dataRight,1);
    data = [repmat({'Congruent'}, rows, 1) [dataLeft; dataRight]];
    clear eye col i dataLeft dataRight trialsLeft trialsRight rate rows
    
    %% Read in data for relevant trials when the object was unexpected
    % Find unique trial IDs we're interested in for this object
    trialsLeft=double(cell2mat(fetch(DataDB, ['SELECT UniqueTrial FROM trialsTable WHERE ExcludeSubject = 0 AND ExcludeTrialGrasp = 0 AND Congruent = 1 AND SampleID == "' num2str(objectID) '" AND Choice1ID = "' num2str(objectID) '"'])));
    trialsRight=double(cell2mat(fetch(DataDB, ['SELECT UniqueTrial FROM trialsTable WHERE ExcludeSubject = 0 AND ExcludeTrialGrasp = 0 AND Congruent = 1 AND SampleID == "' num2str(objectID) '" AND Choice2ID = "' num2str(objectID) '"'])));
    
    if isempty(trialsLeft) && isempty(trialsRight)
        disp('No trials matching specified criteria');
        return;
    end
    
    dataLeft= fetch(DataDB, ['SELECT UniqueTrial, StimOn, ReactionTime, Answer, Response, SampleRotation, Choice1Rotation FROM trialsTable WHERE ExcludeSubject = 0 AND ExcludeTrialGrasp = 0 AND Congruent = 1 AND SampleID == "' num2str(objectID) '" AND Choice1ID = "' num2str(objectID) '"']);
    dataRight=fetch(DataDB, ['SELECT UniqueTrial, StimOn, ReactionTime, Answer, Response, SampleRotation, Choice2Rotation FROM trialsTable WHERE ExcludeSubject = 0 AND ExcludeTrialGrasp = 0 AND Congruent = 1 AND SampleID == "' num2str(objectID) '" AND Choice2ID = "' num2str(objectID) '"']);
    
    %Add in grasp data
    col=size(dataLeft,2)+1;
    for i=1:size(trialsLeft,1)
        grasp=fetch(DataDB, ['SELECT Time_1, pctPad1_1, pctPad1_2, pctPad1_3, pctPad1_4, pctPad1_5, pctPad1_6, pctPad1_7, pctPad1_8, pctPad1_9, pctPad1_10, pctPad1_11, pctPad1_12 FROM graspTable' num2str(trialsLeft(i)) ' WHERE TrialPeriod = 1']);
        dataLeft(i,col)={grasp};
    end
    col=size(dataRight,2)+1;
    for i=1:size(trialsRight,1)
        grasp=fetch(DataDB, ['SELECT Time_2, pctPad2_1, pctPad2_2, pctPad2_3, pctPad2_4, pctPad2_5, pctPad2_6, pctPad2_7, pctPad2_8, pctPad2_9, pctPad2_10, pctPad2_11, pctPad2_12 FROM graspTable' num2str(trialsRight(i)) ' WHERE TrialPeriod = 1']);
        dataRight(i,col)={grasp};
    end
    clear grasp
    
    %Add in eye data
    col=size(dataLeft,2)+1;
    for i=1:size(trialsLeft,1)
        eye=fetch(DataDB, ['SELECT X, Y, Saccade FROM eyeTable' num2str(trialsLeft(i)) ' WHERE X IS NOT NULL']);
        rate=double(cell2mat(fetch(DataDB, ['SELECT Rate FROM eyeTable' num2str(trialsLeft(i)) ' WHERE Rate IS NOT NULL'])));
        eye=[[0 : 1000/rate : (size(eye,1)-1)*1000/rate]' cell2mat(eye(:,1:2)) double(cell2mat(eye(:,3)))];
        dataLeft(i,col)={eye};
    end
    col=size(dataRight,2)+1;
    for i=1:size(trialsRight,1)
        eye=fetch(DataDB, ['SELECT X, Y, Saccade FROM eyeTable' num2str(trialsRight(i)) ' WHERE X IS NOT NULL']);
        rate=double(cell2mat(fetch(DataDB, ['SELECT Rate FROM eyeTable' num2str(trialsRight(i)) ' WHERE Rate IS NOT NULL'])));
        eye=[[0 : 1000/rate : (size(eye,1)-1)*1000/rate]' cell2mat(eye(:,1:2)) double(cell2mat(eye(:,3)))];
        dataRight(i,col)={eye};
    end
    
    rows=size(dataLeft,1) + size(dataRight,1);
    data2 = [repmat({'Incongruent'}, rows, 1) [dataLeft; dataRight]];
    data = [data; data2];
    clear eye col dataLeft dataRight trialsLeft trialsRight rate data2 rows
    
    %% Grab shape info for this object
    try
        shape=fetch(ObjectsDB, ['SELECT * FROM shapeTable' num2str(objectID)]);
        shape=[cell2mat(shape(:,1:2)) double(cell2mat(shape(:,3)))];
    catch
        disp('No shape matching specified criteria')
        return;
    end
    

    
    %% Synchronize timing by stim onset
    for i=1:size(data,1)
        onset=double(data{i,3});
        %Grasp
        grasp=double(cell2mat(data{i,9}));
        grasp(:,1)=grasp(:,1)-onset;
        grasp=grasp(grasp(:,1)>0,:);
        data(i,9)={grasp};
        %Eyes
        eyes=data{i,10};
        eyes(:,1)=eyes(:,1) - onset;
        eyes=eyes(eyes(:,1)>0,:);
        data(i,10)={eyes};
    end
    
    clear grasp eyes onset
    
    %% Figure out what side this thing was on
    for i=1:size(data,1)
       if strcmp(data{i,1},'Congruent')
           side=double(data{i,5});
           if side
               side='right';
           else
               side='left';
           end
       end    
    end
    
    %% Plot grasp
    figure;
    for i=1:2
        for ii=1:4
            %Assign congruency and angle
            if i==1
                congruency = 'Congruent';
            else
                congruency = 'Incongruent';
            end
            angle=90*(ii-1);
            
            %Look for rows
            rows=[];
            for iii=1:size(data,1)
                if strcmp(data{iii,1},congruency) && data{iii,7}==angle
                    rows=[rows; iii];
                end
            end
            
            if isempty(rows)
                continue;
            end
            
            %Calculate % correct and RT
            performance=[];
            for iii=1:size(rows,1)
                rt=data{rows(iii),4};
                answer=data{rows(iii),5};
                resp=data{rows(iii),6};
                performance=[performance; rt answer==resp];
            end
            rt=round(mean(performance(:,1)));
            pc=round(sum(performance(:,2))/size(performance,1)*100);
                        
            %Grab touch data for these rows
            touch=[];
            for iii=1:size(rows,1)
                this=data{rows(iii),9};
                
                if i==1 
                    touch=[touch; this(1:floor(size(this,1)/2),:)];
                else
                    touch=[touch; this(floor(size(this,1)/2):end,:)];
                end
            end
            
            %Step through by time and calculate average
            window=100;
            averaged=[];
            for time=0:window:10000
                these=touch(touch(:,1)>=time & touch(:,1)<(time+window),:);
                averaged=[averaged; mean(these,1)];
            end
            
            %Plot
            subplot(2,4,(i-1)*4 + ii); hold on; axis equal; xlim([-.5 .5])
            title([side ' ' num2str(objectID) ' ' num2str(rt) ' ' num2str(pc) '% ' num2str(angle) 'deg n=' num2str(size(rows,1))])
            %         ylim([0 100])
            %         plot(averaged(:,1),averaged(:,2:end))
            %
            ave=nanmean(averaged(:,2:end));
            ave=ave-min(ave);
            ave=ave./max(ave);
            
            ave=ave .* 0.8 + 0.1;
            
            [xs, ys]=rotatePoints(shape(:,1),shape(:,2),-deg2rad(angle),0,0);
            for iii=1:12
               plot(xs(shape(:,3)==iii) ,ys(shape(:,3)==iii),'Color',[ave(iii) ave(iii)/2 ave(iii)/2],'LineWidth',5)               
            end
            
            
            
            meanMat=[];
            for iii=1:12
                rxs=xs(shape(:,3)==iii);
                rys=ys(shape(:,3)==iii);
                meanMat=[meanMat; mean(rxs) mean(rys)];
            end
            
            plot(mean(xs),mean(ys),'.')
            plot(mean(meanMat(:,1)),mean(meanMat(:,2)),'ro')
            
            
            
%             [theta,rho] = cart2pol(mean(meanMat(:,1)),mean(meanMat(:,2))); %angle and distance to center of mass, curvature weighted
            
            
            difficultyMat=[difficultyMat; double(data{i,5}) mean(meanMat(:,1)) mean(meanMat(:,2)) pc];
            
            drawnow
        end
    end
    
end


%% Close connections
close(ObjectsDB);
close(DataDB);

clear DataDB ObjectsDB