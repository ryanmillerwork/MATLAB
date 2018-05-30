clear all
DataDB = sqlite('C:\Users\Ryan\Documents\Data\graspHuman.db');

subjects=unique(cellfun(@str2num,fetch(DataDB, 'SELECT Subject FROM trialsTable')));

perfMat=nan(20,400,2);
subjectC=0;
trialC=0;
% figure; hold on;
for subject=subjects'
    if subject==1
        continue;
    end
    subjectC=subjectC+1;
    trialC=0;
%     resmat=[];
    trials=double(cell2mat(fetch(DataDB, ['SELECT Block, Answer, Response, ReactionTime, Congruent FROM trialsTable WHERE Subject = "' num2str(subject) '"'])));
    tm=fetch(DataDB, ['SELECT TouchMode FROM trialsTable WHERE Subject = "' num2str(subject) '"']);

    blocks=unique(trials(:,1));
    for i=1:size(blocks,1)
        these=trials(trials(:,1)==blocks(i),:);

        for ii=1:size(these,1)
            trialC=trialC+1;
%             pc=sum(these(ii-9:ii,2)==these(ii-9:ii,3))/10;
            first=max([ii-10 1]);
            last=min([ii+10 size(these,1)]);
            pc=sum(these(first:last,2)==these(first:last,3))/(last-first+1);
            RT=mean(these(first:last,4));
            cong=sum(these(:,5))/size(these,1);
        if cong
%             plot(pc,RT,'.r')
            perfMat(subjectC,trialC,1)=pc;
        else
            perfMat(subjectC,trialC,2)=pc;
        end
%         perfMat=[perfMat; subject pc RT cong];
        end
    end
%     if ~isempty(resmat)
%         plot(resmat(:,2))
%     end
end

cong=perfMat(:,:,1);
inc=perfMat(:,:,2);

cong=cong(~isnan(cong(:,1)),:);
inc=inc(~isnan(inc(:,1)),:);

figure; hold on; xlim([0 84*3])

plot(nanmean(cong),'b')
plot(nanmean(cong)+nanstd(cong)./sqrt(size(cong,1)),'b:')
plot(nanmean(cong)-nanstd(cong)./sqrt(size(cong,1)),'b:')

plot(nanmean(inc),'r')
plot(nanmean(inc)+nanstd(inc)./sqrt(size(inc,1)),'r:')
plot(nanmean(inc)-nanstd(inc)./sqrt(size(inc,1)),'r:')

plot([84 84],[2000 5000],'k:')
plot([168 168],[2000 5000],'k:')

return

figure; hold on; 
for i=1:size(perfMat,1)
    if perfMat(i,4)
        plot(perfMat(i,2),perfMat(i,3),'og')
    else
        plot(perfMat(i,2),perfMat(i,3),'ob')
    end



end