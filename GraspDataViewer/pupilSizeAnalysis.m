clear all
DataDB = sqlite('C:\Users\Ryan\Documents\Data\graspHuman.db');

subjects=unique(cellfun(@str2num,fetch(DataDB, 'SELECT Subject FROM trialsTable')));

perfMat=nan(20,400,2);
subjectC=0;
trialC=0;
% figure; hold on;

trials=double(cell2mat(fetch(DataDB, 'SELECT UniqueTrial, StimOn, Answer, Response FROM trialsTable WHERE Subject != 1')));
trials(:,5)=trials(:,3)==trials(:,4);

pupils=nan(size(trials,1),4000);
figure; hold on;
for i=1:size(trials,1)
    pupil=cell2mat(fetch(DataDB, ['SELECT Pupil FROM eyeTable' num2str(trials(i)) ' WHERE Pupil IS NOT NULL']));
    first=1000-round(trials(i,2)/20);
    last=first+length(pupil)-1;
    pupils(i,first:last)=pupil;
end

close(DataDB)
    

plot(-5000:5:14999,nanmean(pupils))
xlim([-500 10000]); ylabel('Pupil size'); xlabel('Time re: stim onset')