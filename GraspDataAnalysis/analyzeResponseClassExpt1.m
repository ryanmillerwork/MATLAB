%% Compare all conditions separately
clear all
DataDB = sqlite('C:\Users\Ryan\Documents\Data\graspHuman.db');

%Predictable
wherestring='Expt = 1 AND ExcludeSubject = 0 AND SubjectBlock = 1 AND FirstBlockType = "left" AND Congruent = 1';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitp1L = calcRespClassCorrectRate(vals);
rts=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
rts1L=mean(rts);
rts1LS=std(rts)/sqrt(length(rts));

wherestring='Expt = 1 AND ExcludeSubject = 0 AND SubjectBlock = 2 AND FirstBlockType = "left" AND Congruent = 1';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitp2L = calcRespClassCorrectRate(vals);
rts=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
rts2L=mean(rts);
rts2LS=std(rts)/sqrt(length(rts));

wherestring='Expt = 1 AND ExcludeSubject = 0 AND SubjectBlock = 3 AND FirstBlockType = "left" AND Congruent = 1';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitp3L = calcRespClassCorrectRate(vals);
rts=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
rts3L=mean(rts);
rts3LS=std(rts)/sqrt(length(rts));

wherestring='Expt = 1 AND ExcludeSubject = 0 AND SubjectBlock = 1 AND FirstBlockType = "right" AND Congruent = 1';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitp1R = calcRespClassCorrectRate(vals);
rts=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
rts1R=mean(rts);
rts1RS=std(rts)/sqrt(length(rts));

wherestring='Expt = 1 AND ExcludeSubject = 0 AND SubjectBlock = 2 AND FirstBlockType = "right" AND Congruent = 1';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitp2R = calcRespClassCorrectRate(vals);
rts=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
rts2R=mean(rts);
rts2RS=std(rts)/sqrt(length(rts));

wherestring='Expt = 1  AND ExcludeSubject = 0 AND SubjectBlock = 3 AND FirstBlockType = "right" AND Congruent = 1';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitp3R = calcRespClassCorrectRate(vals);
rts=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
rts3R=mean(rts);
rts3RS=std(rts)/sqrt(length(rts));

%Unpredictable
wherestring='Expt = 1  AND ExcludeSubject = 0 AND SubjectBlock = 1 AND FirstBlockType = "left" AND Congruent = 0';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitp1Li = calcRespClassCorrectRate(vals);
rts=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
rts1Li=mean(rts);
rts1LiS=std(rts)/sqrt(length(rts));

wherestring='Expt = 1  AND ExcludeSubject = 0 AND SubjectBlock = 2 AND FirstBlockType = "left" AND Congruent = 0';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitp2Li = calcRespClassCorrectRate(vals);
rts=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
rts2Li=mean(rts);
rts2LiS=std(rts)/sqrt(length(rts));

wherestring='Expt = 1  AND ExcludeSubject = 0 AND SubjectBlock = 3 AND FirstBlockType = "left" AND Congruent = 0';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitp3Li = calcRespClassCorrectRate(vals);
rts=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
rts3Li=mean(rts);
rts3LiS=std(rts)/sqrt(length(rts));

wherestring='Expt = 1  AND ExcludeSubject = 0 AND SubjectBlock = 1 AND FirstBlockType = "right" AND Congruent = 0';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitp1Ri = calcRespClassCorrectRate(vals);
rts=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
rts1Ri=mean(rts);
rts1RiS=std(rts)/sqrt(length(rts));

wherestring='Expt = 1  AND ExcludeSubject = 0 AND SubjectBlock = 2 AND FirstBlockType = "right" AND Congruent = 0';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitp2Ri = calcRespClassCorrectRate(vals);
rts=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
rts2Ri=mean(rts);
rts2RiS=std(rts)/sqrt(length(rts));

wherestring='Expt = 1  AND ExcludeSubject = 0 AND SubjectBlock = 3 AND FirstBlockType = "right" AND Congruent = 0';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitp3Ri = calcRespClassCorrectRate(vals);
rts=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
rts3Ri=mean(rts);
rts3RiS=std(rts)/sqrt(length(rts));

close(DataDB)

figure; 
subplot(2,2,1); hold on; ylim([0.85 1]); ylabel('p(correct)'); title('Predictable');  xlabel('Block'); xlim([0.6 3.4]); xticks([1 2 3])
plot([hitp1L hitp2L hitp3L],'k:')
plot([hitp1R hitp2R hitp3R],'k:')
scatter([1 2 3],[hitp1L hitp2R hitp3L],'g','MarkerFaceColor','g')
scatter([1 2 3],[hitp1R hitp2L hitp3R],'r','MarkerFaceColor','r')

subplot(2,2,3); hold on; ylabel('RT (ms)'); xlabel('Block'); ylim([2400 3400]);xlim([0.6 3.4]); xticks([1 2 3])
plot([rts1L rts2L rts3L],'k:')
plot([rts1R rts2R rts3R],'k:')
scatter([1 2 3],[rts1L rts2R rts3L],'g','MarkerFaceColor','g')
scatter([1 2 3],[rts1R rts2L rts3R],'r','MarkerFaceColor','r')
errorbar([1 2 3],[rts1L rts2L rts3L],[rts1LS rts2LS rts3LS],'k.')
errorbar([1 2 3],[rts1R rts2R rts3R],[rts1RS rts2RS rts3RS],'k.')

subplot(2,2,2); hold on; ylim([0.85 1]); ylabel('p(correct)'); title('Unpredictable');  xlabel('Block'); xlim([0.6 3.4]); xticks([1 2 3])
plot([hitp1Li hitp2Li hitp3Li],'k:')
plot([hitp1Ri hitp2Ri hitp3Ri],'k:')
scatter([1 2 3],[hitp1Li hitp2Ri hitp3Li],'g','MarkerFaceColor','g')
scatter([1 2 3],[hitp1Ri hitp2Li hitp3Ri],'r','MarkerFaceColor','r')

subplot(2,2,4); hold on; ylabel('RT (ms)'); xlabel('Block'); ylim([2400 3400]); xlim([0.6 3.4]); xticks([1 2 3])
plot([rts1Li rts2Li rts3Li],'k:')
plot([rts1Ri rts2Ri rts3Ri],'k:')
scatter([1 2 3],[rts1Li rts2Ri rts3Li],'g','MarkerFaceColor','g')
scatter([1 2 3],[rts1Ri rts2Li rts3Ri],'r','MarkerFaceColor','r')
errorbar([1 2 3],[rts1Li rts2Li rts3Li],[rts1LiS rts2LiS rts3LiS],'k.')
errorbar([1 2 3],[rts1Ri rts2Ri rts3Ri],[rts1RiS rts2RiS rts3RiS],'k.')

%% Compare Predictable vs. Unpredictable

clear 
DataDB = sqlite('C:\Users\Ryan\Documents\Data\graspHuman.db');

wherestring='Expt = 1  AND ExcludeSubject = 0 AND SubjectBlock = 1 AND Congruent = 1';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitp1C = calcRespClassCorrectRate(vals);
a=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
rts1C=mean(a);
rts1Csem=std(a)/sqrt(length(a));

wherestring='Expt = 1  AND ExcludeSubject = 0 AND SubjectBlock = 2 AND Congruent = 1';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitp2C = calcRespClassCorrectRate(vals);
a=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
rts2C=mean(a);
rts2Csem=std(a)/sqrt(length(a));

wherestring='Expt = 1  AND ExcludeSubject = 0 AND SubjectBlock = 3 AND Congruent = 1';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitp3C = calcRespClassCorrectRate(vals);
a=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
rts3C=mean(a);
rts3Csem=std(a)/sqrt(length(a));

wherestring='Expt = 1  AND ExcludeSubject = 0 AND SubjectBlock = 1 AND Congruent = 0';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitp1I = calcRespClassCorrectRate(vals);
a=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
rts1I=mean(a);
rts1Isem=std(a)/sqrt(length(a));

wherestring='Expt = 1  AND ExcludeSubject = 0 AND SubjectBlock = 2 AND Congruent = 0';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitp2I = calcRespClassCorrectRate(vals);
a=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
rts2I=mean(a);
rts2Isem=std(a)/sqrt(length(a));

wherestring='Expt = 1  AND ExcludeSubject = 0 AND SubjectBlock = 3 AND Congruent = 0';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitp3I = calcRespClassCorrectRate(vals);
a=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
rts3I=mean(a);
rts3Isem=std(a)/sqrt(length(a));

close(DataDB)

figure;

subplot(2,1,1); hold on; ylim([0.85 1]); xlim([0.6 3.4]); ylabel('p(correct)');  xlabel('Block'); xticks([1 2 3])
plot([hitp1C hitp2C hitp3C],'b:.','MarkerSize',20)
plot([hitp1I hitp2I hitp3I],'k:.','MarkerSize',20)
legend('Predictable','Unpredictable')

subplot(2,1,2); hold on; ylabel('RT (ms)'); xlim([0.6 3.4]); xlabel('Block'); ylim([2400 3400]); xticks([1 2 3])
% plot([rts1C rts2C rts3C],'b:o')
% plot([rts1I rts2I rts3I],'k:o')
errorbar([rts1C rts2C rts3C],[rts1Csem rts2Csem rts3Csem],'b:.','MarkerSize',20)
errorbar([rts1I rts2I rts3I],[rts1Isem rts2Isem rts3Isem],'k:.','MarkerSize',20)
legend('Predictable','Unpredictable')

%% Compare left and right hands

clear
DataDB = sqlite('C:\Users\Ryan\Documents\Data\graspHuman.db');

wherestring='Expt = 1  AND ExcludeSubject = 0 AND Congruent = 1 AND TouchMode = "left"';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitpL = calcRespClassCorrectRate(vals);
a=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
rtsL=mean(a);
rtsLsem=std(a)/sqrt(length(a));

wherestring='Expt = 1  AND ExcludeSubject = 0 AND Congruent = 1 AND TouchMode = "right"';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitpR = calcRespClassCorrectRate(vals);
a=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
rtsR=mean(a);
rtsRsem=std(a)/sqrt(length(a));

close(DataDB)

figure;
subplot(2,1,1); hold on; ylim([94 96]); ylabel('p(correct)'); xlim([0 3]); xticks([1 2]); xticklabels({'Left','Right'})
bar([hitpL*100 hitpR*100],'Facecolor','w')

subplot(2,1,2); hold on; ylabel('RT (ms)'); xlim([0 3]); ylim([2600 2800]); xticks([1 2]); xticklabels({'Left','Right'})
bar([rtsL rtsR],'Facecolor','w')
errorbar([rtsL rtsR],[rtsLsem rtsRsem],'k.')

%% Plot rt vs cr for all subjects

clear
DataDB = sqlite('C:\Users\Ryan\Documents\Data\graspHuman.db');

wherestring='ExcludeSubject = 0';
subjects=unique(cellfun(@str2num,fetch(DataDB, ['Select Subject FROM trialsTable WHERE ' wherestring])));

results=[];
for i=1:size(subjects,1)
    
    wherestring=['Expt = 1  AND ExcludeSubject = 0 AND subject = ' num2str(subjects(i))];
    vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
    if isempty(vals)
        continue;
    end
    hitpR = calcRespClassCorrectRate(vals);
    a=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
    rtsR=mean(a);
    congs=double(cell2mat(fetch(DataDB, ['Select Congruent FROM trialsTable WHERE ' wherestring])));
    
    results=[results; hitpR rtsR congs(1)];
end
close(DataDB)

congs=results(results(:,3)==1,1:2);
incs=results(results(:,3)==0,1:2);

figure; hold on; xlabel('% Correct'); ylabel('RT (ms)')
scatter(congs(:,1),congs(:,2),'b','MarkerFaceColor','b')
scatter(incs(:,1),incs(:,2),'k','MarkerFaceColor','k')
legend('Predictable','Unpredictable')


%Check out inverse efficiency score
results(:,4)=results(:,2)./(results(:,1) .^ 5);

[h p]=ttest2(results(results(:,3)==0,1),results(results(:,3)==1,1))

[h p]=ttest2(results(results(:,3)==0,2),results(results(:,3)==1,2))

[h p]=ttest2(results(results(:,3)==0,4),results(results(:,3)==1,4))



%% Compare performance at different relative angles

clear
DataDB = sqlite('C:\Users\Ryan\Documents\Data\graspHuman.db');

%Predictable, same object
wherestring='Expt = 1  AND ExcludeSubject = 0  AND Congruent = 1 AND (RespClass = "hit" OR RespClass = "miss")';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitpC = calcRespClassCorrectRate(vals);
a=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
rtsC=mean(a);
rtsCsem=std(a)/sqrt(length(a));

%Unpredictable, same object
wherestring='Expt = 1  AND ExcludeSubject = 0 AND Congruent = 0 AND (RespClass = "hit" OR RespClass = "miss") AND Choice1Rotation IS NOT NULL';
vals=fetch(DataDB, ['Select SampleRotation, Choice1Rotation, RespClass, ReactionTime FROM trialsTable WHERE ' wherestring]);
wherestring='Expt = 1  AND ExcludeSubject = 0 AND Congruent = 0 AND (RespClass = "hit" OR RespClass = "miss") AND Choice2Rotation IS NOT NULL';
vals=[vals; fetch(DataDB, ['Select SampleRotation, Choice2Rotation, RespClass, ReactionTime FROM trialsTable WHERE ' wherestring])];

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


results=[];
for i=1:size(angles,1)
    these=vals(rel==angles(i),3);
    hitpI = calcRespClassCorrectRate(these);
    these=double(cell2mat(vals(rel==angles(i),4)));

    [h, p]=ttest2(a,these);

    results=[results; angles(i) hitpI mean(these) std(these)/sqrt(length(these)) p];
end

figure; 
% subplot(2,1,1); hold on; ylim([.8 1]); xlim([-10 200]); xlabel('Angle of disparity (deg)'); ylabel('Accuracy (%)'); xticks([0 90 180])
subplot(2,1,1); hold on; ylim([80 100]); xlabel('Angle of disparity (deg)'); ylabel('Accuracy (%)'); xticks([1 2 3 4]); xticklabels({'0', '0','90','180'})
% plot([-10 200],[hitpC hitpC],'b')
% plot(results(:,1),results(:,2),'ko:')

bar([hitpC*100 results(:,2)'*100],'FaceColor','w')

% legend('Predictable','Unpredictable')

subplot(2,1,2); hold on; ylabel('Reaction time (ms)'); xticks([1 2 3 4]); xticklabels({'0', '0','90','180'}); ylim([2400 3000])

bar([rtsC results(:,3)'],'FaceColor','w')
errorbar([rtsC results(:,3)'],[rtsCsem results(:,4)'],'k.')

% plot([-10 200],[rtsC rtsC],'b')
% plot([-10 200],[rtsC-rtsCsem rtsC-rtsCsem],'b')
% errorbar([0 90 180],results(:,3),results(:,4),'ko:')
% legend('Predictable','Unpredictable')
% plot([-10 200],[rtsC+rtsCsem rtsC+rtsCsem],'b')
% plot(results(results(:,5) <0.05,1),results(results(:,5) <0.05,5) + 2450,'*')
% plot(results(results(:,5) <0.01,1),results(results(:,5) <0.01,5) + 2450,'*r')

%% Compare predictable and unpredictable at zero degrees difference

clear
DataDB = sqlite('C:\Users\Ryan\Documents\Data\graspHuman.db');

%Predictable, same object
wherestring='Expt = 1 AND ExcludeSubject = 0 AND Congruent = 1 AND Aligned = 1';
p=double(cell2mat(fetch(DataDB, ['Select SubjectBlock, Trial, ReactionTime FROM trialsTable WHERE ' wherestring])));

%Unpredictable, same object, same orientation
wherestring='Expt = 1 AND ExcludeSubject = 0 AND Congruent = 0 AND Choice1Rotation IS NOT NULL AND Aligned = 1';
u=fetch(DataDB, ['Select SubjectBlock, Trial, ReactionTime FROM trialsTable WHERE ' wherestring]);
wherestring='Expt = 1 AND ExcludeSubject = 0 AND Congruent = 0 AND Choice2Rotation IS NOT NULL AND Aligned = 1';
u=[u; fetch(DataDB, ['Select SubjectBlock, Trial, ReactionTime FROM trialsTable WHERE ' wherestring])];

%Unpredictable, same object, different orientation
wherestring='Expt = 1 AND ExcludeSubject = 0 AND Congruent = 0 AND (RespClass = "hit" OR RespClass = "miss") AND Choice1Rotation IS NOT NULL AND Aligned = 0';
ud=fetch(DataDB, ['Select SubjectBlock, Trial, ReactionTime FROM trialsTable WHERE ' wherestring]);
wherestring='Expt = 1 AND ExcludeSubject = 0 AND Congruent = 0 AND (RespClass = "hit" OR RespClass = "miss") AND Choice2Rotation IS NOT NULL AND Aligned = 0';
ud=[ud; fetch(DataDB, ['Select SubjectBlock, Trial, ReactionTime FROM trialsTable WHERE ' wherestring])];

close(DataDB)
%Add column showing trial number overall for that subject
p(:,4)=p(:,2)+((p(:,1)-1)*85);

u=double(cell2mat(u));
ud=double(cell2mat(ud));

u(:,4)=u(:,2)+((u(:,1)-1)*85);
ud(:,4)=ud(:,2)+((ud(:,1)-1)*85);

step=1;
window=20;

ma=[];
for i=window:step:84*3-window
    ps=p(p(:,4)>(i-window) & p(:,4)<(i+window),3);
    us=u(u(:,4)>(i-window) & u(:,4)<(i+window),3);
    uds=ud(ud(:,4)>(i-window) & ud(:,4)<(i+window),3);
    ma=[ma; i mean(ps) mean(us) mean(uds)];
end

figure; hold on; ylabel('Mean reaction time'); xlabel('Subjects trial #'); title('Reaction time for aligned trials')
plot(ma(:,1),ma(:,2),'b')
plot(ma(:,1),ma(:,3),'k')
plot(ma(:,1),ma(:,4),'k:')
plot([83 83],[2200 3600],'k:')
plot([167 167],[2200 3600],'k:')
legend('Predictable','Unpredictable aligned','Unpredictable misaligned')
text(30,2300,'Block 1')
text(115,2300,'Block 2')
text(200,2300,'Block 3')

%% Compare reaction time of different trial outcomes (hit, miss, etc)

clear
DataDB = sqlite('C:\Users\Ryan\Documents\Data\graspHuman.db');

wherestring='Expt = 1  AND ExcludeSubject = 0 AND Congruent = 0 AND RespClass = "hit"';
valsCH=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));

wherestring='Expt = 1  AND ExcludeSubject = 0 AND Congruent = 0 AND RespClass = "miss"';
valsCM=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));

wherestring='Expt = 1  AND ExcludeSubject = 0 AND Congruent = 0 AND RespClass = "fa"';
valsCF=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));

wherestring='Expt = 1  AND ExcludeSubject = 0 AND Congruent = 0 AND RespClass = "cr"';
valsCC=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
close(DataDB)

valsCHM=mean(valsCH);
valsCMM=mean(valsCM);
valsCFM=mean(valsCF);
valsCCM=mean(valsCC);

valsCHS=std(valsCH)/sqrt(length(valsCH));
valsCMS=std(valsCM)/sqrt(length(valsCM));
valsCFS=std(valsCF)/sqrt(length(valsCF));
valsCCS=std(valsCC)/sqrt(length(valsCC));



figure; hold on; xticks([1 2 3 4]); xticklabels({'Hit','Miss','Correct rejection','False alarm'}); title('Unpredictable'); ylabel('Reaction time')
bar([valsCHM valsCMM valsCCM valsCFM])
errorbar([valsCHM valsCMM valsCCM valsCFM],[valsCHS valsCMS valsCCS  valsCFS],'.')

[h, p]=ttest2(valsCM,valsCF);
plot([2 4],[4000 4000],'k')
if h
    if p < 0.01
        plot(3,4000,'r*')
    else
        plot(3,4000,'k*')
    end
else
    plot(3,4000,'ko')
end

[h, p]=ttest2(valsCH,valsCC);
plot([1 3],[4100 4100],'k')
if h
    if p < 0.01
        plot(2,4100,'r*')
    else
        plot(2,4100,'k*')
    end
else
    plot(2,4100,'ko')
end



%% Compare reaction time of different trial outcomes (hit, miss, etc) for a given object

clear
DataDB = sqlite('C:\Users\Ryan\Documents\Data\graspHuman.db');

targets=double(cell2mat(fetch(DataDB, 'Select Target FROM trialsTable')));
targets=unique(targets);

results=[];
for i=1:size(targets,1)
    thisTarg=num2str(targets(i));
    
    wherestring=['Expt = 1  AND ExcludeSubject = 0 AND Congruent = 1 AND RespClass = "hit" AND Target = ' thisTarg];
    valsHC=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
    
    wherestring=['Expt = 1  AND ExcludeSubject = 0 AND Congruent = 1 AND RespClass = "miss" AND Target = ' thisTarg];
    valsMC=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
    
    wherestring=['Expt = 1  AND ExcludeSubject = 0 AND Congruent = 0 AND RespClass = "hit" AND Target = ' thisTarg];
    valsHI=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
    
    wherestring=['Expt = 1  AND ExcludeSubject = 0 AND Congruent = 0 AND RespClass = "miss" AND Target = ' thisTarg];
    valsMI=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));

    results=[results; str2double(thisTarg) mean(valsMC)-mean(valsHC) mean(valsMI)-mean(valsHI)];
end
close(DataDB)
figure; hold on; xlim([0.6 2.4]); xticks([1 2]); xticklabels({'Hit','Miss'}); ylabel('Reaction time (ms)'); title('Shape-based difference in reaction times'); ylim([-50 400])
errorbar([0 nanmean(results(:,2))],[0 nanstd(results(:,2))/sqrt(size(results,1))],'b')
errorbar([0 nanmean(results(:,3))],[0 nanstd(results(:,3))/sqrt(size(results,1))],'k')
legend({'Predictable','Unpredictable'})

[h p]=ttest(results(:,2))
%% See if performance peak is reached in 4 blocks

clear 
DataDB = sqlite('C:\Users\Ryan\Documents\Data\graspHuman.db');

wherestring='Expt = 1  AND ExcludeSubject = 0 AND SubjectBlock = 4 AND Congruent = 1';
subjects=unique(cellfun(@str2num,fetch(DataDB, ['Select Subject FROM trialsTable WHERE ' wherestring])));
subjects=[ones(length(subjects),1) subjects];
wherestring='Expt = 1  AND ExcludeSubject = 0 AND SubjectBlock = 4 AND Congruent = 0';
subjects2=unique(cellfun(@str2num,fetch(DataDB, ['Select Subject FROM trialsTable WHERE ' wherestring])));
subjects=[subjects; zeros(length(subjects2),1) subjects2];

for i=1:size(subjects,1)
    s=num2str(subjects(i,2));
    firsth=[];
    firstr=[];
    for ii=1:4
        wherestring=['Expt = 1  AND Subject = ' s ' AND SubjectBlock = ' num2str(ii)];
        vals=fetch(DataDB, ['Select RespClass, ReactionTime FROM trialsTable WHERE ' wherestring]);
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
legend('Predictable','Unpredictable')

subplot(2,1,2); hold on; xlim([.4 4.4]);  xticks([1 2 3 4]);  xlabel('Block'); ylabel('RT re: 1st block')
congs=subjects(subjects(:,1)==1, 4:2:end);
incs=subjects(subjects(:,1)==0, 4:2:end);
% plot(mean(congs),'b')
% plot(mean(incs),'k')

errorbar(mean(congs),std(congs)./sqrt(size(congs,1)),'b')
errorbar(mean(incs),std(incs)./sqrt(size(incs,1)),'k')
legend('Predictable','Unpredictable')





%% Compare people based on instrument playing

clear 
DataDB = sqlite('C:\Users\Ryan\Documents\Data\graspHuman.db');

wherestring='Expt = 1  AND ExcludeSubject = 0 AND Instrument = 1 AND Congruent = 1';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitpC1 = calcRespClassCorrectRate(vals);
a=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
rtsC1=mean(a);
rtsC1sem=std(a)/sqrt(length(a));

wherestring='Expt = 1  AND ExcludeSubject = 0 AND Instrument = 2 AND Congruent = 1';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitpC2 = calcRespClassCorrectRate(vals);
a=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
rtsC2=mean(a);
rtsC2sem=std(a)/sqrt(length(a));

wherestring='Expt = 1  AND ExcludeSubject = 0 AND Instrument = 3 AND Congruent = 1';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitpC3 = calcRespClassCorrectRate(vals);
a=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
rtsC3=mean(a);
rtsC3sem=std(a)/sqrt(length(a));



wherestring='Expt = 1  AND ExcludeSubject = 0 AND Instrument = 1 AND Congruent = 0';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitpI1 = calcRespClassCorrectRate(vals);
a=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
rtsI1=mean(a);
rtsI1sem=std(a)/sqrt(length(a));

wherestring='Expt = 1  AND ExcludeSubject = 0 AND Instrument = 2 AND Congruent = 0';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitpI2 = calcRespClassCorrectRate(vals);
a=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
rtsI2=mean(a);
rtsI2sem=std(a)/sqrt(length(a));

wherestring='Expt = 1  AND ExcludeSubject = 0 AND Instrument = 3 AND Congruent = 0';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitpI3 = calcRespClassCorrectRate(vals);
a=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
rtsI3=mean(a);
rtsI3sem=std(a)/sqrt(length(a));



wherestring='Expt = 1  AND ExcludeSubject = 0 AND Instrument = 1';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitp1 = calcRespClassCorrectRate(vals);
a=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
rts1=mean(a);
rts1sem=std(a)/sqrt(length(a));

wherestring='Expt = 1  AND ExcludeSubject = 0 AND Instrument = 2';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitp2 = calcRespClassCorrectRate(vals);
a=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
rts2=mean(a);
rts2sem=std(a)/sqrt(length(a));

wherestring='Expt = 1  AND ExcludeSubject = 0 AND Instrument = 3';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitp3 = calcRespClassCorrectRate(vals);
a=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
rts3=mean(a);
rts3sem=std(a)/sqrt(length(a));

close(DataDB)




figure;
subplot(2,2,1); hold on; xlim([0.5 3.5]); xticks([1,2,3]); xticklabels({'Play currently','Played in past','Hasnt played'}); ylabel('% Correct'); ylim([.90 1])
plot([hitpC1 hitpC2 hitpC3],'b')
plot([hitpI1 hitpI2 hitpI3],'k')
legend('Predictable','Unpredictable')

subplot(2,2,3); hold on; xlim([0.5 3.5]); xticks([1,2,3]); xticklabels({'Play currently','Played in past','Hasnt played'}); ylabel('Reaction time (ms)'); ylim([2200 3600])
errorbar([rtsC1 rtsC2 rtsC3],[rtsC1sem rtsC2sem rtsC3sem],'b')
errorbar([rtsI1 rtsI2 rtsI3],[rtsI1sem rtsI2sem rtsI3sem],'k')
legend('Predictable','Unpredictable')


subplot(2,2,2); hold on; xlim([0.5 3.5]); xticks([1,2,3]); xticklabels({'Play currently','Played in past','Hasnt played'}); ylabel('% Correct'); ylim([.90 1])
bar([hitp1 hitp2 hitp3],'FaceColor','w')

subplot(2,2,4); hold on; xlim([0.5 3.5]); xticks([1,2,3]); xticklabels({'Play currently','Played in past','Hasnt played'}); ylabel('Reaction time (ms)'); ylim([2200 3600])
bar([rts1 rts2 rts3],'FaceColor','w')
errorbar([rts1 rts2 rts3],[rts1sem rts2sem rts3sem],'k.')

%% Compare sexes

clear 
DataDB = sqlite('C:\Users\Ryan\Documents\Data\graspHuman.db');

wherestring='Expt = 1  AND ExcludeSubject = 0 AND Sex = 0 AND Congruent = 1';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitpC1 = calcRespClassCorrectRate(vals);
a=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
rtsC1=mean(a);
rtsC1sem=std(a)/sqrt(length(a));

wherestring='Expt = 1  AND ExcludeSubject = 0 AND Sex = 1 AND Congruent = 1';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitpC2 = calcRespClassCorrectRate(vals);
a=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
rtsC2=mean(a);
rtsC2sem=std(a)/sqrt(length(a));



wherestring='Expt = 1  AND ExcludeSubject = 0 AND Sex = 0 AND Congruent = 0';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitpI1 = calcRespClassCorrectRate(vals);
a=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
rtsI1=mean(a);
rtsI1sem=std(a)/sqrt(length(a));

wherestring='Expt = 1  AND ExcludeSubject = 0 AND Sex = 1 AND Congruent = 0';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitpI2 = calcRespClassCorrectRate(vals);
a=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
rtsI2=mean(a);
rtsI2sem=std(a)/sqrt(length(a));



close(DataDB)



figure;
subplot(2,1,1); hold on; xlim([0.5 2.5]); xticks([1,2]); xticklabels({'Female','Male'}); ylabel('% Correct')
plot([hitpC1 hitpC2],'b')
plot([hitpI1 hitpI2],'k')
legend('Predictable','Unpredictable')

subplot(2,1,2); hold on; xlim([0.5 2.5]); xticks([1,2]); xticklabels({'Female','Male'}); ylabel('Reaction time (ms)')
errorbar([rtsC1 rtsC2],[rtsC1sem rtsC2sem],'b')
errorbar([rtsI1 rtsI2],[rtsI1sem rtsI2sem],'k')
legend('Predictable','Unpredictable')






%% Compare people based on age

clear 
DataDB = sqlite('C:\Users\Ryan\Documents\Data\graspHuman.db');

wherestring='Expt = 1  AND ExcludeSubject = 0 AND Age < 25 AND Congruent = 1';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitpC1 = calcRespClassCorrectRate(vals);
a=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
rtsC1=mean(a);
rtsC1sem=std(a)/sqrt(length(a));

wherestring='Expt = 1  AND ExcludeSubject = 0 AND Age >=25 AND Age <= 30 AND Congruent = 1';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitpC2 = calcRespClassCorrectRate(vals);
a=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
rtsC2=mean(a);
rtsC2sem=std(a)/sqrt(length(a));

wherestring='Expt = 1  AND ExcludeSubject = 0 AND Age > 30 AND Congruent = 1';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitpC3 = calcRespClassCorrectRate(vals);
a=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
rtsC3=mean(a);
rtsC3sem=std(a)/sqrt(length(a));



wherestring='Expt = 1  AND ExcludeSubject = 0 AND Age < 25 AND Congruent = 0';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitpI1 = calcRespClassCorrectRate(vals);
a=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
rtsI1=mean(a);
rtsI1sem=std(a)/sqrt(length(a));

wherestring='Expt = 1  AND ExcludeSubject = 0 AND Age >=25 AND Age <= 30 AND Congruent = 0';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitpI2 = calcRespClassCorrectRate(vals);
a=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
rtsI2=mean(a);
rtsI2sem=std(a)/sqrt(length(a));

wherestring='Expt = 1  AND ExcludeSubject = 0 AND  Age > 30 AND Congruent = 0';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitpI3 = calcRespClassCorrectRate(vals);
a=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
rtsI3=mean(a);
rtsI3sem=std(a)/sqrt(length(a));


close(DataDB)



figure;
subplot(2,1,1); hold on; xlim([0.5 3.5]); xticks([1,2,3]); xticklabels({'Under 25','25 to 30','Over 30'}); ylabel('% Correct')
plot([hitpC1 hitpC2 hitpC3],'b')
plot([hitpI1 hitpI2 hitpI3],'k')
legend('Predictable','Unpredictable')

subplot(2,1,2); hold on; xlim([0.5 3.5]); xticks([1,2,3]); xticklabels({'Under 25','25 to 30','Over 30'}); ylabel('Reaction time (ms)')
errorbar([rtsC1 rtsC2 rtsC3],[rtsC1sem rtsC2sem rtsC3sem],'b')
errorbar([rtsI1 rtsI2 rtsI3],[rtsI1sem rtsI2sem rtsI3sem],'k')
legend('Predictable','Unpredictable')

%% Compare grasptime with reaction time

clear 
DataDB = sqlite('C:\Users\Ryan\Documents\Data\graspHuman.db');

vals=double(cell2mat(fetch(DataDB, 'Select ReactionTime, GraspTime FROM trialsTable WHERE Expt = 1  AND ExcludeTrialGrasp = 0')));
trials=double(cell2mat(fetch(DataDB, 'Select UniqueTrial FROM trialsTable WHERE Expt = 1  AND GraspTime < 200 AND ExcludeTrialGrasp = 0')));

close(DataDB)

figure; hold on; xlabel('Reaction time (ms)'); ylabel('Touch time (ms')

plot(vals(:,1),vals(:,2),'.')
plot([0 10000],[0 10000])

% hist(vals(:,2),200)

%% See where people tend to look on left vs right blocks

clear 

DataDB = sqlite('C:\Users\Ryan\Documents\Data\graspHuman.db');

%Get subjects
subjects=unique(cellfun(@str2num,fetch(DataDB, 'Select Subject FROM trialsTable WHERE ExcludeSubject = 0')));

leftminusright=[];
both=[];
figure; subplot(2,1,1); hold on; 
for s=1:size(subjects,1)
    subject = num2str(subjects(s));
    
    % get trials which were either touch left or touch right
    rights=double(cell2mat(fetch(DataDB, ['Select UniqueTrial FROM trialsTable WHERE Expt = 1  AND TouchMode = "right" AND Subject = ' subject])));
    lefts=double(cell2mat(fetch(DataDB, ['Select UniqueTrial FROM trialsTable WHERE Expt = 1  AND TouchMode = "left" AND Subject = ' subject])));
    
    if isempty(lefts) || isempty(rights)
        continue;
    end
    
    % get eye pos data for each trial
    valsmatR=[];
    for i=1:size(rights,1)
        thisr=num2str(rights(i));
        vals=double(cell2mat(fetch(DataDB, ['Select x, y FROM eyeTable' thisr ' WHERE Saccade = 0 AND Blink = 0'])));
        
        valsmatR=[valsmatR; vals];
    end
    
    valsmatL=[];
    for i=1:size(lefts,1)
        thisl=num2str(lefts(i));
        vals=double(cell2mat(fetch(DataDB, ['Select x, y FROM eyeTable' thisl ' WHERE Saccade = 0 AND Blink = 0'])));
        
        valsmatL=[valsmatL; vals];
    end
    
    plot(mean(valsmatL(:,1)),mean(valsmatL(:,2)),'go')
    plot(mean(valsmatR(:,1)),mean(valsmatR(:,2)),'ro')
    
    plot([mean(valsmatR(:,1)) mean(valsmatL(:,1))],[mean(valsmatR(:,2)) mean(valsmatL(:,2))],'k')
    
    both=[both; mean(valsmatL(:,1)) mean(valsmatL(:,2)) mean(valsmatR(:,1)) mean(valsmatR(:,2))];
   
    leftminusright=[leftminusright; mean(valsmatL(:,1))-mean(valsmatR(:,1))];
end

close(DataDB)

plot(mean(both(:,3)),mean(both(:,4)),'r.','MarkerSize',25)
plot(mean(both(:,1)),mean(both(:,2)),'g.','MarkerSize',25)
xlim([-2 2])
ylim([-2 2])
xlabel('Mean subject-wise eye x position')
ylabel('Mean subject-wise eye y position')

subplot(2,1,2); hold on; xlabel('Bias in eye x position, negative is towards stim hand')
hist(leftminusright,[-.9:.2:.9])


%% Correlation between where people look and touch

clear 

DataDB = sqlite('C:\Users\Ryan\Documents\Data\graspHuman.db');

I1=double(cell2mat(fetch(DataDB, ['Select GraspEyeCorr FROM trialsTable WHERE Expt = 1  AND Congruent = 0 AND Instrument = 1 AND SubjectBlock > 1 AND ExcludeSubject = 0 AND (RespClass = "hit" OR RespClass = "miss")'])));
I2=double(cell2mat(fetch(DataDB, ['Select GraspEyeCorr FROM trialsTable WHERE Expt = 1  AND Congruent = 0 AND Instrument = 2 AND SubjectBlock > 1 AND ExcludeSubject = 0 AND (RespClass = "hit" OR RespClass = "miss")'])));
I3=double(cell2mat(fetch(DataDB, ['Select GraspEyeCorr FROM trialsTable WHERE Expt = 1  AND Congruent = 0 AND Instrument = 3 AND SubjectBlock > 1 AND ExcludeSubject = 0 AND (RespClass = "hit" OR RespClass = "miss")'])));

C1=double(cell2mat(fetch(DataDB, ['Select GraspEyeCorr FROM trialsTable WHERE Expt = 1  AND Congruent = 1 AND Instrument = 1 AND ExcludeSubject = 0 AND (RespClass = "hit" OR RespClass = "miss")'])));
C2=double(cell2mat(fetch(DataDB, ['Select GraspEyeCorr FROM trialsTable WHERE Expt = 1  AND Congruent = 1 AND Instrument = 2 AND ExcludeSubject = 0 AND (RespClass = "hit" OR RespClass = "miss")'])));
C3=double(cell2mat(fetch(DataDB, ['Select GraspEyeCorr FROM trialsTable WHERE Expt = 1  AND Congruent = 1 AND Instrument = 3 AND ExcludeSubject = 0 AND (RespClass = "hit" OR RespClass = "miss")'])));


close(DataDB)

figure; hold on;

[y x]=hist(I1,-0.9:.2:.9);
plot(x,y./length(I1),'r')
[y x]=hist(I2,-0.9:.2:.9);
plot(x,y./length(I2),'g')
[y x]=hist(I3,-0.9:.2:.9);
plot(x,y./length(I3),'b')

[y x]=hist(C1,-0.9:.2:.9);
plot(x,y./length(C1),'r:')
[y x]=hist(C2,-0.9:.2:.9);
plot(x,y./length(C2),'g:')
[y x]=hist(C3,-0.9:.2:.9);
plot(x,y./length(C3),'b:')

legend('Incongruent Currently Play','Incongruent former play','Incongruent no play','Congruent Currently Play','Congruent former play','Congruent no play')
xlabel('Distribution of correlations')
ylabel('Number of trials (normalized)')

%% See if predictable vs unpredictable groups touch different numbers of pads
clear

threshold=20; %any touch value greater than this is considered a real touch
threshns=10; %must touch pad at least this many times to be considered "touched"

DataDB = sqlite('C:\Users\Ryan\Documents\Data\graspHuman.db');

wherestring='ExcludeSubject = 0';
subjects=unique(cellfun(@str2num,fetch(DataDB, ['Select Subject FROM trialsTable WHERE ' wherestring])));

results=[];
r2=[];
for i=1:size(subjects,1)    
    wherestring=['Expt = 1  AND ExcludeSubject = 0 AND subject = ' num2str(subjects(i)) ' AND Congruent = 1 AND Choice1ID IS NOT NULL'];
    congTrialsLeft=double(cell2mat(fetch(DataDB, ['Select UniqueTrial FROM trialsTable WHERE ' wherestring])));
    wherestring=['Expt = 1  AND ExcludeSubject = 0 AND subject = ' num2str(subjects(i)) ' AND Congruent = 1 AND Choice2ID IS NOT NULL'];
    congTrialsRight=double(cell2mat(fetch(DataDB, ['Select UniqueTrial FROM trialsTable WHERE ' wherestring])));
    wherestring=['Expt = 1  AND ExcludeSubject = 0 AND subject = ' num2str(subjects(i)) ' AND Congruent = 0  AND Choice1ID IS NOT NULL'];
    incongTrialsLeft=double(cell2mat(fetch(DataDB, ['Select UniqueTrial FROM trialsTable WHERE ' wherestring])));
    wherestring=['Expt = 1  AND ExcludeSubject = 0 AND subject = ' num2str(subjects(i)) ' AND Congruent = 0  AND Choice2ID IS NOT NULL'];
    incongTrialsRight=double(cell2mat(fetch(DataDB, ['Select UniqueTrial FROM trialsTable WHERE ' wherestring])));
    
    for ii=1:size(congTrialsLeft,1)
        ts=double(cell2mat(fetch(DataDB,['Select pctPad1_1,pctPad1_2,pctPad1_3,pctPad1_4,pctPad1_5,pctPad1_6,pctPad1_7,pctPad1_8,pctPad1_9,pctPad1_10,pctPad1_11,pctPad1_12 FROM graspTable' num2str(congTrialsLeft(ii)) ' WHERE TrialPeriod = 1'])));
        ts(ts<threshold)=0;
        ts(ts~=0)=1;
        a=sum(ts,2);
        b=sum(ts,1);
        [y, x]=hist(a(a>0),1:12);
        results=[results; 1 0 y];
        r2=[r2; subjects(i) 1 0 sum(b>threshns)];
    end
    for ii=1:size(congTrialsRight,1)
        ts=double(cell2mat(fetch(DataDB,['Select pctPad2_1,pctPad2_2,pctPad2_3,pctPad2_4,pctPad2_5,pctPad2_6,pctPad2_7,pctPad2_8,pctPad2_9,pctPad2_10,pctPad2_11,pctPad2_12 FROM graspTable' num2str(congTrialsRight(ii)) ' WHERE TrialPeriod = 1'])));
        ts(ts<threshold)=0;
        ts(ts~=0)=1;
        a=sum(ts,2);
        b=sum(ts,1);
        [y, x]=hist(a(a>0),1:12);
        results=[results; 1 1 y];
        r2=[r2; subjects(i) 1 1 sum(b>threshns)];
    end
    for ii=1:size(incongTrialsLeft,1)
        ts=double(cell2mat(fetch(DataDB,['Select pctPad1_1,pctPad1_2,pctPad1_3,pctPad1_4,pctPad1_5,pctPad1_6,pctPad1_7,pctPad1_8,pctPad1_9,pctPad1_10,pctPad1_11,pctPad1_12 FROM graspTable' num2str(incongTrialsLeft(ii)) ' WHERE TrialPeriod = 1'])));
        ts(ts<threshold)=0;
        ts(ts~=0)=1;
        a=sum(ts,2);
        b=sum(ts,1);
        [y, x]=hist(a(a>0),1:12);
        results=[results; 0 0 y];
        r2=[r2; subjects(i) 0 0 sum(b>threshns)];
    end
    for ii=1:size(incongTrialsRight,1)
        ts=double(cell2mat(fetch(DataDB,['Select pctPad2_1,pctPad2_2,pctPad2_3,pctPad2_4,pctPad2_5,pctPad2_6,pctPad2_7,pctPad2_8,pctPad2_9,pctPad2_10,pctPad2_11,pctPad2_12 FROM graspTable' num2str(incongTrialsRight(ii)) ' WHERE TrialPeriod = 1'])));
        ts(ts<threshold)=0;
        ts(ts~=0)=1;
        a=sum(ts,2);
        b=sum(ts,1);
        [y, x]=hist(a(a>0),1:12);
        results=[results; 0 1 y];
        r2=[r2; subjects(i) 0 1 sum(b>threshns)];
    end

end
close(DataDB)

figure; subplot(2,2,1); hold on;
plot(sum(results(results(:,1)==1 & results(:,2)==0,3:14)),'b') %Congruent left
plot(sum(results(results(:,1)==1 & results(:,2)==1,3:14)),'b:') %Congruent right
plot(sum(results(results(:,1)==0 & results(:,2)==0,3:14)),'k') %Incongruent left
plot(sum(results(results(:,1)==0 & results(:,2)==1,3:14)),'k:') %Incongruent right

legend('Predictable left','Predictable right','Unpredictable left','Unpredictable right')
title(['Touch vals above ' num2str(threshold) '%'])
ylabel('Total number of touches')
xlabel('Number of pads concurrently touched')

subplot(2,2,2); hold on;
plot(sum(results(results(:,1)==1,3:14)),'b') %Congruent
plot(sum(results(results(:,1)==0,3:14)),'k') %Incongruent left

legend('Predictable','Unpredictable')
title(['Touch vals above ' num2str(threshold) '%'])
ylabel('Total number of touches')
xlabel('Number of pads concurrently touched')

subplot(2,2,3); hold on;
[y, x]=hist(r2(r2(:,2)==1 & r2(:,3)==0,4),0:12); %Congruent left
plot(x,y,'b')
[y, x]=hist(r2(r2(:,2)==1 & r2(:,3)==1,4),0:12); %Congruent right
plot(x,y,'b:')
[y, x]=hist(r2(r2(:,2)==0 & r2(:,3)==0,4),0:12); %Incongruent left
plot(x,y,'k')
[y, x]=hist(r2(r2(:,2)==0 & r2(:,3)==1,4),0:12); %Incongruent right
plot(x,y,'k:')
legend('Predictable left','Predictable right','Unpredictable left','Unpredictable right')
title(['Touch vals above ' num2str(threshold) '%, touched at least ' num2str(threshns) ' samples'])
ylabel('Number of trials')
xlabel('Number of pads touched during trial')

subplot(2,2,4); hold on;
[y, x]=hist(r2(r2(:,2)==1,4),0:12); %Congruent left
plot(x,y,'b')

[y, x]=hist(r2(r2(:,2)==0,4),0:12); %Incongruent left
plot(x,y,'k')

legend('Predictable','Unpredictable')
title(['Touch vals above ' num2str(threshold) '%, touched at least ' num2str(threshns) ' samples'])
ylabel('Number of trials')
xlabel('Number of pads touched during trial')




%% Plot rt vs cr for all subjects, colored according to the correlation between look and touch

clear
DataDB = sqlite('C:\Users\Ryan\Documents\Data\graspHuman.db');

wherestring='ExcludeSubject = 0';
subjects=unique(cellfun(@str2num,fetch(DataDB, ['Select Subject FROM trialsTable WHERE ' wherestring])));

results=[];
for i=1:size(subjects,1)    
    wherestring=['Expt = 1  AND ExcludeSubject = 0 AND subject = ' num2str(subjects(i))];
    vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
    if isempty(vals)
        continue;
    end
    
    hitpR = calcRespClassCorrectRate(vals);
    a=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
    rtsR=mean(a);
    congs=double(cell2mat(fetch(DataDB, ['Select Congruent FROM trialsTable WHERE ' wherestring])));
    
    c=double(cell2mat(fetch(DataDB, ['Select GraspEyeCorr FROM trialsTable WHERE Expt = 1  AND subject = ' num2str(subjects(i)) ' AND (RespClass = "hit" OR RespClass = "miss")'])));    
%     c=double(cell2mat(fetch(DataDB, ['Select GraspEyeCorr FROM trialsTable WHERE subject = ' num2str(subjects(i)) ' AND Aligned = 1'])));    
    
    
    results=[results; hitpR rtsR congs(1) mean(c) ttest(c,0,'alpha',0.025,'tail','left')+ttest(c,0,'alpha',0.025,'tail','right')*2];
%     results=[results; hitpR rtsR congs(1) mean(c) ttest(c,0)];

    if ttest(c,0,'tail','right')
        subjects(i)
    end
end
close(DataDB)

congs=results(results(:,3)==1,1:2);
incs=results(results(:,3)==0,1:2);

negCorr=results(results(:,5)==1,1:2);
posCorr=results(results(:,5)==2,1:2);

figure; 
subplot(2,1,1); hold on; xlabel('% Correct'); ylabel('RT (ms)')
scatter(congs(:,1),congs(:,2),'b','MarkerFaceColor','b')
scatter(incs(:,1),incs(:,2),'k','MarkerFaceColor','k')
legend('Predictable','Unpredictable','Sig Corr look:touch')
plot(negCorr(:,1),negCorr(:,2),'ro','MarkerSize',15)
plot(posCorr(:,1),posCorr(:,2),'go','MarkerSize',15)

subplot(2,1,2); hold on; xticks([1 2 3]); xticklabels({'Negative','Neither','Positive'}); ylabel('Number of participants'); xlabel('Correlation between eyes and hands')
I0=sum(results(:,3)==0 & results(:,5)==0);
IN=sum(results(:,3)==0 & results(:,5)==1);
IP=sum(results(:,3)==0 & results(:,5)==2);

C0=sum(results(:,3)==1 & results(:,5)==0);
CN=sum(results(:,3)==1 & results(:,5)==1);
CP=sum(results(:,3)==1 & results(:,5)==2);
bar([CN IN; C0 I0; CP IP])
legend('Congruent','Incongruent')


%% Compare amount of blinks and saccades in congruent and non-congruent conditions by subject block

clear 

DataDB = sqlite('C:\Users\Ryan\Documents\Data\graspHuman.db');

%Get subjects
subjects=unique(cellfun(@str2num,fetch(DataDB, 'Select Subject FROM trialsTable WHERE ExcludeSubject = 0')));
rmat=[];
% figure; subplot(2,1,1); hold on; 
for s=1:size(subjects,1)
    subject = num2str(subjects(s));
    
    % get trials which were either congruent or non-congruent
    congruents=double(cell2mat(fetch(DataDB, ['Select UniqueTrial, SubjectBlock FROM trialsTable WHERE Expt = 1  AND Congruent = 1 AND Subject = ' subject])));
    incongruents=double(cell2mat(fetch(DataDB, ['Select UniqueTrial, SubjectBlock FROM trialsTable WHERE Expt = 1  AND Congruent = 0 AND Subject = ' subject])));    
    
    % get blink and saccade info for these trials
    if ~isempty(congruents)
        valsmatC=[];
        for i=1:size(congruents,1)
            this=num2str(congruents(i,1));
            block=congruents(i,2);
            vals=double(cell2mat(fetch(DataDB, ['Select Blink, Saccade FROM eyeTable' this ' WHERE Blink IS NOT NULL'])));
            
            valsmatC=[valsmatC; ones(size(vals,1),1)*block vals];
        end
        b1b=valsmatC(valsmatC(:,1)==1,2);
        b2b=valsmatC(valsmatC(:,1)==2,2);
        b3b=valsmatC(valsmatC(:,1)==3,2);
        
        %Blinks per second
        b1s=sum(diff(valsmatC(valsmatC(:,1)==1,3))>0)/(sum(valsmatC(:,1)==1)/200);
        b2s=sum(diff(valsmatC(valsmatC(:,1)==2,3))>0)/(sum(valsmatC(:,1)==2)/200);
        b3s=sum(diff(valsmatC(valsmatC(:,1)==3,3))>0)/(sum(valsmatC(:,1)==3)/200);
        
        rmat=[rmat; str2double(subject) 1 mean(b1b) mean(b2b) mean(b3b) b1s b2s b3s];        
    end
    
    if ~isempty(incongruents)
        valsmatI=[];
        for i=1:size(incongruents,1)
            this=num2str(incongruents(i,1));
            block=incongruents(i,2);
            vals=double(cell2mat(fetch(DataDB, ['Select Blink, Saccade FROM eyeTable' this ' WHERE Blink IS NOT NULL'])));
            
            valsmatI=[valsmatI; ones(size(vals,1),1)*block vals];
        end
        
        b1b=valsmatI(valsmatI(:,1)==1,2);
        b2b=valsmatI(valsmatI(:,1)==2,2);
        b3b=valsmatI(valsmatI(:,1)==3,2);
        
%         b1s=valsmatI(valsmatI(:,1)==1,3);
%         b2s=valsmatI(valsmatI(:,1)==2,3);
%         b3s=valsmatI(valsmatI(:,1)==3,3);
%         
        %blinks per second for each block
        b1s=sum(diff(valsmatI(valsmatI(:,1)==1,3))>0)/(sum(valsmatI(:,1)==1)/200);
        b2s=sum(diff(valsmatI(valsmatI(:,1)==2,3))>0)/(sum(valsmatI(:,1)==2)/200);
        b3s=sum(diff(valsmatI(valsmatI(:,1)==3,3))>0)/(sum(valsmatI(:,1)==3)/200);
        
        rmat=[rmat; str2double(subject) 0 mean(b1b) mean(b2b) mean(b3b) b1s b2s b3s];
    end
end

close(DataDB)

figure; subplot(2,1,1); hold on; xlabel('Block'); ylabel('% of time with eyes closed'); xticks([1 2 3])

congs=mean(rmat(rmat(:,2)==1,3:5));
incs=mean(rmat(rmat(:,2)==0,3:5));

% congssem=std(rmat(rmat(:,2)==1,3:5))/sqrt(size(rmat(rmat(:,2)==1,3:5),1));
% incssem=std(rmat(rmat(:,2)==0,3:5))/sqrt(size(rmat(rmat(:,2)==0,3:5),1));


bar([congs*100; incs*100]')
legend('Predictable','Unpredictable')

subplot(2,1,2); hold on; xlabel('Block'); ylabel('Saccades per second'); xticks([1 2 3])

congs=mean(rmat(rmat(:,2)==1,6:8));
incs=mean(rmat(rmat(:,2)==0,6:8));

% congssem=std(rmat(rmat(:,2)==1,3:5))/sqrt(size(rmat(rmat(:,2)==1,3:5),1));
% incssem=std(rmat(rmat(:,2)==0,3:5))/sqrt(size(rmat(rmat(:,2)==0,3:5),1));


bar([congs; incs]')
legend('Predictable','Unpredictable')











