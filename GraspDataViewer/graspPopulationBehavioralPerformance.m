clear all
ObjectsDB = sqlite('L:\stimuli\grasp\objects.db');
DataDB = sqlite('C:\Users\Ryan\Documents\Data\graspHuman.db');

% %% Create local list of important parameters
% llist=fetch(DataDB, 'SELECT UniqueTrial, Subject, Date, Block, Trial, Answer, Response, TouchMode, SampleMode, SampleID, SampleRotation, Choice1ID, Choice1Rotation FROM trialsTable WHERE Choice1ID IS NOT NULL');
% rlist=fetch(DataDB, 'SELECT UniqueTrial, Subject, Date, Block, Trial, Answer, Response, TouchMode, SampleMode, SampleID, SampleRotation, Choice2ID, Choice2Rotation FROM trialsTable WHERE Choice2ID IS NOT NULL');
% llist=[llist; rlist];
% clear rlist
% 
% for i=1:size(llist,1)
%     if strcmp(llist{i,8},'right') == llist{i,6}
%         llist(i,14)={1}; %means visual and haptic objects match
%     else
%         llist(i,14)={0};%means visual and haptic objects don't match
%     end
% end
% 
% blocks=unique(cell2mat(llist(:,3:4)),'rows'); % unique day & block
% 
% for i=1:size(blocks,1)
%     these=double(cell2mat(llist((cell2mat(llist(:,3))==blocks(i,1)) & (cell2mat(llist(:,4))==blocks(i,2)),[11 13])));
%     rows=find((cell2mat(llist(:,3))==blocks(i,1)) & (cell2mat(llist(:,4))==blocks(i,2)));
%     if (sum(these(:,1) == these(:,2))) == size(these,1)
%         llist(rows,15)={1}; %means this is a congruent block
%     else
%         llist(rows,15)={0}; %means non-congruent block
%     end
% end
% 
% clear rows these i blocks

%% create list of duplicate objects
% fetch(ObjectsDB, ['SELECT blobName, COUNT(*) c FROM objectsTable GROUP BY blobName HAVING c > 1'])
% fetch(ObjectsDB, ['SELECT blobName, unitsPerMM, pointsPerRad, nContacts, slotDepth, slotWidth, maxWidth, symmetric, pair, leftPair, COUNT(*) c FROM objectsTable GROUP BY blobName, unitsPerMM, pointsPerRad, nContacts, slotDepth, slotWidth, maxWidth, symmetric, pair, leftPair HAVING c > 1'])
groupsFull=fetch(ObjectsDB, ['SELECT GROUP_CONCAT(blobID), blobName, unitsPerMM, pointsPerRad, nContacts, slotDepth, slotWidth, maxWidth, symmetric, pair, leftPair, COUNT(*) c FROM objectsTable GROUP BY blobName, unitsPerMM, pointsPerRad, nContacts, slotDepth, slotWidth, maxWidth, symmetric, pair, leftPair HAVING c > 1']);
groups=nan(size(groupsFull,1),2);
for i=1:size(groupsFull,1)
   this=strsplit(groupsFull{i,1} ,',');
    for ii=1:size(this,2)
        groups(i,ii)=str2double(this{ii});
    end
end
clear groupsFull i ii this

%% Go through all combinations
tic
results=[];
for objectIDV=groups(:,1)'
    for objectIDH=groups(:,1)'
        [row, ~]=find(groups==objectIDV);
        ov1=groups(row,1);
        ov2=groups(row,2);
        [row, ~]=find(groups==objectIDH);
        oh1=groups(row,1);
        oh2=groups(row,2);
        
        trials=double(cell2mat(fetch(DataDB, ['SELECT UniqueTrial FROM trialsTable WHERE (SampleID = "' num2str(ov1) '" OR SampleID = "' num2str(ov2) '") AND (Choice1ID = "' num2str(oh1) '"  OR Choice1ID = "' num2str(oh2) '") AND Congruent = "1"'])));
        rts=[];
        for i=1:size(trials,1)
            rts=[rts; double(cell2mat(fetch(DataDB, ['SELECT ReactionTime FROM trialsTable WHERE UniqueTrial = "' num2str(trials(i)) '"'])))];            
        end
        results=[results; objectIDV objectIDH mean(rts) std(rts)./sqrt(length(rts)) length(rts)];
    end
end

results=results(~isnan(results(:,3)),:);

%reshape
ids=unique(results(:,1:2));
resultMat=[];
for i=1:size(ids,1)
    for ii=1:size(ids,1)
        resultMat(i,ii)=results(results(:,1)==ids(i) & results(:,2)==ids(ii),3);
        
    end
end

figure; hold on;
imagesc(resultMat,[2000 6000])
colorbar
xticklabels({'', ids(1), ids(2), ids(3), ids(4), ids(5), ids(6), ids(7), ''})
yticklabels({'', ids(1), ids(2), ids(3), ids(4), ids(5), ids(6), ids(7), ''})



toc

close(ObjectsDB)
close(DataDB)

return
a=mean(resultMat);
[~, c]=sort(a);

rmsc=resultMat(:,c);

figure; hold on;
imagesc(rmsc,[2000 6000])
colorbar
xticklabels({'', ids(c(1)), ids(c(2)), ids(c(3)), ids(c(4)), ids(c(5)), ids(c(6)), ids(c(7)), ''})
yticklabels({'', ids(1), ids(2), ids(3), ids(4), ids(5), ids(6), ids(7), ''})




