clear all

subject=2;

difference=0; %Determine whether to calculate difference between actual and expected based on random permutation

padfiltersigma=.8; %min 1, 5 is pretty bad
padAngleJitter=0; %30 is pretty bad, set to zero to save time
padXYJitter=1; %5 is pretty bad, 3 is workable
matrixWidth=80;

npadsTouched=50;

%% create list of duplicate objects
% ObjectsDB = sqlite('L:\stimuli\grasp\objects.db');
% groupsFull=fetch(ObjectsDB, ['SELECT GROUP_CONCAT(blobID), blobName, unitsPerMM, pointsPerRad, nContacts, slotDepth, slotWidth, maxWidth, symmetric, pair, leftPair, COUNT(*) c FROM objectsTable GROUP BY blobName, unitsPerMM, pointsPerRad, nContacts, slotDepth, slotWidth, maxWidth, symmetric, pair, leftPair HAVING c > 1']);
% groups=nan(size(groupsFull,1),2);
% for i=1:size(groupsFull,1)
%    this=strsplit(groupsFull{i,1} ,',');
%     for ii=1:size(this,2)
%         groups(i,ii)=str2double(this{ii});
%     end
% end
% clear groupsFull i ii this
% close(ObjectsDB)

% [row, ~]=find(groups==targetID);
% targ1=num2str(groups(row,1));
% targ2=num2str(groups(row,2));

%% find trials to analyze
DataDB = sqlite('C:\Users\Ryan\Documents\Data\graspHuman.db');
trials=double(cell2mat(fetch(DataDB, ['Select UniqueTrial FROM trialsTable WHERE Subject = ' num2str(subject)])));

npads=ones(size(trials)) * npadsTouched;

tic
vecMat=[];
idMat=[];
DataDB = sqlite('C:\Users\Ryan\Documents\Data\graspHuman.db');
conn = sqlite('L:\stimuli\grasp\objects.db');
for tc=1:size(trials,1)
    t=trials(tc);
    
    %% get object id for this trial
    trial=num2str(t);
    try
        id=double(cell2mat(fetch(DataDB, ['SELECT Choice1ID FROM trialsTable WHERE UniqueTrial = ' trial])));
    catch
        id=double(cell2mat(fetch(DataDB, ['SELECT Choice2ID FROM trialsTable WHERE UniqueTrial = ' trial])));
    end
    
    %% make filtered pads for this object
    tableid=num2str(id);
    filtered=zeros(matrixWidth,matrixWidth,12);
    for i=1:12
        %get pad data
        mat=fetch(conn,['SELECT * FROM shapeTable' num2str(id) ' WHERE PAD IS ' num2str(i)]);
        mat=cell2mat(mat(:,1:2));
        mat=round(mat.*matrixWidth.*.7)+round(matrixWidth/2); %Scale and shift pad
        
        %Put pad in matrix
        f=zeros(matrixWidth,matrixWidth);
        for ii=1:size(mat,1)
            f(mat(ii,1),mat(ii,2))=1;
        end        
        %filter
%         h=fspecial('log',round(matrixWidth/5),padfiltersigma).*-1; %width, sigma        
        h1 = fspecial('gaussian',round(matrixWidth/5),padfiltersigma);
        h2 = fspecial('gaussian',round(matrixWidth/5),padfiltersigma*1.5)*-1;
        h= h1 + h2;
        
        filtered(:,:,i) = filter2(h, f);
    end
    
    clear h f mat i ii
    
    %% Construct fake representation of touch pcts
%     pads=[ones(npadsTouched/2,1);ones(npadsTouched/2,1)*2];
    pads=round(rand(npads(tc),1)*12); %each number here represents a touch of that pad
    thesePcts=zeros(npads(tc),12);
    for i=1:12 %Fills in "touches" in face pcts matrix
        n=sum(pads==i);
        pcts(1:n,i)=50;
    end
    
    %% Construct all frames of accumulation of object info
%     figure; hold on; axis equal; colormap(gray); colorbar; axis tight
    vidMat=zeros(matrixWidth,matrixWidth,size(pcts,1));
    for i=1:size(pcts,1) %For each row
        thesePcts=pcts(i,:);
        this=zeros(matrixWidth,matrixWidth,1);
        for ii=1:12 %For each pad
            if thesePcts(ii)>10 %If this pad is touched
                angle=max(min(randn(1,1)*padAngleJitter,50),-50);    %Choose random angle, bound between +/- 15
                xshift=round(max(min(randn(1,1)*padXYJitter,5),-5));   %Choose random xshift, bound between +/- 15
                yshift=round(max(min(randn(1,1)*padXYJitter,5),-5));   %Choose random yshift, bound between +/- 15
                
                for iii=1:floor(thesePcts(ii)/10)
                    this=this + jitterPad(filtered(:,:,ii),angle,xshift,yshift); %Add it to this frame
                end
            end
        end
        

        
        vidMat(:,:,i)=this; %Add this frame to the pile
        
%         % PLOT
        summed=sum(vidMat,3);       
        summed(summed>0)=1;
        summed(summed<0)=0;
        imagesc(summed)
        drawnow
       
    end
    toc
    clear started i this ii pcts f f2 angle xshift yshift filtered
    vidMatCum=sum(vidMat,3);
    vmcvec=vidMatCum(:)';
    vecMat=[vecMat; vmcvec];
    idMat=[idMat; id];
    
end
close(conn)
close(DataDB)
clear DataDB

for i=1:10
a=vecMat(i,:);
b=reshape(a,80,80);
        b(b>2)=2;
        b(b<0)=0;
figure; hold on; axis equal; colormap(gray); colorbar; axis tight
imagesc(b)
end

