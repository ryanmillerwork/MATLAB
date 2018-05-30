%% Compare all conditions separately
clear all
DataDB = sqlite('C:\Users\Ryan\Documents\Data\graspHuman.db');

%Congruent
wherestring='ExcludeSubject = 0 AND ExcludeTrialGrasp = 0 AND SubjectBlock = 1 AND FirstBlockType = "left" AND Congruent = 1';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitp1L = calcRespClassCorrectRate(vals);
rts=double(cell2mat(fetch(DataDB, ['Select GraspTime FROM trialsTable WHERE ' wherestring])));
rts1L=mean(rts);
rts1LS=std(rts)/sqrt(length(rts));

wherestring='ExcludeSubject = 0 AND ExcludeTrialGrasp = 0  AND SubjectBlock = 2 AND FirstBlockType = "left" AND Congruent = 1';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitp2L = calcRespClassCorrectRate(vals);
rts=double(cell2mat(fetch(DataDB, ['Select GraspTime FROM trialsTable WHERE ' wherestring])));
rts2L=mean(rts);
rts2LS=std(rts)/sqrt(length(rts));

wherestring='ExcludeSubject = 0 AND ExcludeTrialGrasp = 0  AND SubjectBlock = 3 AND FirstBlockType = "left" AND Congruent = 1';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitp3L = calcRespClassCorrectRate(vals);
rts=double(cell2mat(fetch(DataDB, ['Select GraspTime FROM trialsTable WHERE ' wherestring])));
rts3L=mean(rts);
rts3LS=std(rts)/sqrt(length(rts));

wherestring='ExcludeSubject = 0 AND ExcludeTrialGrasp = 0  AND SubjectBlock = 1 AND FirstBlockType = "right" AND Congruent = 1';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitp1R = calcRespClassCorrectRate(vals);
rts=double(cell2mat(fetch(DataDB, ['Select GraspTime FROM trialsTable WHERE ' wherestring])));
rts1R=mean(rts);
rts1RS=std(rts)/sqrt(length(rts));

wherestring='ExcludeSubject = 0 AND ExcludeTrialGrasp = 0  AND SubjectBlock = 2 AND FirstBlockType = "right" AND Congruent = 1';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitp2R = calcRespClassCorrectRate(vals);
rts=double(cell2mat(fetch(DataDB, ['Select GraspTime FROM trialsTable WHERE ' wherestring])));
rts2R=mean(rts);
rts2RS=std(rts)/sqrt(length(rts));

wherestring='ExcludeSubject = 0 AND ExcludeTrialGrasp = 0  AND SubjectBlock = 3 AND FirstBlockType = "right" AND Congruent = 1';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitp3R = calcRespClassCorrectRate(vals);
rts=double(cell2mat(fetch(DataDB, ['Select GraspTime FROM trialsTable WHERE ' wherestring])));
rts3R=mean(rts);
rts3RS=std(rts)/sqrt(length(rts));

%Incongruent
wherestring='ExcludeSubject = 0 AND ExcludeTrialGrasp = 0  AND SubjectBlock = 1 AND FirstBlockType = "left" AND Congruent = 0';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitp1Li = calcRespClassCorrectRate(vals);
rts=double(cell2mat(fetch(DataDB, ['Select GraspTime FROM trialsTable WHERE ' wherestring])));
rts1Li=mean(rts);
rts1LiS=std(rts)/sqrt(length(rts));

wherestring='ExcludeSubject = 0 AND ExcludeTrialGrasp = 0  AND SubjectBlock = 2 AND FirstBlockType = "left" AND Congruent = 0';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitp2Li = calcRespClassCorrectRate(vals);
rts=double(cell2mat(fetch(DataDB, ['Select GraspTime FROM trialsTable WHERE ' wherestring])));
rts2Li=mean(rts);
rts2LiS=std(rts)/sqrt(length(rts));

wherestring='ExcludeSubject = 0 AND ExcludeTrialGrasp = 0  AND SubjectBlock = 3 AND FirstBlockType = "left" AND Congruent = 0';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitp3Li = calcRespClassCorrectRate(vals);
rts=double(cell2mat(fetch(DataDB, ['Select GraspTime FROM trialsTable WHERE ' wherestring])));
rts3Li=mean(rts);
rts3LiS=std(rts)/sqrt(length(rts));

wherestring='ExcludeSubject = 0 AND ExcludeTrialGrasp = 0  AND SubjectBlock = 1 AND FirstBlockType = "right" AND Congruent = 0';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitp1Ri = calcRespClassCorrectRate(vals);
rts=double(cell2mat(fetch(DataDB, ['Select GraspTime FROM trialsTable WHERE ' wherestring])));
rts1Ri=mean(rts);
rts1RiS=std(rts)/sqrt(length(rts));

wherestring='ExcludeSubject = 0 AND ExcludeTrialGrasp = 0  AND SubjectBlock = 2 AND FirstBlockType = "right" AND Congruent = 0';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitp2Ri = calcRespClassCorrectRate(vals);
rts=double(cell2mat(fetch(DataDB, ['Select GraspTime FROM trialsTable WHERE ' wherestring])));
rts2Ri=mean(rts);
rts2RiS=std(rts)/sqrt(length(rts));

wherestring='ExcludeSubject = 0 AND ExcludeTrialGrasp = 0  AND SubjectBlock = 3 AND FirstBlockType = "right" AND Congruent = 0';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitp3Ri = calcRespClassCorrectRate(vals);
rts=double(cell2mat(fetch(DataDB, ['Select GraspTime FROM trialsTable WHERE ' wherestring])));
rts3Ri=mean(rts);
rts3RiS=std(rts)/sqrt(length(rts));

close(DataDB)

figure; 
subplot(2,2,1); hold on; ylim([0.85 1]); ylabel('p(correct)'); title('Congruent');  xlabel('Block'); xlim([0.6 3.4]); xticks([1 2 3])
plot([hitp1L hitp2L hitp3L],'k:')
plot([hitp1R hitp2R hitp3R],'k:')
scatter([1 2 3],[hitp1L hitp2R hitp3L],'g','MarkerFaceColor','g')
scatter([1 2 3],[hitp1R hitp2L hitp3R],'r','MarkerFaceColor','r')

subplot(2,2,3); hold on; ylabel('RT (ms)'); xlabel('Block'); ylim([1400 2400]);xlim([0.6 3.4]); xticks([1 2 3])
plot([rts1L rts2L rts3L],'k:')
plot([rts1R rts2R rts3R],'k:')
scatter([1 2 3],[rts1L rts2R rts3L],'g','MarkerFaceColor','g')
scatter([1 2 3],[rts1R rts2L rts3R],'r','MarkerFaceColor','r')
errorbar([1 2 3],[rts1L rts2L rts3L],[rts1LS rts2LS rts3LS],'k.')
errorbar([1 2 3],[rts1R rts2R rts3R],[rts1RS rts2RS rts3RS],'k.')

subplot(2,2,2); hold on; ylim([0.85 1]); ylabel('p(correct)'); title('Incongruent');  xlabel('Block'); xlim([0.6 3.4]); xticks([1 2 3])
plot([hitp1Li hitp2Li hitp3Li],'k:')
plot([hitp1Ri hitp2Ri hitp3Ri],'k:')
scatter([1 2 3],[hitp1Li hitp2Ri hitp3Li],'g','MarkerFaceColor','g')
scatter([1 2 3],[hitp1Ri hitp2Li hitp3Ri],'r','MarkerFaceColor','r')

subplot(2,2,4); hold on; ylabel('RT (ms)'); xlabel('Block'); ylim([1400 2400]); xlim([0.6 3.4]); xticks([1 2 3])
plot([rts1Li rts2Li rts3Li],'k:')
plot([rts1Ri rts2Ri rts3Ri],'k:')
scatter([1 2 3],[rts1Li rts2Ri rts3Li],'g','MarkerFaceColor','g')
scatter([1 2 3],[rts1Ri rts2Li rts3Ri],'r','MarkerFaceColor','r')
errorbar([1 2 3],[rts1Li rts2Li rts3Li],[rts1LiS rts2LiS rts3LiS],'k.')
errorbar([1 2 3],[rts1Ri rts2Ri rts3Ri],[rts1RiS rts2RiS rts3RiS],'k.')

%% Compare congruent vs. incongruent

clear 
DataDB = sqlite('C:\Users\Ryan\Documents\Data\graspHuman.db');

wherestring='ExcludeSubject = 0  AND ExcludeTrialGrasp = 0 AND SubjectBlock = 1 AND Congruent = 1';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitp1C = calcRespClassCorrectRate(vals);
a=double(cell2mat(fetch(DataDB, ['Select GraspTime FROM trialsTable WHERE ' wherestring])));
rts1C=mean(a);
rts1Csem=std(a)/sqrt(length(a));

wherestring='ExcludeSubject = 0 AND ExcludeTrialGrasp = 0  AND SubjectBlock = 2 AND Congruent = 1';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitp2C = calcRespClassCorrectRate(vals);
a=double(cell2mat(fetch(DataDB, ['Select GraspTime FROM trialsTable WHERE ' wherestring])));
rts2C=mean(a);
rts2Csem=std(a)/sqrt(length(a));

wherestring='ExcludeSubject = 0 AND ExcludeTrialGrasp = 0  AND SubjectBlock = 3 AND Congruent = 1';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitp3C = calcRespClassCorrectRate(vals);
a=double(cell2mat(fetch(DataDB, ['Select GraspTime FROM trialsTable WHERE ' wherestring])));
rts3C=mean(a);
rts3Csem=std(a)/sqrt(length(a));

wherestring='ExcludeSubject = 0 AND ExcludeTrialGrasp = 0  AND SubjectBlock = 1 AND Congruent = 0';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitp1I = calcRespClassCorrectRate(vals);
a=double(cell2mat(fetch(DataDB, ['Select GraspTime FROM trialsTable WHERE ' wherestring])));
rts1I=mean(a);
rts1Isem=std(a)/sqrt(length(a));

wherestring='ExcludeSubject = 0 AND ExcludeTrialGrasp = 0  AND SubjectBlock = 2 AND Congruent = 0';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitp2I = calcRespClassCorrectRate(vals);
a=double(cell2mat(fetch(DataDB, ['Select GraspTime FROM trialsTable WHERE ' wherestring])));
rts2I=mean(a);
rts2Isem=std(a)/sqrt(length(a));

wherestring='ExcludeSubject = 0 AND ExcludeTrialGrasp = 0  AND SubjectBlock = 3 AND Congruent = 0';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitp3I = calcRespClassCorrectRate(vals);
a=double(cell2mat(fetch(DataDB, ['Select GraspTime FROM trialsTable WHERE ' wherestring])));
rts3I=mean(a);
rts3Isem=std(a)/sqrt(length(a));

close(DataDB)

figure;

subplot(2,1,1); hold on; ylim([0.85 1]); xlim([0.6 3.4]); ylabel('p(correct)');  xlabel('Block'); xticks([1 2 3])
plot([hitp1C hitp2C hitp3C],'b:o')
plot([hitp1I hitp2I hitp3I],'k:o')
legend('Congruent','Incongruent')

subplot(2,1,2); hold on; ylabel('RT (ms)'); xlim([0.6 3.4]); xlabel('Block'); ylim([1400 2400]); xticks([1 2 3])
% plot([rts1C rts2C rts3C],'b:o')
% plot([rts1I rts2I rts3I],'k:o')
errorbar([rts1C rts2C rts3C],[rts1Csem rts2Csem rts3Csem],'b:o')
errorbar([rts1I rts2I rts3I],[rts1Isem rts2Isem rts3Isem],'k:o')
legend('Congruent','Incongruent')

%% Compare left and right hands

clear
DataDB = sqlite('C:\Users\Ryan\Documents\Data\graspHuman.db');

wherestring='ExcludeSubject = 0 AND ExcludeTrialGrasp = 0  AND Congruent = 1 AND TouchMode = "left"';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitpL = calcRespClassCorrectRate(vals);
a=double(cell2mat(fetch(DataDB, ['Select GraspTime FROM trialsTable WHERE ' wherestring])));
rtsL=mean(a);
rtsLsem=std(a)/sqrt(length(a));

wherestring='ExcludeSubject = 0 AND ExcludeTrialGrasp = 0  AND Congruent = 1 AND TouchMode = "right"';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitpR = calcRespClassCorrectRate(vals);
b=double(cell2mat(fetch(DataDB, ['Select GraspTime FROM trialsTable WHERE ' wherestring])));
rtsR=mean(b);
rtsRsem=std(b)/sqrt(length(b));

[h p]=ttest2(a,b)

close(DataDB)

figure;
subplot(2,1,1); hold on; ylim([0.94 0.96]); ylabel('p(correct)'); xlim([0 3]); xticks([1 2]); xticklabels({'Left','Right'})
bar([hitpL hitpR])

subplot(2,1,2); hold on; ylabel('RT (ms)'); xlim([0 3]); ylim([1700 1900]); xticks([1 2]); xticklabels({'Left','Right'})
errorbar([rtsL rtsR],[rtsLsem rtsRsem])

%% Plot rt vs cr for all subjects

clear
DataDB = sqlite('C:\Users\Ryan\Documents\Data\graspHuman.db');

wherestring='ExcludeSubject = 0';
subjects=unique(cellfun(@str2num,fetch(DataDB, ['Select Subject FROM trialsTable WHERE ' wherestring])));

results=[];
for i=1:size(subjects,1)
    
    wherestring=['ExcludeSubject = 0 AND ExcludeTrialGrasp = 0  AND subject = ' num2str(subjects(i))];
    vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
    hitpR = calcRespClassCorrectRate(vals);
    a=double(cell2mat(fetch(DataDB, ['Select GraspTime FROM trialsTable WHERE ' wherestring])));
    rtsR=mean(a);
    congs=double(cell2mat(fetch(DataDB, ['Select Congruent FROM trialsTable WHERE ' wherestring])));
    
    if hitpR==1
        num2str(subjects(i))
    end
    
    results=[results; hitpR rtsR congs(1)];
end
close(DataDB)

congs=results(results(:,3)==1,1:2);
incs=results(results(:,3)==0,1:2);

figure; hold on; xlabel('% Correct'); ylabel('RT (ms)')
scatter(congs(:,1),congs(:,2),'b','MarkerFaceColor','b')
scatter(incs(:,1),incs(:,2),'k','MarkerFaceColor','k')
legend('Congruent','Incongruent')


%Check out inverse efficiency score
results(:,4)=results(:,2)./(results(:,1) .^ 5);

[h p]=ttest2(results(results(:,3)==0,1),results(results(:,3)==1,1))

[h p]=ttest2(results(results(:,3)==0,2),results(results(:,3)==1,2))

[h p]=ttest2(results(results(:,3)==0,4),results(results(:,3)==1,4))



%% Compare performance at different relative angles

clear
DataDB = sqlite('C:\Users\Ryan\Documents\Data\graspHuman.db');

%Congruent, same object
wherestring='ExcludeSubject = 0 AND ExcludeTrialGrasp = 0  AND Congruent = 1 AND (RespClass = "hit" OR RespClass = "miss")';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitpC = calcRespClassCorrectRate(vals);
a=double(cell2mat(fetch(DataDB, ['Select GraspTime FROM trialsTable WHERE ' wherestring])));
rtsC=mean(a);
rtsCsem=std(a)/sqrt(length(a));

%Incongruent, same object
wherestring='ExcludeSubject = 0 AND Congruent = 0 AND (RespClass = "hit" OR RespClass = "miss") AND Choice1Rotation IS NOT NULL';
vals=fetch(DataDB, ['Select SampleRotation, Choice1Rotation, RespClass, GraspTime FROM trialsTable WHERE ' wherestring]);
wherestring='ExcludeSubject = 0 AND Congruent = 0 AND (RespClass = "hit" OR RespClass = "miss") AND Choice2Rotation IS NOT NULL';
vals=[vals; fetch(DataDB, ['Select SampleRotation, Choice2Rotation, RespClass, GraspTime FROM trialsTable WHERE ' wherestring])];

close(DataDB)

for i=1:size(vals,1)
    angle=double(abs(vals{i,1}-vals{i,2}));
    if angle==270
        angle=90;
    end
    vals(i,5)={angle};
end

rel=double(cell2mat(vals(:,5)));
angles=unique(rel);

figure; 
subplot(2,1,1); hold on; ylim([.8 1]); xlim([-10 200]); xlabel('Angle of disparity (deg)'); ylabel('Accuracy (%)'); xticks([0 90 180])
results=[];
for i=1:size(angles,1)
    these=vals(rel==angles(i),3);
    hitpI = calcRespClassCorrectRate(these);
    these=double(cell2mat(vals(rel==angles(i),4)));

    [h, p]=ttest2(a,these);

    results=[results; angles(i) hitpI mean(these) std(these)/sqrt(length(these)) p];
end
plot([-10 200],[hitpC hitpC],'b')
plot(results(:,1),results(:,2),'ko:')
legend('Congruent','Incongruent')

subplot(2,1,2); hold on; xlim([-10 200]);  xticks([0 90 180])

% plot([-10 200],[rtsC rtsC],'b')
plot([-10 200],[rtsC-rtsCsem rtsC-rtsCsem],'b')
errorbar([0 90 180],results(:,3),results(:,4),'ko:')
legend('Congruent','Incongruent')
plot([-10 200],[rtsC+rtsCsem rtsC+rtsCsem],'b')
plot(results(results(:,5) <0.05,1),results(results(:,5) <0.05,5) + 1450,'*')
plot(results(results(:,5) <0.01,1),results(results(:,5) <0.01,5) + 1450,'*r')

%% See if performance peak is reached in 4 blocks

clear 
DataDB = sqlite('C:\Users\Ryan\Documents\Data\graspHuman.db');

wherestring='ExcludeSubject = 0 AND ExcludeTrialGrasp = 0   AND SubjectBlock = 4 AND Congruent = 1';
subjects=unique(cellfun(@str2num,fetch(DataDB, ['Select Subject FROM trialsTable WHERE ' wherestring])));
subjects=[ones(length(subjects),1) subjects];
wherestring='ExcludeSubject = 0 AND ExcludeTrialGrasp = 0  AND SubjectBlock = 4 AND Congruent = 0';
subjects2=unique(cellfun(@str2num,fetch(DataDB, ['Select Subject FROM trialsTable WHERE ' wherestring])));
subjects=[subjects; zeros(length(subjects2),1) subjects2];


for i=1:size(subjects,1)
    s=num2str(subjects(i,2));
    firsth=[];
    firstr=[];
    for ii=1:4
        wherestring=['Subject = ' s ' AND SubjectBlock = ' num2str(ii)];
        vals=fetch(DataDB, ['Select RespClass, GraspTime FROM trialsTable WHERE ' wherestring]);
        hitpC = calcRespClassCorrectRate(vals(:,1));
        
        if isempty(firsth)
            firsth=hitpC;
            firstr=mean(cell2mat(vals(:,2)));
        end
        subjects(i,1+ii*2)=hitpC-firsth;
        subjects(i,2+ii*2)=mean(cell2mat(vals(:,2)))-firstr;            
    end
end

close(DataDB)



figure;
subplot(2,1,1); hold on; xlim([.4 4.4]);  xticks([1 2 3 4]); xlabel('Block'); ylabel('% Correct re: 1st block')
congs=subjects(subjects(:,1)==1, 3:2:end);
incs=subjects(subjects(:,1)==0, 3:2:end);
errorbar(mean(congs),std(congs)./sqrt(size(congs,1)),'b')
errorbar(mean(incs),std(incs)./sqrt(size(incs,1)),'k')
legend('Congruent','Incongruent')

subplot(2,1,2); hold on; xlim([.4 4.4]);  xticks([1 2 3 4]);  xlabel('Block'); ylabel('RT re: 1st block')
congs=subjects(subjects(:,1)==1, 4:2:end);
incs=subjects(subjects(:,1)==0, 4:2:end);
% plot(mean(congs),'b')
% plot(mean(incs),'k')

errorbar(mean(congs),std(congs)./sqrt(size(congs,1)),'b')
errorbar(mean(incs),std(incs)./sqrt(size(incs,1)),'k')
legend('Congruent','Incongruent')





%% Compare people based on instrument playing

clear 
DataDB = sqlite('C:\Users\Ryan\Documents\Data\graspHuman.db');

wherestring='ExcludeSubject = 0 AND ExcludeTrialGrasp = 0  AND Instrument = 1 AND Congruent = 1';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitpC1 = calcRespClassCorrectRate(vals);
a=double(cell2mat(fetch(DataDB, ['Select GraspTime FROM trialsTable WHERE ' wherestring])));
rtsC1=mean(a);
rtsC1sem=std(a)/sqrt(length(a));

wherestring='ExcludeSubject = 0 AND ExcludeTrialGrasp = 0  AND Instrument = 2 AND Congruent = 1';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitpC2 = calcRespClassCorrectRate(vals);
a=double(cell2mat(fetch(DataDB, ['Select GraspTime FROM trialsTable WHERE ' wherestring])));
rtsC2=mean(a);
rtsC2sem=std(a)/sqrt(length(a));

wherestring='ExcludeSubject = 0 AND ExcludeTrialGrasp = 0  AND Instrument = 3 AND Congruent = 1';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitpC3 = calcRespClassCorrectRate(vals);
a=double(cell2mat(fetch(DataDB, ['Select GraspTime FROM trialsTable WHERE ' wherestring])));
rtsC3=mean(a);
rtsC3sem=std(a)/sqrt(length(a));



wherestring='ExcludeSubject = 0 AND ExcludeTrialGrasp = 0  AND Instrument = 1 AND Congruent = 0';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitpI1 = calcRespClassCorrectRate(vals);
a=double(cell2mat(fetch(DataDB, ['Select GraspTime FROM trialsTable WHERE ' wherestring])));
rtsI1=mean(a);
rtsI1sem=std(a)/sqrt(length(a));

wherestring='ExcludeSubject = 0 AND ExcludeTrialGrasp = 0  AND Instrument = 2 AND Congruent = 0';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitpI2 = calcRespClassCorrectRate(vals);
a=double(cell2mat(fetch(DataDB, ['Select GraspTime FROM trialsTable WHERE ' wherestring])));
rtsI2=mean(a);
rtsI2sem=std(a)/sqrt(length(a));

wherestring='ExcludeSubject = 0 AND ExcludeTrialGrasp = 0  AND Instrument = 3 AND Congruent = 0';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitpI3 = calcRespClassCorrectRate(vals);
a=double(cell2mat(fetch(DataDB, ['Select GraspTime FROM trialsTable WHERE ' wherestring])));
rtsI3=mean(a);
rtsI3sem=std(a)/sqrt(length(a));


close(DataDB)



figure;
subplot(2,1,1); hold on; xlim([0.5 3.5]); xticks([1,2,3]); xticklabels({'Play currently','Played in past','Hasnt played'}); ylabel('% Correct')
plot([hitpC1 hitpC2 hitpC3],'b')
plot([hitpI1 hitpI2 hitpI3],'k')
legend('Congruent','Incongruent')

subplot(2,1,2); hold on; xlim([0.5 3.5]); xticks([1,2,3]); xticklabels({'Play currently','Played in past','Hasnt played'}); ylabel('Reaction time (ms)')
errorbar([rtsC1 rtsC2 rtsC3],[rtsC1sem rtsC2sem rtsC3sem],'b')
errorbar([rtsI1 rtsI2 rtsI3],[rtsI1sem rtsI2sem rtsI3sem],'k')
legend('Congruent','Incongruent')







%% Compare sexes

clear 
DataDB = sqlite('C:\Users\Ryan\Documents\Data\graspHuman.db');

wherestring='ExcludeSubject = 0 AND ExcludeTrialGrasp = 0  AND Sex = 0 AND Congruent = 1';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitpC1 = calcRespClassCorrectRate(vals);
a=double(cell2mat(fetch(DataDB, ['Select GraspTime FROM trialsTable WHERE ' wherestring])));
rtsC1=mean(a);
rtsC1sem=std(a)/sqrt(length(a));

wherestring='ExcludeSubject = 0 AND ExcludeTrialGrasp = 0  AND Sex = 1 AND Congruent = 1';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitpC2 = calcRespClassCorrectRate(vals);
a=double(cell2mat(fetch(DataDB, ['Select GraspTime FROM trialsTable WHERE ' wherestring])));
rtsC2=mean(a);
rtsC2sem=std(a)/sqrt(length(a));



wherestring='ExcludeSubject = 0 AND ExcludeTrialGrasp = 0  AND Sex = 0 AND Congruent = 0';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitpI1 = calcRespClassCorrectRate(vals);
a=double(cell2mat(fetch(DataDB, ['Select GraspTime FROM trialsTable WHERE ' wherestring])));
rtsI1=mean(a);
rtsI1sem=std(a)/sqrt(length(a));

wherestring='ExcludeSubject = 0 AND ExcludeTrialGrasp = 0  AND Sex = 1 AND Congruent = 0';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitpI2 = calcRespClassCorrectRate(vals);
a=double(cell2mat(fetch(DataDB, ['Select GraspTime FROM trialsTable WHERE ' wherestring])));
rtsI2=mean(a);
rtsI2sem=std(a)/sqrt(length(a));



close(DataDB)



figure;
subplot(2,1,1); hold on; xlim([0.5 2.5]); xticks([1,2]); xticklabels({'Female','Male'}); ylabel('% Correct')
plot([hitpC1 hitpC2],'b')
plot([hitpI1 hitpI2],'k')
legend('Congruent','Incongruent')

subplot(2,1,2); hold on; xlim([0.5 2.5]); xticks([1,2]); xticklabels({'Female','Male'}); ylabel('Reaction time (ms)')
errorbar([rtsC1 rtsC2],[rtsC1sem rtsC2sem],'b')
errorbar([rtsI1 rtsI2],[rtsI1sem rtsI2sem],'k')
legend('Congruent','Incongruent')






%% Compare people based on age

clear 
DataDB = sqlite('C:\Users\Ryan\Documents\Data\graspHuman.db');

wherestring='ExcludeSubject = 0 AND ExcludeTrialGrasp = 0  AND Age < 25 AND Congruent = 1';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitpC1 = calcRespClassCorrectRate(vals);
a=double(cell2mat(fetch(DataDB, ['Select GraspTime FROM trialsTable WHERE ' wherestring])));
rtsC1=mean(a);
rtsC1sem=std(a)/sqrt(length(a));

wherestring='ExcludeSubject = 0 AND ExcludeTrialGrasp = 0  AND Age >=25 AND Age <= 30 AND Congruent = 1';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitpC2 = calcRespClassCorrectRate(vals);
a=double(cell2mat(fetch(DataDB, ['Select GraspTime FROM trialsTable WHERE ' wherestring])));
rtsC2=mean(a);
rtsC2sem=std(a)/sqrt(length(a));

wherestring='ExcludeSubject = 0 AND ExcludeTrialGrasp = 0  AND Age > 30 AND Congruent = 1';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitpC3 = calcRespClassCorrectRate(vals);
a=double(cell2mat(fetch(DataDB, ['Select GraspTime FROM trialsTable WHERE ' wherestring])));
rtsC3=mean(a);
rtsC3sem=std(a)/sqrt(length(a));



wherestring='ExcludeSubject = 0 AND ExcludeTrialGrasp = 0  AND Age < 25 AND Congruent = 0';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitpI1 = calcRespClassCorrectRate(vals);
a=double(cell2mat(fetch(DataDB, ['Select GraspTime FROM trialsTable WHERE ' wherestring])));
rtsI1=mean(a);
rtsI1sem=std(a)/sqrt(length(a));

wherestring='ExcludeSubject = 0 AND ExcludeTrialGrasp = 0  AND Age >=25 AND Age <= 30 AND Congruent = 0';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitpI2 = calcRespClassCorrectRate(vals);
a=double(cell2mat(fetch(DataDB, ['Select GraspTime FROM trialsTable WHERE ' wherestring])));
rtsI2=mean(a);
rtsI2sem=std(a)/sqrt(length(a));

wherestring='ExcludeSubject = 0 AND ExcludeTrialGrasp = 0  AND  Age > 30 AND Congruent = 0';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitpI3 = calcRespClassCorrectRate(vals);
a=double(cell2mat(fetch(DataDB, ['Select GraspTime FROM trialsTable WHERE ' wherestring])));
rtsI3=mean(a);
rtsI3sem=std(a)/sqrt(length(a));


close(DataDB)



figure;
subplot(2,1,1); hold on; xlim([0.5 3.5]); xticks([1,2,3]); xticklabels({'Under 25','25 to 30','Over 30'}); ylabel('% Correct')
plot([hitpC1 hitpC2 hitpC3],'b')
plot([hitpI1 hitpI2 hitpI3],'k')
legend('Congruent','Incongruent')

subplot(2,1,2); hold on; xlim([0.5 3.5]); xticks([1,2,3]); xticklabels({'Under 25','25 to 30','Over 30'}); ylabel('Reaction time (ms)')
errorbar([rtsC1 rtsC2 rtsC3],[rtsC1sem rtsC2sem rtsC3sem],'b')
errorbar([rtsI1 rtsI2 rtsI3],[rtsI1sem rtsI2sem rtsI3sem],'k')
legend('Congruent','Incongruent')

%% Compare grasptime with reaction time

clear 
DataDB = sqlite('C:\Users\Ryan\Documents\Data\graspHuman.db');

vals=double(cell2mat(fetch(DataDB, 'Select ReactionTime, GraspTime FROM trialsTable WHERE ExcludeTrialGrasp = 0')));
trials=double(cell2mat(fetch(DataDB, 'Select UniqueTrial FROM trialsTable WHERE GraspTime < 200 AND ExcludeTrialGrasp = 0')));

close(DataDB)

figure; hold on; xlabel('Reaction time (ms)'); ylabel('Touch time (ms')

plot(vals(:,1),vals(:,2),'.')
plot([0 10000],[0 10000])

% hist(vals(:,2),200)




