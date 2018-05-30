% %% Calculate running sum
% tic
% vidMatCum=zeros(size(vidMat));
% for i=2:size(vidMat,3)
%     vidMatCum(:,:,i)=vidMatCum(:,:,i-1) + vidMat(:,:,i);
% end
% toc
% clear vidMat i



% %% Plot
% figure; hold on; axis equal; colormap(gray); colorbar; axis tight
% 
% tic
% for i=1:size(vidMatCum,3)
%     
%     cla
%     imagesc(vidMatCum(:,:,i))
%     
%     drawnow
% end
% toc

%% create list of duplicate objects
% fetch(ObjectsDB, ['SELECT blobName, COUNT(*) c FROM objectsTable GROUP BY blobName HAVING c > 1'])
% fetch(ObjectsDB, ['SELECT blobName, unitsPerMM, pointsPerRad, nContacts, slotDepth, slotWidth, maxWidth, symmetric, pair, leftPair, COUNT(*) c FROM objectsTable GROUP BY blobName, unitsPerMM, pointsPerRad, nContacts, slotDepth, slotWidth, maxWidth, symmetric, pair, leftPair HAVING c > 1'])
ObjectsDB = sqlite('L:\stimuli\grasp\objects.db');
groupsFull=fetch(ObjectsDB, ['SELECT GROUP_CONCAT(blobID), blobName, unitsPerMM, pointsPerRad, nContacts, slotDepth, slotWidth, maxWidth, symmetric, pair, leftPair, COUNT(*) c FROM objectsTable GROUP BY blobName, unitsPerMM, pointsPerRad, nContacts, slotDepth, slotWidth, maxWidth, symmetric, pair, leftPair HAVING c > 1']);
groups=nan(size(groupsFull,1),2);
for i=1:size(groupsFull,1)
   this=strsplit(groupsFull{i,1} ,',');
    for ii=1:size(this,2)
        groups(i,ii)=str2double(this{ii});
    end
end
clear groupsFull i ii this

%% Get sum from db

% This reads in all the final cumulative touch images for each object and plots the average



DataDB = sqlite('C:\Users\Ryan\Documents\Data\graspHuman.db');
TouchDB = sqlite('C:\Users\Ryan\Documents\Data\graspHumanTouch.db');

targets=double(cell2mat(fetch(DataDB, 'Select Target FROM trialsTable')));
targets=unique(targets);


for i=1:size(targets,1)
    thisTarg=targets(i);
    [row, ~]=find(groups==thisTarg);
    targ1=num2str(groups(row,1));
    targ2=num2str(groups(row,2));
    
    % Positive image
%     wherestring=['Subject = 21 AND RespClass = "hit" AND Target = ' thisTarg];
%     wherestring=['ExcludeSubject = 0 AND RespClass = "hit" AND Choice2Rotation IS NOT NULL AND Choice2Rotation = 180 AND ExcludeTrialGrasp = 0 AND Target = ' thisTarg];
    wherestring=['ExcludeSubject = 0 AND RespClass = "hit" AND Choice1Rotation IS NOT NULL AND Choice1Rotation = 0 AND ExcludeTrialGrasp = 0 AND (Target = ' targ1 ' OR Target = ' targ2 ')'];
%     wherestring=['ExcludeSubject = 0 AND RespClass = "hit" AND ExcludeTrialGrasp = 0 AND Target = ' thisTarg];

    trials=double(cell2mat(fetch(DataDB, ['Select UniqueTrial FROM trialsTable WHERE ' wherestring])));
    % end
    
    
    
    pile=zeros(500,500,size(trials,1));
    for ii=1:size(trials,1)
        
        trial=num2str(trials(ii));
        
        ind=double(cell2mat(fetch(TouchDB, ['Select ind FROM graspTouchTable' trial])));
        vals=double(cell2mat(fetch(TouchDB, ['Select value FROM graspTouchTable' trial])));
        
        f=zeros(500,500,1);
        
        f(ind)=vals;
        pile(:,:,ii)=f;
        %     figure; hold on; axis equal; colormap(gray); colorbar; axis tight; xticks([]); yticks([])
        %     imagesc(f)
    end
    
    %Control image
    
    pile2=zeros(500,500,size(trials,1));
    
    wherestring=['ExcludeSubject = 0 AND RespClass = "hit" AND Choice2Rotation IS NOT NULL AND Choice2Rotation = 0 AND ExcludeTrialGrasp = 0 AND (Target = ' targ1 ' OR Target = ' targ2 ')'];
    trials=double(cell2mat(fetch(DataDB, ['Select UniqueTrial FROM trialsTable WHERE ' wherestring])));
    
    
    for ii=1:size(trials,1)
        
        trial=num2str(trials(ii));
        
        ind=double(cell2mat(fetch(TouchDB, ['Select ind FROM graspTouchTable' trial])));
        vals=double(cell2mat(fetch(TouchDB, ['Select value FROM graspTouchTable' trial])));
        
        f=zeros(500,500,1);
        
        f(ind)=vals;
        pile2(:,:,ii)=f;
        %     figure; hold on; axis equal; colormap(gray); colorbar; axis tight; xticks([]); yticks([])
        %     imagesc(f)
    end
    
    
    if ~isempty(find(pile, 1))
        pile3=mean(pile,3)-mean(pile2,3);
        
        figure; 
        subplot(1,3,1); hold on; axis equal; colormap(gray); colorbar; axis tight; xticks([]); yticks([])
        imagesc(mean(pile,3))
        view(90,-90)
        drawnow
        
        subplot(1,3,2); hold on; axis equal; colormap(gray); colorbar; axis tight; xticks([]); yticks([])
        imagesc(mean(pile2,3))
        view(90,-90)
        drawnow
        
        subplot(1,3,3); hold on; axis equal; colormap(gray); colorbar; axis tight; xticks([]); yticks([])
        imagesc(mean(pile3,3))
        view(90,-90)
        drawnow
    end
end

close(TouchDB)
close(DataDB)



