%% Compare all conditions separately
% clear all
% DataDB = sqlite('C:\Users\Ryan\Documents\Data\graspHuman.db');
% 
% %Predictable
% wherestring='Expt = 2 AND Variant = "match_haptic_to_vis" AND ExcludeSubject = 0 AND SubjectBlock = 1 AND FirstBlockType = "left" AND Congruent = 1';
% vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
% hitp1L = calcRespClassCorrectRate(vals);
% rts=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
% rts1L=mean(rts);
% rts1LS=std(rts)/sqrt(length(rts));
% 
% wherestring='Expt = 2 AND Variant = "match_haptic_to_vis" AND ExcludeSubject = 0 AND SubjectBlock = 2 AND FirstBlockType = "left" AND Congruent = 1';
% vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
% hitp2L = calcRespClassCorrectRate(vals);
% rts=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
% rts2L=mean(rts);
% rts2LS=std(rts)/sqrt(length(rts));
% 
% wherestring='Expt = 2 AND Variant = "match_haptic_to_vis" AND ExcludeSubject = 0 AND SubjectBlock = 3 AND FirstBlockType = "left" AND Congruent = 1';
% vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
% hitp3L = calcRespClassCorrectRate(vals);
% rts=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
% rts3L=mean(rts);
% rts3LS=std(rts)/sqrt(length(rts));
% 
% wherestring='Expt = 2 AND Variant = "match_haptic_to_vis" AND ExcludeSubject = 0 AND SubjectBlock = 1 AND FirstBlockType = "right" AND Congruent = 1';
% vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
% hitp1R = calcRespClassCorrectRate(vals);
% rts=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
% rts1R=mean(rts);
% rts1RS=std(rts)/sqrt(length(rts));
% 
% wherestring='Expt = 2 AND Variant = "match_haptic_to_vis" AND ExcludeSubject = 0 AND SubjectBlock = 2 AND FirstBlockType = "right" AND Congruent = 1';
% vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
% hitp2R = calcRespClassCorrectRate(vals);
% rts=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
% rts2R=mean(rts);
% rts2RS=std(rts)/sqrt(length(rts));
% 
% wherestring='Expt = 2 AND Variant = "match_haptic_to_vis"  AND ExcludeSubject = 0 AND SubjectBlock = 3 AND FirstBlockType = "right" AND Congruent = 1';
% vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
% hitp3R = calcRespClassCorrectRate(vals);
% rts=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
% rts3R=mean(rts);
% rts3RS=std(rts)/sqrt(length(rts));
% 
% %Unpredictable
% wherestring='Expt = 2 AND Variant = "match_haptic_to_vis"  AND ExcludeSubject = 0 AND SubjectBlock = 1 AND FirstBlockType = "left" AND Congruent = 0';
% vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
% hitp1Li = calcRespClassCorrectRate(vals);
% rts=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
% rts1Li=mean(rts);
% rts1LiS=std(rts)/sqrt(length(rts));
% 
% wherestring='Expt = 2 AND Variant = "match_haptic_to_vis"  AND ExcludeSubject = 0 AND SubjectBlock = 2 AND FirstBlockType = "left" AND Congruent = 0';
% vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
% hitp2Li = calcRespClassCorrectRate(vals);
% rts=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
% rts2Li=mean(rts);
% rts2LiS=std(rts)/sqrt(length(rts));
% 
% wherestring='Expt = 2 AND Variant = "match_haptic_to_vis"  AND ExcludeSubject = 0 AND SubjectBlock = 3 AND FirstBlockType = "left" AND Congruent = 0';
% vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
% hitp3Li = calcRespClassCorrectRate(vals);
% rts=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
% rts3Li=mean(rts);
% rts3LiS=std(rts)/sqrt(length(rts));
% 
% wherestring='Expt = 2 AND Variant = "match_haptic_to_vis"  AND ExcludeSubject = 0 AND SubjectBlock = 1 AND FirstBlockType = "right" AND Congruent = 0';
% vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
% hitp1Ri = calcRespClassCorrectRate(vals);
% rts=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
% rts1Ri=mean(rts);
% rts1RiS=std(rts)/sqrt(length(rts));
% 
% wherestring='Expt = 2 AND Variant = "match_haptic_to_vis"  AND ExcludeSubject = 0 AND SubjectBlock = 2 AND FirstBlockType = "right" AND Congruent = 0';
% vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
% hitp2Ri = calcRespClassCorrectRate(vals);
% rts=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
% rts2Ri=mean(rts);
% rts2RiS=std(rts)/sqrt(length(rts));
% 
% wherestring='Expt = 2 AND Variant = "match_haptic_to_vis"  AND ExcludeSubject = 0 AND SubjectBlock = 3 AND FirstBlockType = "right" AND Congruent = 0';
% vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
% hitp3Ri = calcRespClassCorrectRate(vals);
% rts=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
% rts3Ri=mean(rts);
% rts3RiS=std(rts)/sqrt(length(rts));
% 
% close(DataDB)
% 
% figure; 
% subplot(2,2,1); hold on; ylim([0.85 1]); ylabel('p(correct)'); title('Predictable');  xlabel('Block'); xlim([0.6 3.4]); xticks([1 2 3])
% plot([hitp1L hitp2L hitp3L],'k:')
% plot([hitp1R hitp2R hitp3R],'k:')
% scatter([1 2 3],[hitp1L hitp2R hitp3L],'g','MarkerFaceColor','g')
% scatter([1 2 3],[hitp1R hitp2L hitp3R],'r','MarkerFaceColor','r')
% 
% subplot(2,2,3); hold on; ylabel('RT (ms)'); xlabel('Block'); ylim([2400 3400]);xlim([0.6 3.4]); xticks([1 2 3])
% plot([rts1L rts2L rts3L],'k:')
% plot([rts1R rts2R rts3R],'k:')
% scatter([1 2 3],[rts1L rts2R rts3L],'g','MarkerFaceColor','g')
% scatter([1 2 3],[rts1R rts2L rts3R],'r','MarkerFaceColor','r')
% errorbar([1 2 3],[rts1L rts2L rts3L],[rts1LS rts2LS rts3LS],'k.')
% errorbar([1 2 3],[rts1R rts2R rts3R],[rts1RS rts2RS rts3RS],'k.')
% 
% subplot(2,2,2); hold on; ylim([0.85 1]); ylabel('p(correct)'); title('Unpredictable');  xlabel('Block'); xlim([0.6 3.4]); xticks([1 2 3])
% plot([hitp1Li hitp2Li hitp3Li],'k:')
% plot([hitp1Ri hitp2Ri hitp3Ri],'k:')
% scatter([1 2 3],[hitp1Li hitp2Ri hitp3Li],'g','MarkerFaceColor','g')
% scatter([1 2 3],[hitp1Ri hitp2Li hitp3Ri],'r','MarkerFaceColor','r')
% 
% subplot(2,2,4); hold on; ylabel('RT (ms)'); xlabel('Block'); ylim([2400 3400]); xlim([0.6 3.4]); xticks([1 2 3])
% plot([rts1Li rts2Li rts3Li],'k:')
% plot([rts1Ri rts2Ri rts3Ri],'k:')
% scatter([1 2 3],[rts1Li rts2Ri rts3Li],'g','MarkerFaceColor','g')
% scatter([1 2 3],[rts1Ri rts2Li rts3Ri],'r','MarkerFaceColor','r')
% errorbar([1 2 3],[rts1Li rts2Li rts3Li],[rts1LiS rts2LiS rts3LiS],'k.')
% errorbar([1 2 3],[rts1Ri rts2Ri rts3Ri],[rts1RiS rts2RiS rts3RiS],'k.')

%% Compare Predictable vs. Unpredictable

clear 
DataDB = sqlite('C:\Users\Ryan\Documents\Data\graspHuman.db');

wherestring='Expt = 2 AND Variant = "match_haptic_to_vis"  AND ExcludeSubject = 0 AND SubjectBlock = 1 AND Congruent = 1';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitp1C = calcRespClassCorrectRate(vals);
a=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
rts1C=mean(a);
rts1Csem=std(a)/sqrt(length(a));

wherestring='Expt = 2 AND Variant = "match_haptic_to_vis"  AND ExcludeSubject = 0 AND SubjectBlock = 2 AND Congruent = 1';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitp2C = calcRespClassCorrectRate(vals);
a=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
rts2C=mean(a);
rts2Csem=std(a)/sqrt(length(a));

% wherestring='Expt = 2 AND Variant = "match_haptic_to_vis"  AND ExcludeSubject = 0 AND SubjectBlock = 3 AND Congruent = 1';
% vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
% hitp3C = calcRespClassCorrectRate(vals);
% a=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
% rts3C=mean(a);
% rts3Csem=std(a)/sqrt(length(a));

wherestring='Expt = 2 AND Variant = "match_haptic_to_vis"  AND ExcludeSubject = 0 AND SubjectBlock = 1 AND Congruent = 0';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitp1I = calcRespClassCorrectRate(vals);
a=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
rts1I=mean(a);
rts1Isem=std(a)/sqrt(length(a));

wherestring='Expt = 2 AND Variant = "match_haptic_to_vis"  AND ExcludeSubject = 0 AND SubjectBlock = 2 AND Congruent = 0';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitp2I = calcRespClassCorrectRate(vals);
a=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
rts2I=mean(a);
rts2Isem=std(a)/sqrt(length(a));

% wherestring='Expt = 2 AND Variant = "match_haptic_to_vis"  AND ExcludeSubject = 0 AND SubjectBlock = 3 AND Congruent = 0';
% vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
% hitp3I = calcRespClassCorrectRate(vals);
% a=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
% rts3I=mean(a);
% rts3Isem=std(a)/sqrt(length(a));

close(DataDB)

figure;

subplot(2,1,1); hold on; ylim([0.85 1]); xlim([0.6 3.4]); ylabel('p(correct)');  xlabel('Block'); xticks([1 2 3])
plot([hitp1C hitp2C],'b:.','MarkerSize',20)
plot([hitp1I hitp2I],'k:.','MarkerSize',20)
legend('Predictable','Unpredictable')

subplot(2,1,2); hold on; ylabel('RT (ms)'); xlim([0.6 3.4]); xlabel('Block'); ylim([2400 4800]); xticks([1 2 3])
% plot([rts1C rts2C rts3C],'b:o')
% plot([rts1I rts2I rts3I],'k:o')
errorbar([rts1C rts2C],[rts1Csem rts2Csem],'b:.','MarkerSize',20)
errorbar([rts1I rts2I],[rts1Isem rts2Isem],'k:.','MarkerSize',20)
legend('Predictable','Unpredictable')

%% Compare left and right hands

% clear
% DataDB = sqlite('C:\Users\Ryan\Documents\Data\graspHuman.db');
% 
% wherestring='Expt = 2 AND Variant = "match_haptic_to_vis"  AND ExcludeSubject = 0 AND Congruent = 1 AND TouchMode = "left"';
% vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
% hitpL = calcRespClassCorrectRate(vals);
% a=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
% rtsL=mean(a);
% rtsLsem=std(a)/sqrt(length(a));
% 
% wherestring='Expt = 2 AND Variant = "match_haptic_to_vis"  AND ExcludeSubject = 0 AND Congruent = 1 AND TouchMode = "right"';
% vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
% hitpR = calcRespClassCorrectRate(vals);
% a=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
% rtsR=mean(a);
% rtsRsem=std(a)/sqrt(length(a));
% 
% close(DataDB)
% 
% figure;
% subplot(2,1,1); hold on; ylim([94 96]); ylabel('p(correct)'); xlim([0 3]); xticks([1 2]); xticklabels({'Left','Right'})
% bar([hitpL*100 hitpR*100],'Facecolor','w')
% 
% subplot(2,1,2); hold on; ylabel('RT (ms)'); xlim([0 3]); ylim([2600 2800]); xticks([1 2]); xticklabels({'Left','Right'})
% bar([rtsL rtsR],'Facecolor','w')
% errorbar([rtsL rtsR],[rtsLsem rtsRsem],'k.')

%% Plot rt vs cr for all subjects for first task

clear
DataDB = sqlite('C:\Users\Ryan\Documents\Data\graspHuman.db');

wherestring='ExcludeSubject = 0';
subjects=unique(cellfun(@str2num,fetch(DataDB, ['Select Subject FROM trialsTable WHERE ' wherestring])));

results=[];
for i=1:size(subjects,1)
    
    wherestring=['Expt = 2 AND Variant = "match_haptic_to_vis"  AND ExcludeSubject = 0 AND subject = ' num2str(subjects(i))];
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

figure; hold on; xlabel('% Correct'); ylabel('RT (ms)'); title('First task performance')
scatter(congs(:,1),congs(:,2),'b','MarkerFaceColor','b')
scatter(incs(:,1),incs(:,2),'k','MarkerFaceColor','k')
legend('Predictable','Unpredictable')


%Check out inverse efficiency score
results(:,4)=results(:,2)./(results(:,1));
disp('% correct different between predictable and unpredictable?')
[h p]=ttest2(results(results(:,3)==0,1),results(results(:,3)==1,1))
disp('RT different between predictable and unpredictable?')
[h p]=ttest2(results(results(:,3)==0,2),results(results(:,3)==1,2))
disp('Inverse efficiency different between predictable and unpredictable?')
[h p]=ttest2(results(results(:,3)==0,4),results(results(:,3)==1,4))

%% Plot rt vs cr for all subjects for second task

clear
DataDB = sqlite('C:\Users\Ryan\Documents\Data\graspHuman.db');

wherestring='ExcludeSubject = 0';
subjects=unique(cellfun(@str2num,fetch(DataDB, ['Select Subject FROM trialsTable WHERE ' wherestring])));

results=[];
for i=1:size(subjects,1)
    
    wherestring=['Expt = 2 AND Variant = "match_vis_to_haptic"  AND ExcludeSubject = 0 AND subject = ' num2str(subjects(i))];
    vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
    if isempty(vals)
        continue;
    end
    hitpR = calcRespClassCorrectRate(vals);
    a=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
    rtsR=mean(a);
    congs=double(cell2mat(fetch(DataDB, ['Select Condition FROM trialsTable WHERE ' wherestring])));
    
    results=[results; hitpR rtsR congs(1)];
end
close(DataDB)

congs=results(results(:,3)==1,1:2);
incs=results(results(:,3)==2,1:2);

figure; hold on; xlabel('% Correct'); ylabel('RT (ms)'); title('Second task performance')
scatter(congs(:,1),congs(:,2),'b','MarkerFaceColor','b')
scatter(incs(:,1),incs(:,2),'k','MarkerFaceColor','k')
legend('Predictable','Unpredictable')


%Check out inverse efficiency score
results(:,4)=results(:,2)./(results(:,1));
disp('% correct different between predictable and unpredictable?')
[h p]=ttest2(results(results(:,3)==1,1),results(results(:,3)==2,1))
disp('RT different between predictable and unpredictable?')
[h p]=ttest2(results(results(:,3)==1,2),results(results(:,3)==2,2))
disp('Inverse efficiency different between predictable and unpredictable?')
[h p]=ttest2(results(results(:,3)==1,4),results(results(:,3)==2,4))

%% Plot RT vs. d-primes for first task
clear
DataDB = sqlite('C:\Users\Ryan\Documents\Data\graspHuman.db');

wherestring='ExcludeSubject = 0';
subjects=unique(cellfun(@str2num,fetch(DataDB, ['Select Subject FROM trialsTable WHERE ' wherestring])));

results=[];
for i=1:size(subjects,1)
    
    wherestring=['Expt = 2 AND Variant = "match_haptic_to_vis"  AND ExcludeSubject = 0 AND subject = ' num2str(subjects(i))];
    vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
    if isempty(vals)
        continue;
    end
%     hitpR = calcRespClassCorrectRate(vals);
    dp=calcdprimes(vals);
    a=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
    rtsR=mean(a);
    congs=double(cell2mat(fetch(DataDB, ['Select Congruent FROM trialsTable WHERE ' wherestring])));
    
    results=[results; dp rtsR congs(1)];
end
close(DataDB)

congs=results(results(:,3)==1,1:2);
incs=results(results(:,3)==0,1:2);

figure; hold on; xlabel('d-prime'); ylabel('RT (ms)'); title('First task performance')
scatter(congs(:,1),congs(:,2),'b','MarkerFaceColor','b')
scatter(incs(:,1),incs(:,2),'k','MarkerFaceColor','k')
legend('Predictable','Unpredictable')


%Check out inverse efficiency score
results(:,4)=results(:,2)./(results(:,1));
disp('% correct different between predictable and unpredictable?')
[h p]=ttest2(results(results(:,3)==0,1),results(results(:,3)==1,1))
disp('RT different between predictable and unpredictable?')
[h p]=ttest2(results(results(:,3)==0,2),results(results(:,3)==1,2))
disp('Inverse efficiency different between predictable and unpredictable?')
[h p]=ttest2(results(results(:,3)==0,4),results(results(:,3)==1,4))


%% Plot RT vs. d-primes for second task
clear
DataDB = sqlite('C:\Users\Ryan\Documents\Data\graspHuman.db');

wherestring='ExcludeSubject = 0';
subjects=unique(cellfun(@str2num,fetch(DataDB, ['Select Subject FROM trialsTable WHERE ' wherestring])));

results=[];
for i=1:size(subjects,1)
    
    wherestring=['Expt = 2 AND Variant = "match_vis_to_haptic"  AND ExcludeSubject = 0 AND subject = ' num2str(subjects(i))];
    vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
    if isempty(vals)
        continue;
    end
%     hitpR = calcRespClassCorrectRate(vals);
    
    dp=calcdprimes(vals);
    a=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
    rtsR=mean(a);
    congs=double(cell2mat(fetch(DataDB, ['Select Condition FROM trialsTable WHERE ' wherestring])));
    
    results=[results; dp rtsR congs(1)];
end
close(DataDB)

congs=results(results(:,3)==1,1:2);
incs=results(results(:,3)==2,1:2);

figure; hold on; xlabel('d-prime'); ylabel('RT (ms)'); title('Second task performance')
scatter(congs(:,1),congs(:,2),'b','MarkerFaceColor','b')
scatter(incs(:,1),incs(:,2),'k','MarkerFaceColor','k')
legend('Predictable','Unpredictable')


%Check out inverse efficiency score
results(:,4)=results(:,2)./(results(:,1));
disp('% correct different between predictable and unpredictable?')
[h p]=ttest2(results(results(:,3)==1,1),results(results(:,3)==2,1))
disp('RT different between predictable and unpredictable?')
[h p]=ttest2(results(results(:,3)==1,2),results(results(:,3)==2,2))
disp('Inverse efficiency different between predictable and unpredictable?')
[h p]=ttest2(results(results(:,3)==1,4),results(results(:,3)==2,4))


%% Plot performance by subject in first and second task

clear
DataDB = sqlite('C:\Users\Ryan\Documents\Data\graspHuman.db');
wherestring='ExcludeSubject = 0';
subjects=unique(cellfun(@str2num,fetch(DataDB, ['Select Subject FROM trialsTable WHERE ' wherestring])));

results=[];
for i=1:size(subjects,1)
    %expt 1, trial 1-100
    wherestring=['Expt = 1 AND Variant = "match_haptic_to_vis"  AND SubjectTrial < 101 AND ExcludeSubject = 0 AND subject = ' num2str(subjects(i))];
    vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
    a=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
    congs=double(cell2mat(fetch(DataDB, ['Select Condition FROM trialsTable WHERE ' wherestring])));
    rts1=mean(a);
    if ~isempty(vals); hitp1 = calcRespClassCorrectRate(vals);   else; hitp1=nan; end
    if ~isempty(congs); congs1=congs(1); else; congs1=nan; end
    
    %expt 2, trial 1-100
    wherestring=['Expt = 2 AND Variant = "match_haptic_to_vis"  AND SubjectTrial < 101 AND ExcludeSubject = 0 AND subject = ' num2str(subjects(i))];
    vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
    a=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
    congs=double(cell2mat(fetch(DataDB, ['Select Condition FROM trialsTable WHERE ' wherestring])));
    rts2=mean(a);
    if ~isempty(vals); hitp2 = calcRespClassCorrectRate(vals);   else; hitp2=nan; end  
    if ~isempty(congs); congs2=congs(1); else; congs2=nan; end
    
    
    %expt 2, match_vis_to_haptic
    wherestring=['Expt = 2 AND Variant = "match_vis_to_haptic" AND ExcludeSubject = 0 AND subject = ' num2str(subjects(i))];
    vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
    a=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
    congs=double(cell2mat(fetch(DataDB, ['Select Condition FROM trialsTable WHERE ' wherestring])));
    rts3=mean(a)-400;
    if ~isempty(vals); hitp3 = calcRespClassCorrectRate(vals);   else; hitp3=nan; end 
    if ~isempty(congs); congs3=congs(1); else; congs3=nan; end
    
    results=[results; hitp1 rts1 congs1 hitp2 rts2 congs2 hitp3 rts3 congs3];
end
close(DataDB)

figure; subplot(2,1,1); hold on; xlabel('Hit rate'); ylabel('Reaction time'); title('Absolute numbers, 400 ms subtracted from second task, first 100 trials')

%First experiment
plot(results(results(:,3)==1,1),results(results(:,3)==1,2),'b.','MarkerSize',20)
plot(results(results(:,3)==2,1),results(results(:,3)==2,2),'k.','MarkerSize',20)
%second experiment, second task
plot(results(results(:,9)==1,7),results(results(:,9)==1,8),'bo','MarkerSize',5)
plot(results(results(:,9)==2,7),results(results(:,9)==2,8),'ko','MarkerSize',5)
%second experiment, first task
plot(results(results(:,6)==1,4),results(results(:,6)==1,5),'b.','MarkerSize',20)
plot(results(results(:,6)==2,4),results(results(:,6)==2,5),'k.','MarkerSize',20)
%First experiment, means
plot(mean(results(results(:,3)==1,1)),mean(results(results(:,3)==1,2)),'b.','MarkerSize',50)
plot(mean(results(results(:,3)==2,1)),mean(results(results(:,3)==2,2)),'k.','MarkerSize',50)
%second experiment, second task
plot(mean(results(results(:,9)==1,7)),mean(results(results(:,9)==1,8)),'bo','MarkerSize',10)
plot(mean(results(results(:,9)==2,7)),mean(results(results(:,9)==2,8)),'ko','MarkerSize',10)
%second experiment, first task
plot(mean(results(results(:,6)==1,4)),mean(results(results(:,6)==1,5)),'b.','MarkerSize',40)
plot(mean(results(results(:,6)==2,4)),mean(results(results(:,6)==2,5)),'k.','MarkerSize',40)

for i=1:size(results,1)
    first=results(i,1:3);
    second=results(i,4:6);
    third=results(i,7:9);
    
    if ~isnan(first(1)) %if they were in the first experiment and only did match_haptic_to_vis
    else %If they were in the second experiment and also did match_vis_to_haptic
        if second(3)==1 %Predictable group
            plot([second(1) third(1)],[second(2) third(2)],'b:')
        else %Unpredictable group
            plot([second(1) third(1)],[second(2) third(2)],'k:')
        end
    end
end
legend('Predictable, 1st task','Unpredictable, 1st task','Predictable, 2nd task','Unpredictable, 2nd task')

subplot(2,1,2); hold on; xlabel('Hit rate'); ylabel('Reaction time'); title('Relative numbers, 400 ms subtracted from second task')

for i=1:size(results,1)
    first=results(i,1:3);
    second=results(i,4:6);
    third=results(i,7:9);
    
    if ~isnan(first(1)) %if they were in the first experiment and only did match_haptic_to_vis

    else %If they were in the second experiment and also did match_vis_to_haptic
        if second(3)==1 %Predictable group
%             plot(0,0,'b.','MarkerSize',20)
            plot(third(1)-second(1),third(2)-second(2),'bo')
            plot([0 third(1)-second(1)],[0 third(2)-second(2)],'b:')
        else %Unpredictable group
%             plot(0,0,'k.','MarkerSize',20)
            plot(third(1)-second(1),third(2)-second(2),'ko')
            plot([0 third(1)-second(1)],[0 third(2)-second(2)],'k:')
        end
    end
end


figure; 
subplot(2,1,1); hold on; xlabel('First task performance'); ylabel('Second task performance'); title('% correct')
plot(results(results(:,6)==1,4),results(results(:,9)==1,7),'b.','MarkerSize',20)
plot(results(results(:,6)==2,4),results(results(:,9)==2,7),'k.','MarkerSize',20)
plot([.7 .99],[.7 .99],'k:')

subplot(2,1,2); hold on; xlabel('First task performance'); ylabel('Second task performance'); title('RT')
plot(results(results(:,6)==1,5),results(results(:,9)==1,8),'b.','MarkerSize',20)
plot(results(results(:,6)==2,5),results(results(:,9)==2,8),'k.','MarkerSize',20)


%% Compare performance at different relative angles
%expt 2, task 1, matching vis and haptic shapes

clear
DataDB = sqlite('C:\Users\Ryan\Documents\Data\graspHuman.db');
wherestring='Expt = 2 AND ExcludeSubject = 0';
subjects=unique(cellfun(@str2num,fetch(DataDB, ['Select Subject FROM trialsTable WHERE ' wherestring])));

results=[];
for i=1:size(subjects,1)
    wherestring=['Subject = ' num2str(subjects(i)) ' AND Variant = "match_haptic_to_vis" AND (RespClass = "hit" OR RespClass = "miss")'];    
    resps=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
    vals=double(cell2mat(fetch(DataDB, ['Select Congruent, ReactionTime, SampleRotation, Choice2Rotation FROM trialsTable WHERE ' wherestring])));
    vals=[vals(:,1:2) vals(:,4)-vals(:,3)]; 
    %lots of duplicate angles, consolidate to -90 0 90 180
    vals(vals(:,3)==-180,3)=180;    vals(vals(:,3)==-270,3)=90;     vals(vals(:,3)==270,3)=-90;     vals(vals(:,3)==-90,3)=90;
    
    negRT=mean(vals(vals(:,3)==-90,2));
    zeroRT=mean(vals(vals(:,3)==0,2));
    posRT=mean(vals(vals(:,3)==90,2));
    flippedRT=mean(vals(vals(:,3)==180,2));
    
    negPC=calcRespClassCorrectRate(resps(vals(:,3)==-90,:));
    zeroPC=calcRespClassCorrectRate(resps(vals(:,3)==0,:));
    posPC=calcRespClassCorrectRate(resps(vals(:,3)==90,:));
    flippedPC=calcRespClassCorrectRate(resps(vals(:,3)==180,:));

    results=[results; vals(1,1) negPC zeroPC posPC flippedPC negRT zeroRT posRT flippedRT];

end

close(DataDB)

predAlignedRT=results(results(:,1)==1,7);
predAlignedPC=results(results(:,1)==1,3);

unpredAlignedRT=results(results(:,1)==0,7);
unpredAlignedPC=results(results(:,1)==0,3);

unpredNegRT=results(results(:,1)==0,6);
unpredNegPC=results(results(:,1)==0,2);

unpredPosRT=results(results(:,1)==0,8);
unpredPosPC=results(results(:,1)==0,4);

unpredFlippedRT=results(results(:,1)==0,9);
unpredFlippedPC=results(results(:,1)==0,5);

figure;
subplot(1,2,1); hold on; xticks([1 2 3 4 5]); xticklabels({'0', '', '0','90','180'}); xlabel('Vis/haptic alignment'); ylabel('Reaction time (ms)'); title('Matching shapes')
bar([mean(predAlignedRT) mean(unpredNegRT) mean(unpredAlignedRT) mean(unpredPosRT) mean(unpredFlippedRT)])

subplot(1,2,2); hold on; xticks([1 2 3 4 5]); xticklabels({'0', '', '0','90','180'}); xlabel('Vis/haptic alignment'); ylabel('Percent Correct')
bar([mean(predAlignedPC) mean(unpredNegPC) mean(unpredAlignedPC) mean(unpredPosPC) mean(unpredFlippedPC)])


%% Compare predictable and unpredictable at zero degrees difference, line graph

clear
DataDB = sqlite('C:\Users\Ryan\Documents\Data\graspHuman.db');

%2nd experiment, simultaneous see and feel, predictable, same object
wherestring='SubjectTrial < 100 AND Variant = "match_haptic_to_vis" AND ExcludeSubject = 0 AND Congruent = 1 AND Aligned = 1';
p=double(cell2mat(fetch(DataDB, ['Select SubjectTrial, ReactionTime FROM trialsTable WHERE ' wherestring])));

%Unpredictable, same object, same orientation
wherestring='SubjectTrial < 100 AND Variant = "match_haptic_to_vis" AND ExcludeSubject = 0 AND Congruent = 0 AND Aligned = 1';
u=double(cell2mat(fetch(DataDB, ['Select SubjectTrial, ReactionTime FROM trialsTable WHERE ' wherestring])));

%Unpredictable, same object, different orientation
wherestring='SubjectTrial < 100 AND Variant = "match_haptic_to_vis" AND ExcludeSubject = 0 AND Congruent = 0 AND (RespClass = "hit" OR RespClass = "miss") AND Aligned = 0';
ud=double(cell2mat(fetch(DataDB, ['Select SubjectTrial, ReactionTime FROM trialsTable WHERE ' wherestring])));



%2nd experiment, simultaneous see and feel, predictable, same object
% wherestring='Expt = 2 AND Variant = "match_haptic_to_vis" AND ExcludeSubject = 0 AND Congruent = 1 AND Aligned = 1';
% p=double(cell2mat(fetch(DataDB, ['Select SubjectTrial, ReactionTime FROM trialsTable WHERE ' wherestring])));
% 
% %Unpredictable, same object, same orientation
% wherestring='Expt = 2 AND Variant = "match_haptic_to_vis" AND ExcludeSubject = 0 AND Congruent = 0 AND Aligned = 1';
% u=double(cell2mat(fetch(DataDB, ['Select SubjectTrial, ReactionTime FROM trialsTable WHERE ' wherestring])));
% 
% %Unpredictable, same object, different orientation
% wherestring='Expt = 2 AND Variant = "match_haptic_to_vis" AND ExcludeSubject = 0 AND Congruent = 0 AND (RespClass = "hit" OR RespClass = "miss") AND Aligned = 0';
% ud=double(cell2mat(fetch(DataDB, ['Select SubjectTrial, ReactionTime FROM trialsTable WHERE ' wherestring])));
% 



%second task

%Predictable, same object
wherestring='Expt = 2 AND Variant = "match_vis_to_haptic" AND ExcludeSubject = 0 AND Condition = 1 AND Aligned = 1';
p2=double(cell2mat(fetch(DataDB, ['Select SubjectTrial, ReactionTime FROM trialsTable WHERE ' wherestring])));

%Unpredictable, same object, same orientation
wherestring='Expt = 2 AND Variant = "match_vis_to_haptic" AND ExcludeSubject = 0 AND Condition = 2 AND Aligned = 1';
u2=double(cell2mat(fetch(DataDB, ['Select SubjectTrial, ReactionTime FROM trialsTable WHERE ' wherestring])));

close(DataDB)

%shift trial numbers so third block appears in third block
p2(:,1)=p2(:,1)+68;
u2(:,1)=u2(:,1)+68;

step=1;
window=20; %search +/- this

ma=[];
for i=1:step:84*3-window
    ps=p(p(:,1)>(i-window) & p(:,1)<(i+window),2); %predictable
    us=u(u(:,1)>(i-window) & u(:,1)<(i+window),2); %unpredicatble aligned
    uds=ud(ud(:,1)>(i-window) & ud(:,1)<(i+window),2); %unpredictable misaligned
    
    p2s=p2(p2(:,1)>(i-window) & p2(:,1)<(i+window),2); %predictable second task
    u2s=u2(u2(:,1)>(i-window) & u2(:,1)<(i+window),2); %unpredictable second task
    
%     if length(ps) < 40; ps=[]; end
%     if length(us) < 40; us=[]; end
%     if length(uds) < 40; uds=[]; end

    if i > 100
        ps=[];
        us=[];
        uds=[];
    end
    
    if i < 168
        p2s=[];
        u2s=[];
    end
    
    ma=[ma; i mean(ps) mean(us) mean(uds) mean(p2s) mean(u2s)];
end

figure; hold on; ylabel('Mean reaction time'); xlabel('Subjects trial #');
plot(ma(:,1),ma(:,2),'b')
plot(ma(:,1),ma(:,3),'k')
plot(ma(:,1),ma(:,4),'k:')

plot(ma(:,1),ma(:,5),'b--')
plot(ma(:,1),ma(:,6),'k--')


plot([83 83],[2200 7000],'k:')
plot([167 167],[2200 7000],'k:')
legend('Predictable','Unpredictable aligned','Unpredictable misaligned','Predictable haptic','Unpredictable haptic')
text(30,2300,'Block 1')
text(115,2300,'Block 2')
text(200,2300,'Block 3')


%% Compare predictable and unpredictable at zero degrees difference, line graph, separate touch and decision times

clear
DataDB = sqlite('C:\Users\Ryan\Documents\Data\graspHuman.db');


% %2nd experiment, simultaneous see and feel, predictable, same object
% wherestring='SubjectTrial < 100 AND Variant = "match_haptic_to_vis" AND ExcludeSubject = 0 AND Congruent = 1 AND Aligned = 1';
% p=double(cell2mat(fetch(DataDB, ['Select SubjectTrial, ReactionTime FROM trialsTable WHERE ' wherestring])));
% 
% %Unpredictable, same object, same orientation
% wherestring='SubjectTrial < 100 AND Variant = "match_haptic_to_vis" AND ExcludeSubject = 0 AND Congruent = 0 AND Aligned = 1';
% u=double(cell2mat(fetch(DataDB, ['Select SubjectTrial, ReactionTime FROM trialsTable WHERE ' wherestring])));
% 
% %Unpredictable, same object, different orientation
% wherestring='SubjectTrial < 100 AND Variant = "match_haptic_to_vis" AND ExcludeSubject = 0 AND Congruent = 0 AND (RespClass = "hit" OR RespClass = "miss") AND Aligned = 0';
% ud=double(cell2mat(fetch(DataDB, ['Select SubjectTrial, ReactionTime FROM trialsTable WHERE ' wherestring])));
% 

%2nd experiment, simultaneous see and feel, predictable, same object, correct
wherestring=['SubjectTrial < 100 AND Variant = "match_haptic_to_vis" AND ExcludeSubject = 0 AND Congruent = 1 AND Aligned = 1 AND RespClass = "hit"'];
p=double(cell2mat(fetch(DataDB, ['Select SubjectTrial, ReactionTime FROM trialsTable WHERE ' wherestring])));

%Unpredictable, same object, same orientation, correct
wherestring=['SubjectTrial < 100 AND Variant = "match_haptic_to_vis" AND ExcludeSubject = 0 AND Congruent = 0 AND Aligned = 1 AND RespClass = "hit"'];
u=double(cell2mat(fetch(DataDB, ['Select SubjectTrial, ReactionTime FROM trialsTable WHERE ' wherestring])));

%Unpredictable, same object, different orientation, correct
wherestring=['SubjectTrial < 100 AND Variant = "match_haptic_to_vis" AND ExcludeSubject = 0 AND Congruent = 0 AND RespClass = "hit" AND Aligned = 0'];
ud=double(cell2mat(fetch(DataDB, ['Select SubjectTrial, ReactionTime FROM trialsTable WHERE ' wherestring])));




%2nd experiment, simultaneous see and feel, predictable, same object
% wherestring='Expt = 2 AND Variant = "match_haptic_to_vis" AND ExcludeSubject = 0 AND Congruent = 1 AND Aligned = 1';
% p=double(cell2mat(fetch(DataDB, ['Select SubjectTrial, ReactionTime FROM trialsTable WHERE ' wherestring])));
% 
% %Unpredictable, same object, same orientation
% wherestring='Expt = 2 AND Variant = "match_haptic_to_vis" AND ExcludeSubject = 0 AND Congruent = 0 AND Aligned = 1';
% u=double(cell2mat(fetch(DataDB, ['Select SubjectTrial, ReactionTime FROM trialsTable WHERE ' wherestring])));
% 
% %Unpredictable, same object, different orientation
% wherestring='Expt = 2 AND Variant = "match_haptic_to_vis" AND ExcludeSubject = 0 AND Congruent = 0 AND (RespClass = "hit" OR RespClass = "miss") AND Aligned = 0';
% ud=double(cell2mat(fetch(DataDB, ['Select SubjectTrial, ReactionTime FROM trialsTable WHERE ' wherestring])));
% 



%second task

% %Predictable, same object
% wherestring='Expt = 2 AND Variant = "match_vis_to_haptic" AND ExcludeSubject = 0 AND Condition = 1 AND Aligned = 1';
% p2=double(cell2mat(fetch(DataDB, ['Select SubjectTrial, ReactionTime FROM trialsTable WHERE ' wherestring])));
% 
% %Unpredictable, same object, same orientation
% wherestring='Expt = 2 AND Variant = "match_vis_to_haptic" AND ExcludeSubject = 0 AND Condition = 2 AND Aligned = 1';
% u2=double(cell2mat(fetch(DataDB, ['Select SubjectTrial, ReactionTime FROM trialsTable WHERE ' wherestring])));
% 
% 


%Predictable, same object
wherestring=['Expt = 2 AND Variant = "match_vis_to_haptic" AND ExcludeSubject = 0 AND Condition = 1 AND Aligned = 1 AND RespClass = "hit"'];
p2=double(cell2mat(fetch(DataDB, ['Select SubjectTrial, StimOn, TargetOn, ResponseTime, PostTouchDelay FROM trialsTable WHERE ' wherestring])));

%Unpredictable, same object, same orientation
wherestring=['Expt = 2 AND Variant = "match_vis_to_haptic" AND ExcludeSubject = 0 AND Condition = 2 AND Aligned = 1 AND RespClass = "hit"'];
u2=double(cell2mat(fetch(DataDB, ['Select SubjectTrial, StimOn, TargetOn, ResponseTime, PostTouchDelay FROM trialsTable WHERE ' wherestring])));

close(DataDB)

%shift trial numbers so third block appears in third block
p2(:,1)=p2(:,1)+68;
u2(:,1)=u2(:,1)+68;

%Calculate touch time (time from fix off to hands off)
p2(:,6)=p2(:,3)-p2(:,2)-p2(:,5);
u2(:,6)=u2(:,3)-u2(:,2)-u2(:,5);

%Calculate decision time (time from vis stim on to button press)
p2(:,7)=p2(:,4)-p2(:,3);
u2(:,7)=u2(:,4)-u2(:,3);



step=1;
window=20; %search +/- this

ma=[];
for i=1:step:84*3-window
    ps=p(p(:,1)>(i-window) & p(:,1)<(i+window),2); %predictable
    us=u(u(:,1)>(i-window) & u(:,1)<(i+window),2); %unpredicatble aligned
    uds=ud(ud(:,1)>(i-window) & ud(:,1)<(i+window),2); %unpredictable misaligned
    
%     p2s=p2(p2(:,1)>(i-window) & p2(:,1)<(i+window),2); %predictable second task
%     u2s=u2(u2(:,1)>(i-window) & u2(:,1)<(i+window),2); %unpredictable second task
    
    p2t=p2(p2(:,1)>(i-window) & p2(:,1)<(i+window),6); %predictable second task
    p2d=p2(p2(:,1)>(i-window) & p2(:,1)<(i+window),7); %predictable second task
    
    u2t=u2(u2(:,1)>(i-window) & u2(:,1)<(i+window),6); %unpredictable second task
    u2d=u2(u2(:,1)>(i-window) & u2(:,1)<(i+window),7); %unpredictable second task
    
    
%     if length(ps) < 40; ps=[]; end
%     if length(us) < 40; us=[]; end
%     if length(uds) < 40; uds=[]; end

    if i > 100
        ps=[];
        us=[];
        uds=[];
    end
    
    if i < 168
        p2t=[];
        p2d=[];
        u2t=[];
        u2d=[];
    end
    
    ma=[ma; i mean(ps) mean(us) mean(uds) mean(p2t) mean(u2t) mean(p2d) mean(u2d)];
end

figure; hold on; ylabel('Mean reaction time'); xlabel('Subjects trial #');
plot(ma(:,1),ma(:,2),'b')
plot(ma(:,1),ma(:,3),'k')
plot(ma(:,1),ma(:,4),'k:')

plot(ma(:,1),ma(:,5),'b--')
plot(ma(:,1),ma(:,6),'k--')

plot(ma(:,1),ma(:,7),'b--')
plot(ma(:,1),ma(:,8),'k--')


plot([83 83],[0 7000],'k:')
plot([167 167],[0 7000],'k:')
legend('Predictable','Unpredictable aligned','Unpredictable misaligned','Predictable haptic','Unpredictable haptic')
text(30,100,'Block 1')
text(115,100,'Block 2')
text(200,100,'Block 3')

%% Compare predictable and unpredictable at zero degrees difference, line graph, separate touch and decision times, grasp times instead of reaction times

clear
DataDB = sqlite('C:\Users\Ryan\Documents\Data\graspHuman.db');


% %2nd experiment, simultaneous see and feel, predictable, same object
% wherestring='SubjectTrial < 100 AND Variant = "match_haptic_to_vis" AND ExcludeSubject = 0 AND Congruent = 1 AND Aligned = 1';
% p=double(cell2mat(fetch(DataDB, ['Select SubjectTrial, ReactionTime FROM trialsTable WHERE ' wherestring])));
% 
% %Unpredictable, same object, same orientation
% wherestring='SubjectTrial < 100 AND Variant = "match_haptic_to_vis" AND ExcludeSubject = 0 AND Congruent = 0 AND Aligned = 1';
% u=double(cell2mat(fetch(DataDB, ['Select SubjectTrial, ReactionTime FROM trialsTable WHERE ' wherestring])));
% 
% %Unpredictable, same object, different orientation
% wherestring='SubjectTrial < 100 AND Variant = "match_haptic_to_vis" AND ExcludeSubject = 0 AND Congruent = 0 AND (RespClass = "hit" OR RespClass = "miss") AND Aligned = 0';
% ud=double(cell2mat(fetch(DataDB, ['Select SubjectTrial, ReactionTime FROM trialsTable WHERE ' wherestring])));
% 

%2nd experiment, simultaneous see and feel, predictable, same object, correct
wherestring=['SubjectTrial < 100 AND Variant = "match_haptic_to_vis" AND ExcludeSubject = 0 AND Congruent = 1 AND Aligned = 1 AND RespClass = "hit"'];
p=double(cell2mat(fetch(DataDB, ['Select SubjectTrial, GraspTime FROM trialsTable WHERE ' wherestring])));

%Unpredictable, same object, same orientation, correct
wherestring=['SubjectTrial < 100 AND Variant = "match_haptic_to_vis" AND ExcludeSubject = 0 AND Congruent = 0 AND Aligned = 1 AND RespClass = "hit"'];
u=double(cell2mat(fetch(DataDB, ['Select SubjectTrial, GraspTime FROM trialsTable WHERE ' wherestring])));

%Unpredictable, same object, different orientation, correct
wherestring=['SubjectTrial < 100 AND Variant = "match_haptic_to_vis" AND ExcludeSubject = 0 AND Congruent = 0 AND RespClass = "hit" AND Aligned = 0'];
ud=double(cell2mat(fetch(DataDB, ['Select SubjectTrial, GraspTime FROM trialsTable WHERE ' wherestring])));




%2nd experiment, simultaneous see and feel, predictable, same object
% wherestring='Expt = 2 AND Variant = "match_haptic_to_vis" AND ExcludeSubject = 0 AND Congruent = 1 AND Aligned = 1';
% p=double(cell2mat(fetch(DataDB, ['Select SubjectTrial, ReactionTime FROM trialsTable WHERE ' wherestring])));
% 
% %Unpredictable, same object, same orientation
% wherestring='Expt = 2 AND Variant = "match_haptic_to_vis" AND ExcludeSubject = 0 AND Congruent = 0 AND Aligned = 1';
% u=double(cell2mat(fetch(DataDB, ['Select SubjectTrial, ReactionTime FROM trialsTable WHERE ' wherestring])));
% 
% %Unpredictable, same object, different orientation
% wherestring='Expt = 2 AND Variant = "match_haptic_to_vis" AND ExcludeSubject = 0 AND Congruent = 0 AND (RespClass = "hit" OR RespClass = "miss") AND Aligned = 0';
% ud=double(cell2mat(fetch(DataDB, ['Select SubjectTrial, ReactionTime FROM trialsTable WHERE ' wherestring])));
% 



%second task

% %Predictable, same object
% wherestring='Expt = 2 AND Variant = "match_vis_to_haptic" AND ExcludeSubject = 0 AND Condition = 1 AND Aligned = 1';
% p2=double(cell2mat(fetch(DataDB, ['Select SubjectTrial, ReactionTime FROM trialsTable WHERE ' wherestring])));
% 
% %Unpredictable, same object, same orientation
% wherestring='Expt = 2 AND Variant = "match_vis_to_haptic" AND ExcludeSubject = 0 AND Condition = 2 AND Aligned = 1';
% u2=double(cell2mat(fetch(DataDB, ['Select SubjectTrial, ReactionTime FROM trialsTable WHERE ' wherestring])));
% 
% 


%Predictable, same object
wherestring=['Expt = 2 AND Variant = "match_vis_to_haptic" AND ExcludeSubject = 0 AND Condition = 1 AND Aligned = 1 AND RespClass = "hit"'];
p2=double(cell2mat(fetch(DataDB, ['Select SubjectTrial, GraspTime, TargetOn, ResponseTime, PostTouchDelay FROM trialsTable WHERE ' wherestring])));

%Unpredictable, same object, same orientation
wherestring=['Expt = 2 AND Variant = "match_vis_to_haptic" AND ExcludeSubject = 0 AND Condition = 2 AND Aligned = 1 AND RespClass = "hit"'];
u2=double(cell2mat(fetch(DataDB, ['Select SubjectTrial, GraspTime, TargetOn, ResponseTime, PostTouchDelay FROM trialsTable WHERE ' wherestring])));

close(DataDB)

%shift trial numbers so third block appears in third block
p2(:,1)=p2(:,1)+68;
u2(:,1)=u2(:,1)+68;

%grasp time
p2(:,6)=p2(:,2);
u2(:,6)=u2(:,2);

%Calculate decision time (time from vis stim on to button press)
p2(:,7)=p2(:,4)-p2(:,3);
u2(:,7)=u2(:,4)-u2(:,3);



step=1;
window=20; %search +/- this

ma=[];
for i=1:step:84*3-window
    ps=p(p(:,1)>(i-window) & p(:,1)<(i+window),2); %predictable
    us=u(u(:,1)>(i-window) & u(:,1)<(i+window),2); %unpredicatble aligned
    uds=ud(ud(:,1)>(i-window) & ud(:,1)<(i+window),2); %unpredictable misaligned
    
%     p2s=p2(p2(:,1)>(i-window) & p2(:,1)<(i+window),2); %predictable second task
%     u2s=u2(u2(:,1)>(i-window) & u2(:,1)<(i+window),2); %unpredictable second task
    
    p2t=p2(p2(:,1)>(i-window) & p2(:,1)<(i+window),6); %predictable second task
    p2d=p2(p2(:,1)>(i-window) & p2(:,1)<(i+window),7); %predictable second task
    
    u2t=u2(u2(:,1)>(i-window) & u2(:,1)<(i+window),6); %unpredictable second task
    u2d=u2(u2(:,1)>(i-window) & u2(:,1)<(i+window),7); %unpredictable second task
    
    
%     if length(ps) < 40; ps=[]; end
%     if length(us) < 40; us=[]; end
%     if length(uds) < 40; uds=[]; end

    if i > 100
        ps=[];
        us=[];
        uds=[];
    end
    
    if i < 168
        p2t=[];
        p2d=[];
        u2t=[];
        u2d=[];
    end
    
    ma=[ma; i mean(ps) mean(us) mean(uds) mean(p2t) mean(u2t) mean(p2d) mean(u2d)];
end

figure; hold on; ylabel('Mean grasp time'); xlabel('Subjects trial #');
plot(ma(:,1),ma(:,2),'b')
plot(ma(:,1),ma(:,3),'k')
plot(ma(:,1),ma(:,4),'k:')

plot(ma(:,1),ma(:,5),'b--')
plot(ma(:,1),ma(:,6),'k--')

plot(ma(:,1),ma(:,7),'b--')
plot(ma(:,1),ma(:,8),'k--')


plot([83 83],[0 7000],'k:')
plot([167 167],[0 7000],'k:')
legend('Predictable','Unpredictable aligned','Unpredictable misaligned','Predictable haptic','Unpredictable haptic')
text(30,100,'Block 1')
text(115,100,'Block 2')
text(200,100,'Block 3')

%% Compare predictable and unpredictable at zero degrees difference, line graph, separate touch and decision times, specific shape only

clear
DataDB = sqlite('C:\Users\Ryan\Documents\Data\graspHuman.db');

tar = 14;

% %2nd experiment, simultaneous see and feel, predictable, same object
% wherestring='SubjectTrial < 100 AND Variant = "match_haptic_to_vis" AND ExcludeSubject = 0 AND Congruent = 1 AND Aligned = 1';
% p=double(cell2mat(fetch(DataDB, ['Select SubjectTrial, ReactionTime FROM trialsTable WHERE ' wherestring])));
% 
% %Unpredictable, same object, same orientation
% wherestring='SubjectTrial < 100 AND Variant = "match_haptic_to_vis" AND ExcludeSubject = 0 AND Congruent = 0 AND Aligned = 1';
% u=double(cell2mat(fetch(DataDB, ['Select SubjectTrial, ReactionTime FROM trialsTable WHERE ' wherestring])));
% 
% %Unpredictable, same object, different orientation
% wherestring='SubjectTrial < 100 AND Variant = "match_haptic_to_vis" AND ExcludeSubject = 0 AND Congruent = 0 AND (RespClass = "hit" OR RespClass = "miss") AND Aligned = 0';
% ud=double(cell2mat(fetch(DataDB, ['Select SubjectTrial, ReactionTime FROM trialsTable WHERE ' wherestring])));
% 

%2nd experiment, simultaneous see and feel, predictable, same object, correct
wherestring=['SubjectTrial < 100 AND Variant = "match_haptic_to_vis" AND ExcludeSubject = 0 AND Congruent = 1 AND Aligned = 1 AND RespClass = "hit" AND Target = ' num2str(tar)];
p=double(cell2mat(fetch(DataDB, ['Select SubjectTrial, ReactionTime FROM trialsTable WHERE ' wherestring])));

%Unpredictable, same object, same orientation, correct
wherestring=['SubjectTrial < 100 AND Variant = "match_haptic_to_vis" AND ExcludeSubject = 0 AND Congruent = 0 AND Aligned = 1 AND RespClass = "hit" AND Target = ' num2str(tar)];
u=double(cell2mat(fetch(DataDB, ['Select SubjectTrial, ReactionTime FROM trialsTable WHERE ' wherestring])));

%Unpredictable, same object, different orientation, correct
wherestring=['SubjectTrial < 100 AND Variant = "match_haptic_to_vis" AND ExcludeSubject = 0 AND Congruent = 0 AND RespClass = "hit" AND Aligned = 0 AND Target = ' num2str(tar)];
ud=double(cell2mat(fetch(DataDB, ['Select SubjectTrial, ReactionTime FROM trialsTable WHERE ' wherestring])));




%2nd experiment, simultaneous see and feel, predictable, same object
% wherestring='Expt = 2 AND Variant = "match_haptic_to_vis" AND ExcludeSubject = 0 AND Congruent = 1 AND Aligned = 1';
% p=double(cell2mat(fetch(DataDB, ['Select SubjectTrial, ReactionTime FROM trialsTable WHERE ' wherestring])));
% 
% %Unpredictable, same object, same orientation
% wherestring='Expt = 2 AND Variant = "match_haptic_to_vis" AND ExcludeSubject = 0 AND Congruent = 0 AND Aligned = 1';
% u=double(cell2mat(fetch(DataDB, ['Select SubjectTrial, ReactionTime FROM trialsTable WHERE ' wherestring])));
% 
% %Unpredictable, same object, different orientation
% wherestring='Expt = 2 AND Variant = "match_haptic_to_vis" AND ExcludeSubject = 0 AND Congruent = 0 AND (RespClass = "hit" OR RespClass = "miss") AND Aligned = 0';
% ud=double(cell2mat(fetch(DataDB, ['Select SubjectTrial, ReactionTime FROM trialsTable WHERE ' wherestring])));
% 



%second task

% %Predictable, same object
% wherestring='Expt = 2 AND Variant = "match_vis_to_haptic" AND ExcludeSubject = 0 AND Condition = 1 AND Aligned = 1';
% p2=double(cell2mat(fetch(DataDB, ['Select SubjectTrial, ReactionTime FROM trialsTable WHERE ' wherestring])));
% 
% %Unpredictable, same object, same orientation
% wherestring='Expt = 2 AND Variant = "match_vis_to_haptic" AND ExcludeSubject = 0 AND Condition = 2 AND Aligned = 1';
% u2=double(cell2mat(fetch(DataDB, ['Select SubjectTrial, ReactionTime FROM trialsTable WHERE ' wherestring])));
% 
% 


%Predictable, same object
wherestring=['Expt = 2 AND Variant = "match_vis_to_haptic" AND ExcludeSubject = 0 AND Condition = 1 AND Aligned = 1 AND RespClass = "hit" AND Target = ' num2str(tar)];
p2=double(cell2mat(fetch(DataDB, ['Select SubjectTrial, StimOn, TargetOn, ResponseTime, PostTouchDelay FROM trialsTable WHERE ' wherestring])));

%Unpredictable, same object, same orientation
wherestring=['Expt = 2 AND Variant = "match_vis_to_haptic" AND ExcludeSubject = 0 AND Condition = 2 AND Aligned = 1 AND RespClass = "hit" AND Target = ' num2str(tar)];
u2=double(cell2mat(fetch(DataDB, ['Select SubjectTrial, StimOn, TargetOn, ResponseTime, PostTouchDelay FROM trialsTable WHERE ' wherestring])));

close(DataDB)

%shift trial numbers so third block appears in third block
p2(:,1)=p2(:,1)+68;
u2(:,1)=u2(:,1)+68;

%Calculate touch time (time from fix off to hands off)
p2(:,6)=p2(:,3)-p2(:,2)-p2(:,5);
u2(:,6)=u2(:,3)-u2(:,2)-u2(:,5);

%Calculate decision time (time from vis stim on to button press)
p2(:,7)=p2(:,4)-p2(:,3);
u2(:,7)=u2(:,4)-u2(:,3);



step=1;
window=20; %search +/- this

ma=[];
for i=1:step:84*3-window
    ps=p(p(:,1)>(i-window) & p(:,1)<(i+window),2); %predictable
    us=u(u(:,1)>(i-window) & u(:,1)<(i+window),2); %unpredicatble aligned
    uds=ud(ud(:,1)>(i-window) & ud(:,1)<(i+window),2); %unpredictable misaligned
    
%     p2s=p2(p2(:,1)>(i-window) & p2(:,1)<(i+window),2); %predictable second task
%     u2s=u2(u2(:,1)>(i-window) & u2(:,1)<(i+window),2); %unpredictable second task
    
    p2t=p2(p2(:,1)>(i-window) & p2(:,1)<(i+window),6); %predictable second task
    p2d=p2(p2(:,1)>(i-window) & p2(:,1)<(i+window),7); %predictable second task
    
    u2t=u2(u2(:,1)>(i-window) & u2(:,1)<(i+window),6); %unpredictable second task
    u2d=u2(u2(:,1)>(i-window) & u2(:,1)<(i+window),7); %unpredictable second task
    
    
%     if length(ps) < 40; ps=[]; end
%     if length(us) < 40; us=[]; end
%     if length(uds) < 40; uds=[]; end

    if i > 100
        ps=[];
        us=[];
        uds=[];
    end
    
    if i < 168
        p2t=[];
        p2d=[];
        u2t=[];
        u2d=[];
    end
    
    ma=[ma; i mean(ps) mean(us) mean(uds) mean(p2t) mean(u2t) mean(p2d) mean(u2d)];
end

figure; hold on; ylabel('Mean reaction time'); xlabel('Subjects trial #');
plot(ma(:,1),ma(:,2),'b')
plot(ma(:,1),ma(:,3),'k')
plot(ma(:,1),ma(:,4),'k:')

plot(ma(:,1),ma(:,5),'b--')
plot(ma(:,1),ma(:,6),'k--')

plot(ma(:,1),ma(:,7),'b--')
plot(ma(:,1),ma(:,8),'k--')


plot([83 83],[0 7000],'k:')
plot([167 167],[0 7000],'k:')
legend('Predictable','Unpredictable aligned','Unpredictable misaligned','Predictable haptic','Unpredictable haptic')
text(30,100,'Block 1')
text(115,100,'Block 2')
text(200,100,'Block 3')


%% Compare flipped with non-flipped, touch times and decision times

clear
DataDB = sqlite('C:\Users\Ryan\Documents\Data\graspHuman.db');

%Predictable, same object
wherestring='Expt = 2 AND Variant = "match_vis_to_haptic" AND ExcludeSubject = 0 AND Condition = 1 AND Aligned = 1';
p=double(cell2mat(fetch(DataDB, ['Select Flip, StimOn, TargetOn, ResponseTime, PostTouchDelay FROM trialsTable WHERE ' wherestring])));
wherestring='Expt = 2 AND Variant = "match_vis_to_haptic" AND ExcludeSubject = 0 AND Condition = 1 AND Aligned = 1 AND Flip = 1';
pflip=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
wherestring='Expt = 2 AND Variant = "match_vis_to_haptic" AND ExcludeSubject = 0 AND Condition = 1 AND Aligned = 1 AND Flip = 0';
pnotflip=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);

%Unpredictable, same object, same orientation
wherestring='Expt = 2 AND Variant = "match_vis_to_haptic" AND ExcludeSubject = 0 AND Condition = 2 AND Aligned = 1';
u=double(cell2mat(fetch(DataDB, ['Select Flip, StimOn, TargetOn, ResponseTime, PostTouchDelay FROM trialsTable WHERE ' wherestring])));
wherestring='Expt = 2 AND Variant = "match_vis_to_haptic" AND ExcludeSubject = 0 AND Condition = 2 AND Aligned = 1 AND Flip = 1';
uflip=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
wherestring='Expt = 2 AND Variant = "match_vis_to_haptic" AND ExcludeSubject = 0 AND Condition = 2 AND Aligned = 1 AND Flip = 0';
unotflip=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);

close(DataDB)

hitpflip = calcRespClassCorrectRate(pflip)*100;
hitpnotflip = calcRespClassCorrectRate(pnotflip)*100;
hituflip = calcRespClassCorrectRate(uflip)*100;
hitunotflip = calcRespClassCorrectRate(unotflip)*100;


%Calculate touch time (time from fix off to hands off)
p(:,6)=p(:,3)-p(:,2)-p(:,5);
u(:,6)=u(:,3)-u(:,2)-u(:,5);

%Calculate decision time (time from vis stim on to button press)
p(:,7)=p(:,4)-p(:,3);
u(:,7)=u(:,4)-u(:,3);


figure; 
subplot(1,3,1); hold on; title('Touch time'); xticks([1 2]); xticklabels({'Predictable', 'Unpredictable'})
bar([mean(p(:,6)), mean(u(:,6))])

subplot(1,3,2); hold on; title('Decision time'); xticks([1 2]); xticklabels({'Predictable', 'Unpredictable'});
bar([mean(p(p(:,1)==0,7)), mean(p(p(:,1)==1,7)); mean(u(u(:,1)==0,7)), mean(u(u(:,1)==1,7))])
legend('Not flipped','Flipped')

subplot(1,3,3); hold on; title('Hit rate'); xticks([1 2]); xticklabels({'Predictable', 'Unpredictable'});
bar([hitpflip, hitpnotflip; hituflip, hitunotflip]);
legend('Not flipped','Flipped')

%% Compare flipped with non-flipped, decision times, correct trials only, statistics by subject

clear
DataDB = sqlite('C:\Users\Ryan\Documents\Data\graspHuman.db');

%Predictable, same object
wherestring='Expt = 2 AND Variant = "match_vis_to_haptic" AND ExcludeSubject = 0 AND Condition = 1 AND Aligned = 1 AND (RespClass = "hit" OR RespClass = "cr")';
p=fetch(DataDB, ['Select Subject, Flip, StimOn, TargetOn, ResponseTime, PostTouchDelay FROM trialsTable WHERE ' wherestring]);

%Unpredictable, same object, same orientation
wherestring='Expt = 2 AND Variant = "match_vis_to_haptic" AND ExcludeSubject = 0 AND Condition = 2 AND Aligned = 1 AND (RespClass = "hit" OR RespClass = "cr")';
u=fetch(DataDB, ['Select Subject, Flip, StimOn, TargetOn, ResponseTime, PostTouchDelay FROM trialsTable WHERE ' wherestring]);

close(DataDB)

%reformat from cell to double
p=[str2num(cell2mat(p(:,1))) double(cell2mat(p(:,2:end)))];
u=[str2num(cell2mat(u(:,1))) double(cell2mat(u(:,2:end)))];

%Calculate decision time (time from vis stim on to button press)
p(:,7)=p(:,5)-p(:,4);
u(:,7)=u(:,5)-u(:,4);

%calculate decision time per subject
s=unique(p(:,1));
pmat=[];
for i=1:length(s)
    pmat=[pmat; mean(p(p(:,1)==s(i) & p(:,2)==0,7)) mean(p(p(:,1)==s(i) & p(:,2)==1,7))];
end

s=unique(u(:,1));
umat=[];
for i=1:length(s)
    umat=[umat; mean(u(u(:,1)==s(i) & u(:,2)==0,7)) mean(u(u(:,1)==s(i) & u(:,2)==1,7))];
end

figure; 

hold on; title('Decision time'); xticks([1 2]); xticklabels({'Predictable', 'Unpredictable'});
bar([mean(p(p(:,2)==0,7)), mean(p(p(:,2)==1,7)); mean(u(u(:,2)==0,7)), mean(u(u(:,2)==1,7))])
legend('Not flipped','Flipped')

[h p]=ttest(pmat(:,1),pmat(:,2));
[hu pu]=ttest(umat(:,1),umat(:,2));

disp(['decision time differences between flipped and non-flipped: Predictable p = ' num2str(p,3) ' Unpredictable p = ' num2str(pu,3)])


%% Compare subject-wise reaction times from both experiments in predictable vs. unpredictable

clear
DataDB = sqlite('C:\Users\Ryan\Documents\Data\graspHuman.db');
wherestring='ExcludeSubject = 0';
subjects=unique(cellfun(@str2num,fetch(DataDB, ['Select Subject FROM trialsTable WHERE ' wherestring])));

window=20;
results=[];
results2=[];
results3=[]; %touch time and decision time by subject
for i=1:size(subjects,1)
    
    % first 100 trials from match_haptic_to_vis where the shapes are matched
    wherestring=['Variant = "match_haptic_to_vis"  AND SubjectTrial < 101 AND subject = ' num2str(subjects(i))];
    a=double(cell2mat(fetch(DataDB, ['Select SubjectTrial, Aligned, Condition, ReactionTime FROM trialsTable WHERE ' wherestring])));
    
    part=[];
    for ii=window/2:window:100-window/2
        predictableAligned =         mean(a(a(:,1)>(ii-window/2) & a(:,1)<(ii+window/2) & a(:,2) == 1 & a(:,3)==1,4));
        unpredictableAligned =       mean(a(a(:,1)>(ii-window/2) & a(:,1)<(ii+window/2) & a(:,2) == 1 & a(:,3)==2,4));
        unpredictableUnaligned =     mean(a(a(:,1)>(ii-window/2) & a(:,1)<(ii+window/2) & a(:,2) == 0 & a(:,3)==2,4));
        
        if isempty(predictableAligned);     predictableAligned=nan;     end
        if isempty(unpredictableAligned);   unpredictableAligned=nan;   end
        if isempty(unpredictableUnaligned); unpredictableUnaligned=nan; end
        part=[part; ii predictableAligned unpredictableAligned unpredictableUnaligned];
    end
    
    results(:,:,i) = part;
    


end

wherestring='ExcludeSubject = 0 AND Expt = 2';
subjects=unique(cellfun(@str2num,fetch(DataDB, ['Select Subject FROM trialsTable WHERE ' wherestring])));

for i=1:size(subjects,1)
    % match_vis_to_haptic where the shapes are matched
    wherestring=['Variant = "match_vis_to_haptic"  AND (RespClass = "hit" OR RespClass = "miss") AND subject = ' num2str(subjects(i))];
    a=double(cell2mat(fetch(DataDB, ['Select SubjectTrial, Aligned, Condition, ReactionTime FROM trialsTable WHERE ' wherestring])));
    
    
    
    
    wherestring=['Expt = 2 AND Variant = "match_vis_to_haptic" AND ExcludeSubject = 0 AND Condition = 1 AND Aligned = 1 AND subject = ' num2str(subjects(i))];
    p=double(cell2mat(fetch(DataDB, ['Select Flip, StimOn, TargetOn, ResponseTime, PostTouchDelay FROM trialsTable WHERE ' wherestring])));
    pgt=double(cell2mat(fetch(DataDB, ['Select GraspTime FROM trialsTable WHERE ' wherestring])));
    if ~isempty(p)
        p(:,6)=p(:,3)-p(:,2)-p(:,5);    %Calculate touch time (time from fix off to hands off)
        p(:,7)=p(:,4)-p(:,3);           %Calculate decision time (time from vis stim on to button press)
        aved=mean(p);
        results3=[results3; 0 aved(6) aved(7) mean(pgt)];
    end
    
    wherestring=['Expt = 2 AND Variant = "match_vis_to_haptic" AND ExcludeSubject = 0 AND Condition = 2 AND Aligned = 1 AND subject = ' num2str(subjects(i))] ;
    u=double(cell2mat(fetch(DataDB, ['Select Flip, StimOn, TargetOn, ResponseTime, PostTouchDelay FROM trialsTable WHERE ' wherestring])));
    ugt=double(cell2mat(fetch(DataDB, ['Select GraspTime FROM trialsTable WHERE ' wherestring])));
    if ~isempty(u)
        u(:,6)=u(:,3)-u(:,2)-u(:,5);
        u(:,7)=u(:,4)-u(:,3);
        aved=mean(u);
        results3=[results3; 1 aved(6) aved(7) mean(ugt)];
    end
    
    
    
    
    
    
    part=[];
    for ii=100+window/2:window:200-window/2
        predictableAligned =         mean(a(a(:,1)>(ii-window/2) & a(:,1)<(ii+window/2) & a(:,2) == 1 & a(:,3)==1,4));
        unpredictableAligned =       mean(a(a(:,1)>(ii-window/2) & a(:,1)<(ii+window/2) & a(:,2) == 1 & a(:,3)==2,4));
        unpredictableUnaligned =     mean(a(a(:,1)>(ii-window/2) & a(:,1)<(ii+window/2) & a(:,2) == 0 & a(:,3)==2,4));
        
        if isempty(predictableAligned);     predictableAligned=nan;     end
        if isempty(unpredictableAligned);   unpredictableAligned=nan;   end
        if isempty(unpredictableUnaligned); unpredictableUnaligned=nan; end
        part=[part; ii predictableAligned unpredictableAligned unpredictableUnaligned];
    end
    
    results2(:,:,i) = part;


end

close(DataDB)


% b=[squeeze(results(1,2:4,:))' squeeze(results(2,2:4,:))' squeeze(results(3,2:4,:))' squeeze(results(4,2:4,:))' squeeze(results(5,2:4,:))'];


figure; subplot(3,1,1); hold on; xlabel('Trial number'); ylabel('Reaction Time')

   
for i=1:5
    p=squeeze(results(i,2,:));
    p=p(~isnan(p));
    u=squeeze(results(i,3,:));
    u=u(~isnan(u));
    uu=squeeze(results(i,4,:));
    uu=uu(~isnan(uu));
    
    plot(ones(size(p))*(i*window-window/2-1),p,'bo')
    plot(ones(size(u))*(i*window-window/2+1),u,'ko')
    plot(ones(size(uu))*(i*window-window/2+3),uu,'ro')
    
end

subplot(3,1,2); hold on; xlabel('Trial number'); ylabel('Reaction Time')   
for i=1:5
    p=squeeze(results2(i,2,:));
    p=p(~isnan(p));
    u=squeeze(results2(i,3,:));
    u=u(~isnan(u));
    
    plot(ones(size(p))*(i*window-window/2-1),p,'bo')
    plot(ones(size(u))*(i*window-window/2+1),u,'ko')
    
end


predTouch=results3(results3(:,1)==0,2);
predDecide=results3(results3(:,1)==0,3);
unpredTouch=results3(results3(:,1)==1,2);
unpredDecide=results3(results3(:,1)==1,3);
predBoth=results3(results3(:,1)==0,2)+results3(results3(:,1)==0,3);
unpredBoth=results3(results3(:,1)==1,2)+results3(results3(:,1)==1,3);

ptm=mean(predTouch);
pdm=mean(predDecide);
utm=mean(unpredTouch);
udm=mean(unpredDecide);



pts=std(predTouch)/sqrt(length(predTouch));
pds=std(predDecide)/sqrt(length(predDecide));
uts=std(unpredTouch)/sqrt(length(unpredTouch));
uds=std(unpredDecide)/sqrt(length(unpredDecide));
 
subplot(3,2,5); hold on; ylabel('Touch time'); xticks([1 2]); xticklabels({'Predictable', 'Unpredictable'})
bar([ptm utm])
errorbar([ptm utm],[pts uts],'.')

subplot(3,2,6); hold on; ylabel('Decision time'); xticks([1 2]); xticklabels({'Predictable', 'Unpredictable'})
bar([pdm udm])
errorbar([pdm udm],[pds uds],'.')
disp('Touch time diffs')
[h p]=ttest2(predTouch,unpredTouch)
disp('Decision time diffs')
[h p]=ttest2(predDecide,unpredDecide)
disp('Combined time diffs')
[h p]=ttest2(predBoth,unpredBoth)



%% Compare subject-wise reaction times from both experiments in predictable vs. unpredictable, ONLY CORRECT TRIALS

clear
DataDB = sqlite('C:\Users\Ryan\Documents\Data\graspHuman.db');
wherestring='ExcludeSubject = 0';
subjects=unique(cellfun(@str2num,fetch(DataDB, ['Select Subject FROM trialsTable WHERE ' wherestring])));

window=20;
results=[];
results2=[];
results3=[]; %touch time and decision time by subject
for i=1:size(subjects,1)
    
    % first 100 trials from match_haptic_to_vis where the shapes are matched
    wherestring=['Variant = "match_haptic_to_vis"  AND SubjectTrial < 101 AND subject = ' num2str(subjects(i)) ' AND (RespClass = "hit" OR RespClass = "cr")'];
    a=double(cell2mat(fetch(DataDB, ['Select SubjectTrial, Aligned, Condition, ReactionTime FROM trialsTable WHERE ' wherestring])));
    
    part=[];
    for ii=window/2:window:100-window/2
        predictableAligned =         mean(a(a(:,1)>(ii-window/2) & a(:,1)<(ii+window/2) & a(:,2) == 1 & a(:,3)==1,4));
        unpredictableAligned =       mean(a(a(:,1)>(ii-window/2) & a(:,1)<(ii+window/2) & a(:,2) == 1 & a(:,3)==2,4));
        unpredictableUnaligned =     mean(a(a(:,1)>(ii-window/2) & a(:,1)<(ii+window/2) & a(:,2) == 0 & a(:,3)==2,4));
        
        if isempty(predictableAligned);     predictableAligned=nan;     end
        if isempty(unpredictableAligned);   unpredictableAligned=nan;   end
        if isempty(unpredictableUnaligned); unpredictableUnaligned=nan; end
        part=[part; ii predictableAligned unpredictableAligned unpredictableUnaligned];
    end
    
    results(:,:,i) = part;
    


end

wherestring='ExcludeSubject = 0 AND Expt = 2';
subjects=unique(cellfun(@str2num,fetch(DataDB, ['Select Subject FROM trialsTable WHERE ' wherestring])));

for i=1:size(subjects,1)
    % match_vis_to_haptic where the shapes are matched
    wherestring=['Variant = "match_vis_to_haptic"  AND RespClass = "hit" AND subject = ' num2str(subjects(i))];
    a=double(cell2mat(fetch(DataDB, ['Select SubjectTrial, Aligned, Condition, ReactionTime FROM trialsTable WHERE ' wherestring])));
    
    
    
    
    wherestring=['Expt = 2 AND Variant = "match_vis_to_haptic" AND ExcludeSubject = 0 AND Condition = 1 AND RespClass = "hit" AND Aligned = 1 AND subject = ' num2str(subjects(i))];
%     wherestring=['Expt = 2 AND Variant = "match_vis_to_haptic" AND SubjectTrial > 163 AND SubjectTrial < 184 AND ExcludeSubject = 0 AND Condition = 1 AND RespClass = "hit" AND Aligned = 1 AND subject = ' num2str(subjects(i))];
    p=double(cell2mat(fetch(DataDB, ['Select Flip, StimOn, TargetOn, ResponseTime, PostTouchDelay FROM trialsTable WHERE ' wherestring])));
    pgt=double(cell2mat(fetch(DataDB, ['Select GraspTime FROM trialsTable WHERE ' wherestring])));
    if ~isempty(p)
        p(:,6)=p(:,3)-p(:,2)-p(:,5);    %Calculate touch time (time from fix off to hands off)
        p(:,7)=p(:,4)-p(:,3);           %Calculate decision time (time from vis stim on to button press)
        aved=mean(p);
        results3=[results3; 0 aved(6) aved(7) mean(pgt)];
    end
    
    wherestring=['Expt = 2 AND Variant = "match_vis_to_haptic" AND ExcludeSubject = 0 AND Condition = 2 AND RespClass = "hit" AND Aligned = 1 AND subject = ' num2str(subjects(i))] ;
%     wherestring=['Expt = 2 AND Variant = "match_vis_to_haptic" AND SubjectTrial > 163 AND SubjectTrial < 184 AND ExcludeSubject = 0 AND Condition = 2 AND RespClass = "hit" AND Aligned = 1 AND subject = ' num2str(subjects(i))] ;
    u=double(cell2mat(fetch(DataDB, ['Select Flip, StimOn, TargetOn, ResponseTime, PostTouchDelay FROM trialsTable WHERE ' wherestring])));
    ugt=double(cell2mat(fetch(DataDB, ['Select GraspTime FROM trialsTable WHERE ' wherestring])));
    if ~isempty(u)
        u(:,6)=u(:,3)-u(:,2)-u(:,5);
        u(:,7)=u(:,4)-u(:,3);
        aved=mean(u);
        results3=[results3; 1 aved(6) aved(7) mean(ugt)];
    end
    
    
    
    
    
    
    part=[];
    for ii=100+window/2:window:200-window/2
        predictableAligned =         mean(a(a(:,1)>(ii-window/2) & a(:,1)<(ii+window/2) & a(:,2) == 1 & a(:,3)==1,4));
        unpredictableAligned =       mean(a(a(:,1)>(ii-window/2) & a(:,1)<(ii+window/2) & a(:,2) == 1 & a(:,3)==2,4));
        unpredictableUnaligned =     mean(a(a(:,1)>(ii-window/2) & a(:,1)<(ii+window/2) & a(:,2) == 0 & a(:,3)==2,4));
        
        if isempty(predictableAligned);     predictableAligned=nan;     end
        if isempty(unpredictableAligned);   unpredictableAligned=nan;   end
        if isempty(unpredictableUnaligned); unpredictableUnaligned=nan; end
        part=[part; ii predictableAligned unpredictableAligned unpredictableUnaligned];
    end
    
    results2(:,:,i) = part;


end

close(DataDB)


% b=[squeeze(results(1,2:4,:))' squeeze(results(2,2:4,:))' squeeze(results(3,2:4,:))' squeeze(results(4,2:4,:))' squeeze(results(5,2:4,:))'];


figure; subplot(3,1,1); hold on; xlabel('Trial number'); ylabel('Reaction Time'); title('Correct trials only')

   
for i=1:5
    p=squeeze(results(i,2,:));
    p=p(~isnan(p));
    u=squeeze(results(i,3,:));
    u=u(~isnan(u));
    uu=squeeze(results(i,4,:));
    uu=uu(~isnan(uu));
    
    plot(ones(size(p))*(i*window-window/2-1),p,'bo')
    plot(ones(size(u))*(i*window-window/2+1),u,'ko')
    plot(ones(size(uu))*(i*window-window/2+3),uu,'ro')
    
end

subplot(3,1,2); hold on; xlabel('Trial number'); ylabel('Reaction Time')   
for i=1:5
    p=squeeze(results2(i,2,:));
    p=p(~isnan(p));
    u=squeeze(results2(i,3,:));
    u=u(~isnan(u));
    
    plot(ones(size(p))*(i*window-window/2-1),p,'bo')
    plot(ones(size(u))*(i*window-window/2+1),u,'ko')
    
end


predTouch=results3(results3(:,1)==0,2);
predDecide=results3(results3(:,1)==0,3);
unpredTouch=results3(results3(:,1)==1,2);
unpredDecide=results3(results3(:,1)==1,3);
predBoth=results3(results3(:,1)==0,2)+results3(results3(:,1)==0,3);
unpredBoth=results3(results3(:,1)==1,2)+results3(results3(:,1)==1,3);

ptm=mean(predTouch);
pdm=mean(predDecide);
utm=mean(unpredTouch);
udm=mean(unpredDecide);



pts=std(predTouch)/sqrt(length(predTouch));
pds=std(predDecide)/sqrt(length(predDecide));
uts=std(unpredTouch)/sqrt(length(unpredTouch));
uds=std(unpredDecide)/sqrt(length(unpredDecide));
 
subplot(3,2,5); hold on; ylabel('Touch time'); xticks([1 2]); xticklabels({'Predictable', 'Unpredictable'})
bar([ptm utm])
errorbar([ptm utm],[pts uts],'.')

subplot(3,2,6); hold on; ylabel('Decision time'); xticks([1 2]); xticklabels({'Predictable', 'Unpredictable'})
bar([pdm udm])
errorbar([pdm udm],[pds uds],'.')
disp('Touch time diffs')
[h p]=ttest2(predTouch,unpredTouch)
disp('Decision time diffs')
[h p]=ttest2(predDecide,unpredDecide)
disp('Combined time diffs')
[h p]=ttest2(predBoth,unpredBoth)

%% Compare subject-wise reaction times from both experiments in predictable vs. unpredictable, ONLY CORRECT TRIALS, ONLY SPECIFIC SHAPE

clear
DataDB = sqlite('C:\Users\Ryan\Documents\Data\graspHuman.db');
wherestring='ExcludeSubject = 0';
subjects=unique(cellfun(@str2num,fetch(DataDB, ['Select Subject FROM trialsTable WHERE ' wherestring])));

obj=10;

window=20;
results=[];
results2=[];
results3=[]; %touch time and decision time by subject
for i=1:size(subjects,1)
    
    % first 100 trials from match_haptic_to_vis where the shapes are matched
    wherestring=['Variant = "match_haptic_to_vis"  AND SubjectTrial < 101 AND subject = ' num2str(subjects(i)) ' AND (RespClass = "hit" OR RespClass = "cr") and Target = ' num2str(obj)];
    a=double(cell2mat(fetch(DataDB, ['Select SubjectTrial, Aligned, Condition, ReactionTime FROM trialsTable WHERE ' wherestring])));
    
    part=[];
    for ii=window/2:window:100-window/2
        predictableAligned =         mean(a(a(:,1)>(ii-window/2) & a(:,1)<(ii+window/2) & a(:,2) == 1 & a(:,3)==1,4));
        unpredictableAligned =       mean(a(a(:,1)>(ii-window/2) & a(:,1)<(ii+window/2) & a(:,2) == 1 & a(:,3)==2,4));
        unpredictableUnaligned =     mean(a(a(:,1)>(ii-window/2) & a(:,1)<(ii+window/2) & a(:,2) == 0 & a(:,3)==2,4));
        
        if isempty(predictableAligned);     predictableAligned=nan;     end
        if isempty(unpredictableAligned);   unpredictableAligned=nan;   end
        if isempty(unpredictableUnaligned); unpredictableUnaligned=nan; end
        part=[part; ii predictableAligned unpredictableAligned unpredictableUnaligned];
    end
    
    results(:,:,i) = part;
    


end

wherestring='ExcludeSubject = 0 AND Expt = 2';
subjects=unique(cellfun(@str2num,fetch(DataDB, ['Select Subject FROM trialsTable WHERE ' wherestring])));

for i=1:size(subjects,1)
    % match_vis_to_haptic where the shapes are matched
    wherestring=['Variant = "match_vis_to_haptic"  AND RespClass = "hit" AND subject = ' num2str(subjects(i)) ' and Target = ' num2str(obj)];
    a=double(cell2mat(fetch(DataDB, ['Select SubjectTrial, Aligned, Condition, ReactionTime FROM trialsTable WHERE ' wherestring])));
    
    
    
    
    wherestring=['Expt = 2 AND Variant = "match_vis_to_haptic" AND ExcludeSubject = 0 AND Condition = 1 AND RespClass = "hit" AND Aligned = 1 AND subject = ' num2str(subjects(i)) ' and Target = ' num2str(obj)];
%     wherestring=['Expt = 2 AND Variant = "match_vis_to_haptic" AND SubjectTrial > 163 AND SubjectTrial < 184 AND ExcludeSubject = 0 AND Condition = 1 AND RespClass = "hit" AND Aligned = 1 AND subject = ' num2str(subjects(i))];
    p=double(cell2mat(fetch(DataDB, ['Select Flip, StimOn, TargetOn, ResponseTime, PostTouchDelay FROM trialsTable WHERE ' wherestring])));
    pgt=double(cell2mat(fetch(DataDB, ['Select GraspTime FROM trialsTable WHERE ' wherestring])));
    if ~isempty(p)
        p(:,6)=p(:,3)-p(:,2)-p(:,5);    %Calculate touch time (time from fix off to hands off)
        p(:,7)=p(:,4)-p(:,3);           %Calculate decision time (time from vis stim on to button press)
        aved=mean(p);
        results3=[results3; 0 aved(6) aved(7) mean(pgt)];
    end
    
    wherestring=['Expt = 2 AND Variant = "match_vis_to_haptic" AND ExcludeSubject = 0 AND Condition = 2 AND RespClass = "hit" AND Aligned = 1 AND subject = ' num2str(subjects(i)) '  and Target = ' num2str(obj)] ;
%     wherestring=['Expt = 2 AND Variant = "match_vis_to_haptic" AND SubjectTrial > 163 AND SubjectTrial < 184 AND ExcludeSubject = 0 AND Condition = 2 AND RespClass = "hit" AND Aligned = 1 AND subject = ' num2str(subjects(i))] ;
    u=double(cell2mat(fetch(DataDB, ['Select Flip, StimOn, TargetOn, ResponseTime, PostTouchDelay FROM trialsTable WHERE ' wherestring])));
    ugt=double(cell2mat(fetch(DataDB, ['Select GraspTime FROM trialsTable WHERE ' wherestring])));
    if ~isempty(u)
        u(:,6)=u(:,3)-u(:,2)-u(:,5);
        u(:,7)=u(:,4)-u(:,3);
        aved=mean(u);
        results3=[results3; 1 aved(6) aved(7) mean(ugt)];
    end
    
    
    
    
    
    
    part=[];
    for ii=100+window/2:window:200-window/2
        predictableAligned =         mean(a(a(:,1)>(ii-window/2) & a(:,1)<(ii+window/2) & a(:,2) == 1 & a(:,3)==1,4));
        unpredictableAligned =       mean(a(a(:,1)>(ii-window/2) & a(:,1)<(ii+window/2) & a(:,2) == 1 & a(:,3)==2,4));
        unpredictableUnaligned =     mean(a(a(:,1)>(ii-window/2) & a(:,1)<(ii+window/2) & a(:,2) == 0 & a(:,3)==2,4));
        
        if isempty(predictableAligned);     predictableAligned=nan;     end
        if isempty(unpredictableAligned);   unpredictableAligned=nan;   end
        if isempty(unpredictableUnaligned); unpredictableUnaligned=nan; end
        part=[part; ii predictableAligned unpredictableAligned unpredictableUnaligned];
    end
    
    results2(:,:,i) = part;


end

close(DataDB)


% b=[squeeze(results(1,2:4,:))' squeeze(results(2,2:4,:))' squeeze(results(3,2:4,:))' squeeze(results(4,2:4,:))' squeeze(results(5,2:4,:))'];


figure; subplot(3,1,1); hold on; xlabel('Trial number'); ylabel('Reaction Time'); title('Correct trials only')

   
for i=1:5
    p=squeeze(results(i,2,:));
    p=p(~isnan(p));
    u=squeeze(results(i,3,:));
    u=u(~isnan(u));
    uu=squeeze(results(i,4,:));
    uu=uu(~isnan(uu));
    
    plot(ones(size(p))*(i*window-window/2-1),p,'bo')
    plot(ones(size(u))*(i*window-window/2+1),u,'ko')
    plot(ones(size(uu))*(i*window-window/2+3),uu,'ro')
    
end

subplot(3,1,2); hold on; xlabel('Trial number'); ylabel('Reaction Time')   
for i=1:5
    p=squeeze(results2(i,2,:));
    p=p(~isnan(p));
    u=squeeze(results2(i,3,:));
    u=u(~isnan(u));
    
    plot(ones(size(p))*(i*window-window/2-1),p,'bo')
    plot(ones(size(u))*(i*window-window/2+1),u,'ko')
    
end


predTouch=results3(results3(:,1)==0,2);
predDecide=results3(results3(:,1)==0,3);
unpredTouch=results3(results3(:,1)==1,2);
unpredDecide=results3(results3(:,1)==1,3);
predBoth=results3(results3(:,1)==0,2)+results3(results3(:,1)==0,3);
unpredBoth=results3(results3(:,1)==1,2)+results3(results3(:,1)==1,3);

ptm=mean(predTouch);
pdm=mean(predDecide);
utm=mean(unpredTouch);
udm=mean(unpredDecide);



pts=std(predTouch)/sqrt(length(predTouch));
pds=std(predDecide)/sqrt(length(predDecide));
uts=std(unpredTouch)/sqrt(length(unpredTouch));
uds=std(unpredDecide)/sqrt(length(unpredDecide));
 
subplot(3,2,5); hold on; ylabel('Touch time'); xticks([1 2]); xticklabels({'Predictable', 'Unpredictable'})
bar([ptm utm])
errorbar([ptm utm],[pts uts],'.')

subplot(3,2,6); hold on; ylabel('Decision time'); xticks([1 2]); xticklabels({'Predictable', 'Unpredictable'})
bar([pdm udm])
errorbar([pdm udm],[pds uds],'.')
disp('Touch time diffs')
[h p]=ttest2(predTouch,unpredTouch)
disp('Decision time diffs')
[h p]=ttest2(predDecide,unpredDecide)
disp('Combined time diffs')
[h p]=ttest2(predBoth,unpredBoth)

%% Examine impact of object orientation on subject performance
clear
DataDB = sqlite('C:\Users\Ryan\Documents\Data\graspHuman.db');
ObjectsDB = sqlite('L:\stimuli\grasp\objects.db');

wherestring='Variant = "match_haptic_to_vis" AND ExcludeSubject = 0 AND Aligned = 1 AND Congruent = 1 AND Choice1ID IS NOT NULL';
wherestring='Variant = "match_haptic_to_vis" AND ExcludeSubject = 0 AND Congruent = 0 AND Aligned = 1 and (RespClass = "hit" OR RespClass = "miss") AND Choice1ID IS NOT NULL';
leftAlignedPredResps=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
leftAlignedPredTrials=double(cell2mat(fetch(DataDB, ['Select ReactionTime, SampleID, SampleRotation, Choice1ID, Choice1Rotation FROM trialsTable WHERE ' wherestring])));

wherestring='Variant = "match_haptic_to_vis" AND ExcludeSubject = 0 AND Aligned = 1 AND Congruent = 1 AND Choice2ID IS NOT NULL';
rightAlignedPredResps=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
rightAlignedPredTrials=double(cell2mat(fetch(DataDB, ['Select ReactionTime, SampleID, SampleRotation, Choice2ID, Choice2Rotation FROM trialsTable WHERE ' wherestring])));

results=[];

xcol=4;
ycol=5;
compareCol=6; %6 is percent correct, 7 is reaction time, 8 is pc/rt

for object=1:40
    %Get trials from left using this shape
    theseTrials=leftAlignedPredTrials(leftAlignedPredTrials(:,xcol)==object,:);
    theseResps=leftAlignedPredResps(leftAlignedPredTrials(:,xcol)==object,:);
    
    if isempty(theseTrials) %If there arent any, get trials from right using this shape
        theseTrials=rightAlignedPredTrials(rightAlignedPredTrials(:,xcol)==object,:);
        theseResps=rightAlignedPredResps(rightAlignedPredTrials(:,xcol)==object,:);
        if isempty(theseTrials) %If there still aren't any, skip
            continue;
        else
            side = 1;
        end
    else 
        side = 0;
    end
    
    %get shape info
    shape=fetch(ObjectsDB, ['SELECT * FROM shapeTable' num2str(object)]);
    shape=[cell2mat(shape(:,1:2)) double(cell2mat(shape(:,3)))];
    
    %step through rotations
    for angle=0:90:270
        %rotate shape and find center of curvature*mass
        [xs, ys]=rotatePoints(shape(:,1),shape(:,2),-deg2rad(angle),0,0);
        meanMat=[];
        for iii=1:12
            rxs=xs(shape(:,3)==iii);
            rys=ys(shape(:,3)==iii);
            meanMat=[meanMat; mean(rxs) mean(rys)];
        end
        curvCenterx=mean(meanMat(:,1));
        curvCentery=mean(meanMat(:,2));
        
        %get performance for this object/rotation
        resps=theseResps(theseTrials(:,xcol)==object & theseTrials(:,ycol)==angle,:);
        hitp = calcRespClassCorrectRate(resps);
        rt=mean(theseTrials(theseTrials(:,xcol)==object & theseTrials(:,ycol)==angle,1));
        
        results=[results; side object angle curvCenterx curvCentery hitp rt];

    end
end

close(DataDB)
close(ObjectsDB)

results(:,8)=results(:,6)./results(:,7);

%Flip left values as if they were on the right
% results(results(:,1)==0,4)=results(results(:,1)==0,4).*-1;
% results(results(:,1)==0,1)=1;

threshold=20; %percentile for top and bottom

upper=prctile(results(:,compareCol),100-threshold);
lower=prctile(results(:,compareCol),20);

badL=results(results(:,1)==0 & results(:,compareCol)<=lower, 4:5);
badR=results(results(:,1)==1 & results(:,compareCol)<=lower, 4:5);
goodL=results(results(:,1)==0 & results(:,compareCol)>=upper, 4:5);
goodR=results(results(:,1)==1 & results(:,compareCol)>=upper, 4:5);

figure; 
subplot(1,2,1); hold on; axis square; %axis([-0.003 0.003 -0.003 0.003]);
plot(mean(badL(:,1)),mean(badL(:,2)),'ro')
plot(mean(goodL(:,1)),mean(goodL(:,2)),'go')
plot(badL(:,1),badL(:,2),'r.')
plot(goodL(:,1),goodL(:,2),'g.')
plot(0,0,'k.')

subplot(1,2,2); hold on; axis square; %axis([-0.003 0.003 -0.003 0.003])
plot(mean(badR(:,1)),mean(badR(:,2)),'ro')
plot(mean(goodR(:,1)),mean(goodR(:,2)),'go')
plot(badR(:,1),badR(:,2),'r.')
plot(goodR(:,1),goodR(:,2),'g.')
plot(0,0,'k.')

distL = sqrt((mean(badL(:,1))-mean(goodL(:,1)))^2+(mean(badL(:,2))-mean(goodL(:,2)))^2);
distR = sqrt((mean(badR(:,1))-mean(goodR(:,1)))^2+(mean(badR(:,2))-mean(goodR(:,2)))^2);

distmatL=[];
lefts=results(results(:,1)==0, 4:5);
for i=1:10000
    order=randperm(size(lefts,1));
    newbads=lefts(order(1:floor(length(order)*threshold/100)),:);
    newgoods=lefts(order(ceil(length(order)*threshold/100)+1:floor(length(order)*threshold/200)),:);
    
    distnew = sqrt((mean(newbads(:,1))-mean(newgoods(:,1)))^2+(mean(newbads(:,2))-mean(newgoods(:,2)))^2);
    distmatL=[distmatL; distnew];
end

distmatR=[];
rights=results(results(:,1)==1, 4:5);
for i=1:10000
    order=randperm(size(rights,1));
    newbads=rights(order(1:floor(length(order)*threshold/100)),:);
    newgoods=rights(order(ceil(length(order)*threshold/100)+1:floor(length(order)*threshold/200)),:);
    
    distnew = sqrt((mean(newbads(:,1))-mean(newgoods(:,1)))^2+(mean(newbads(:,2))-mean(newgoods(:,2)))^2);
    distmatR=[distmatR; distnew];
end

boths=[[lefts(:,1)*-1 lefts(:,2)]; rights];




figure; 
subplot(1,3,1); hold on; 
hist(distmatL,100)
plot(distL,100,'*r')

subplot(1,3,2); hold on; 
hist(distmatR,100)
plot(distR,100,'*r')

% subplot(1,3,3); hold on; 
% hist(distmatB,100)
% plot(distR,200,'*r')

shapes=unique(results(:,2));
figure; 
for i=1:length(shapes)
   this=results(results(:,2)==shapes(i),:);
   
   if ~this(1,1)
       subplot(1,2,1); hold on;
   else
       subplot(1,2,2); hold on;
   end
   
   if length(unique(this(:,7))) > 1
   
   low=this(this(:,7)==min(this(:,7)),4:5);
   high=this(this(:,7)==max(this(:,7)),4:5);
   
   plot(low(1),low(2),'.r')
   plot(high(1),high(2),'.g')
   
   plot(0,0,'.k')
   end
   
   
       
    
    
end


%% See when each pad is touched. Are pads in complex areas touched at end more? Answer: no. Pads on bottom are touched at end more.

clear
DataDB = sqlite('C:\Users\Ryan\Documents\Data\graspHuman.db');
ObjectsDB = sqlite('L:\stimuli\grasp\objects.db');

thresh=.5; %.5 is 50% of max for each pad

%Right
figure; 
for angle=0:90:270
    wherestring=['Variant = "match_haptic_to_vis"  AND ExcludeSubject = 0 AND Congruent = 1 AND Aligned = 1 AND RespClass = "hit" AND Touchmode = "right" AND Choice2Rotation = ' num2str(angle) ' AND ExcludeTrialGrasp = 0'];
    trials=double(cell2mat(fetch(DataDB, ['Select UniqueTrial, Choice2ID FROM trialsTable WHERE ' wherestring])));
    
    for i=1:size(trials,1)
        t=trials(i,1); %this trial number
        ts=double(cell2mat(fetch(DataDB,['Select Time_2,pctPad2_1,pctPad2_2,pctPad2_3,pctPad2_4,pctPad2_5,pctPad2_6,pctPad2_7,pctPad2_8,pctPad2_9,pctPad2_10,pctPad2_11,pctPad2_12 FROM graspTable' num2str(t) ' WHERE TrialPeriod = 1'])));
        
%         ts(2:end,2:end)=abs(diff(ts(:,2:end))); %replace TOUCH values with CHANGE IN TOUCH values
        
        ts(:,2:end)=cumsum(ts(:,2:end)); %have each column be a cumulative sum of touch values to that point
        for ii=1:12
            med=ts(end,1+ii) * thresh;
            if med > 25
                time=ts(find(ts(:,1+ii)>med,1),1);
                trials(i,2+ii)=time;
                %             trials(i,2+ii+12)=ts(end,1+ii);
            else
                trials(i,2+ii)=nan;
                %             trials(i,2+ii+12)=nan;
            end
        end
    end
    
    
    ids=unique(trials(:,2));
    for i=1:size(ids,1) %each shape
        
        subplot(3,3,i); hold on; axis equal
        these=trials(trials(:,2)==ids(i),:); %trials where this object id was touched
        
        
        if anova1(these(:,3:end),[],'off') < 0.05
            times=nanmean(these(:,3:end));
            times=times-min(times);
            times=times./max(times);
            times=times.*.9;
            shape=fetch(ObjectsDB, ['SELECT * FROM shapeTable' num2str(ids(i))]);
            shape=[cell2mat(shape(:,1:2)) double(cell2mat(shape(:,3)))];
            [xs, ys]=rotatePoints(shape(:,1),shape(:,2),-deg2rad(angle),0,0);
            for ii=1:12 %each pad
                plot(xs(shape(:,3)==ii),ys(shape(:,3)==ii),'Color',[times(ii) times(ii) times(ii)],'LineWidth',10)
                
            end
%             plot(nanmean(these(:,3:end)))
        else
%             plot(nanmean(these(:,3:end)),':')
        end
        
    end
    
end

%Left
figure; 
for angle=0:90:270
    wherestring=['Variant = "match_haptic_to_vis"  AND ExcludeSubject = 0 AND Congruent = 1 AND Aligned = 1 AND RespClass = "hit" AND Touchmode = "left" AND Choice1Rotation = ' num2str(angle) ' AND ExcludeTrialGrasp = 0'];
    trials=double(cell2mat(fetch(DataDB, ['Select UniqueTrial, Choice1ID FROM trialsTable WHERE ' wherestring])));
    
    for i=1:size(trials,1)
        t=trials(i,1); %this trial number
        ts=double(cell2mat(fetch(DataDB,['Select Time_1,pctPad1_1,pctPad1_2,pctPad1_3,pctPad1_4,pctPad1_5,pctPad1_6,pctPad1_7,pctPad1_8,pctPad1_9,pctPad1_10,pctPad1_11,pctPad1_12 FROM graspTable' num2str(t) ' WHERE TrialPeriod = 1'])));
        ts(:,2:end)=cumsum(ts(:,2:end)); %have each column be a cumulative sum of touch values to that point
        for ii=1:12
            med=ts(end,1+ii) * thresh;
            if med > 25
                time=ts(find(ts(:,1+ii)>med,1),1);
                trials(i,2+ii)=time;
                %             trials(i,2+ii+12)=ts(end,1+ii);
            else
                trials(i,2+ii)=nan;
                %             trials(i,2+ii+12)=nan;
            end
        end
    end
    
    
    ids=unique(trials(:,2));
    for i=1:size(ids,1) %each shape
        
        subplot(3,3,i); hold on; axis equal
        these=trials(trials(:,2)==ids(i),:); %trials where this object id was touched
        
        
        if anova1(these(:,3:end),[],'off') < 0.05
            times=nanmean(these(:,3:end));
            times=times-min(times);
            times=times./max(times);
            times=times.*.9;
            shape=fetch(ObjectsDB, ['SELECT * FROM shapeTable' num2str(ids(i))]);
            shape=[cell2mat(shape(:,1:2)) double(cell2mat(shape(:,3)))];
            [xs, ys]=rotatePoints(shape(:,1),shape(:,2),-deg2rad(angle),0,0);
            for ii=1:12 %each pad
                plot(xs(shape(:,3)==ii),ys(shape(:,3)==ii),'Color',[times(ii) times(ii) times(ii)],'LineWidth',10)
                
            end
%             plot(nanmean(these(:,3:end)))
        else
%             plot(nanmean(these(:,3:end)),':')
        end
        
    end
    
end

close(DataDB)


%% See which pads are most touched, OR MOST EXPLORED if ts(2:end,2:end)=abs(diff(ts(:,2:end))) is uncommented

clear
DataDB = sqlite('C:\Users\Ryan\Documents\Data\graspHuman.db');
ObjectsDB = sqlite('L:\stimuli\grasp\objects.db');

thresh=.5; %.5 is 50% of max for each pad

%Right
figure; 
for angle=0%:90:270
    wherestring=['Variant = "match_haptic_to_vis"  AND ExcludeSubject = 0 AND Congruent = 1 AND Aligned = 1 AND RespClass = "hit" AND Touchmode = "right" AND ExcludeTrialGrasp = 0'];
%     wherestring=['Variant = "match_haptic_to_vis"  AND ExcludeSubject = 0 AND Congruent = 1 AND Aligned = 1 AND RespClass = "hit" AND Touchmode = "right" AND Choice2Rotation = ' num2str(angle) ' AND ExcludeTrialGrasp = 0'];
    trials=double(cell2mat(fetch(DataDB, ['Select UniqueTrial, Choice2ID FROM trialsTable WHERE ' wherestring])));
    
    for i=1:size(trials,1)
        t=trials(i,1); %this trial number
        ts=double(cell2mat(fetch(DataDB,['Select Time_2,pctPad2_1,pctPad2_2,pctPad2_3,pctPad2_4,pctPad2_5,pctPad2_6,pctPad2_7,pctPad2_8,pctPad2_9,pctPad2_10,pctPad2_11,pctPad2_12 FROM graspTable' num2str(t) ' WHERE TrialPeriod = 1'])));
        
        ts(2:end,2:end)=abs(diff(ts(:,2:end))); %replace TOUCH values with CHANGE IN TOUCH values
        
        
        ts(:,2:end)=cumsum(ts(:,2:end)); %have each column be a cumulative sum of touch values to that point
        
        trials(i,3:14)=ts(end,2:end);
%         for ii=1:12
%             med=ts(end,1+ii) * thresh;
%             if med > 25
%                 time=ts(find(ts(:,1+ii)>med,1),1);
%                 trials(i,2+ii)=time;
%                 %             trials(i,2+ii+12)=ts(end,1+ii);
%             else
%                 trials(i,2+ii)=nan;
%                 %             trials(i,2+ii+12)=nan;
%             end
%         end
    end
    
    
    ids=unique(trials(:,2));
    for i=1:size(ids,1) %each shape
        
        subplot(3,3,i); hold on; axis equal; axis off
        these=trials(trials(:,2)==ids(i),:); %trials where this object id was touched
        
        
        if anova1(these(:,3:end),[],'off') < 0.05
            times=nanmean(these(:,3:end));
            times=times-min(times);
            times=times./max(times);
            times=times.*.9;
            shape=fetch(ObjectsDB, ['SELECT * FROM shapeTable' num2str(ids(i))]);
            shape=[cell2mat(shape(:,1:2)) double(cell2mat(shape(:,3)))];
            [xs, ys]=rotatePoints(shape(:,1),shape(:,2),-deg2rad(angle),0,0);
            for ii=1:12 %each pad
                plot(xs(shape(:,3)==ii),ys(shape(:,3)==ii),'Color',[times(ii) times(ii) times(ii)],'LineWidth',10)
                
            end
%             plot(nanmean(these(:,3:end)))
        else
%             plot(nanmean(these(:,3:end)),':')
        end
        
    end
    
end

%Left
figure; 
for angle=0%:90:270
    wherestring=['Variant = "match_haptic_to_vis"  AND ExcludeSubject = 0 AND Congruent = 1 AND Aligned = 1 AND RespClass = "hit" AND Touchmode = "left" AND ExcludeTrialGrasp = 0'];
    trials=double(cell2mat(fetch(DataDB, ['Select UniqueTrial, Choice1ID FROM trialsTable WHERE ' wherestring])));
    
    for i=1:size(trials,1)
        t=trials(i,1); %this trial number
        ts=double(cell2mat(fetch(DataDB,['Select Time_1,pctPad1_1,pctPad1_2,pctPad1_3,pctPad1_4,pctPad1_5,pctPad1_6,pctPad1_7,pctPad1_8,pctPad1_9,pctPad1_10,pctPad1_11,pctPad1_12 FROM graspTable' num2str(t) ' WHERE TrialPeriod = 1'])));
        
        ts(2:end,2:end)=abs(diff(ts(:,2:end))); %replace TOUCH values with CHANGE IN TOUCH values
        ts(:,2:end)=cumsum(ts(:,2:end)); %have each column be a cumulative sum of touch values to that point
        
        
        
        trials(i,3:14)=ts(end,2:end);
%         for ii=1:12
%             med=ts(end,1+ii) * thresh;
%             if med > 25
%                 time=ts(find(ts(:,1+ii)>med,1),1);
%                 trials(i,2+ii)=time;
%                 %             trials(i,2+ii+12)=ts(end,1+ii);
%             else
%                 trials(i,2+ii)=nan;
%                 %             trials(i,2+ii+12)=nan;
%             end
%         end
    end
    
    
    ids=unique(trials(:,2));
    for i=1:size(ids,1) %each shape
        
        subplot(3,3,i); hold on; axis equal
        these=trials(trials(:,2)==ids(i),:); %trials where this object id was touched
        
        
        if anova1(these(:,3:end),[],'off') < 0.05
            times=nanmean(these(:,3:end));
            times=times-min(times);
            times=times./max(times);
            times=times.*.9;
            shape=fetch(ObjectsDB, ['SELECT * FROM shapeTable' num2str(ids(i))]);
            shape=[cell2mat(shape(:,1:2)) double(cell2mat(shape(:,3)))];
            [xs, ys]=rotatePoints(shape(:,1),shape(:,2),-deg2rad(angle),0,0);
            for ii=1:12 %each pad
                plot(xs(shape(:,3)==ii),ys(shape(:,3)==ii),'Color',[times(ii) times(ii) times(ii)],'LineWidth',10)
                
            end
%             plot(nanmean(these(:,3:end)))
        else
%             plot(nanmean(these(:,3:end)),':')
        end
        
    end
    
end

close(DataDB)



%% Make video of which pads are touched at what time

clear
DataDB = sqlite('C:\Users\Ryan\Documents\Data\graspHuman.db');
ObjectsDB = sqlite('L:\stimuli\grasp\objects.db');

steps=20;
% thresh=.5; %.5 is 50% of max for each pad

%Right

for angle=0%:90:270
    wherestring=['Variant = "match_haptic_to_vis"  AND ExcludeSubject = 0 AND Congruent = 1 AND Aligned = 1 AND RespClass = "hit" AND Choice2Rotation = ' num2str(angle) ' AND Touchmode = "right" AND ExcludeTrialGrasp = 0'];
    trials=double(cell2mat(fetch(DataDB, ['Select UniqueTrial, Choice2ID FROM trialsTable WHERE ' wherestring])));
    space=12*steps;
    trials(:,3:2+space)=nan;
    
    for i=1:size(trials,1)
        t=trials(i,1); %this trial number
        ts=double(cell2mat(fetch(DataDB,['Select pctPad2_1,pctPad2_2,pctPad2_3,pctPad2_4,pctPad2_5,pctPad2_6,pctPad2_7,pctPad2_8,pctPad2_9,pctPad2_10,pctPad2_11,pctPad2_12 FROM graspTable' num2str(t) ' WHERE TrialPeriod = 1'])));

        %grab times when the object is being touched
        [y, ~]=find(ts>15);
        first=min(y);
        last=max(y);
        ts=ts(first:last,:);
        
        %Make sure we have at least 10 rows 
        rows=size(ts,1);
        if rows < steps
            continue;
        end
        
        %grab average pad touch value for a given time window and add to array
        step=rows/steps;
        result=[];
        for ii=0:step:rows-1
           this=ts(floor(ii)+1:floor(ii+step),:);
           result=[result mean(this,1)];
        end
        
        %put that result into trials matrix
        trials(i,3:end)=result;
    end
    
    
    ids=unique(trials(:,2));
    for i=1:size(ids,1) %each shape
        id=ids(i);
        these=trials(trials(:,2)==id,3:end); %Grab results for all trials for this shape
        this=vec2mat(nanmean(these,1),12); %take the average and reshape into matrix
        this(this<0)=0;
        peak=max(max(this));
        
        shape=fetch(ObjectsDB, ['SELECT * FROM shapeTable' num2str(ids(i))]);
        shape=[cell2mat(shape(:,1:2)) double(cell2mat(shape(:,3)))];
        [xs, ys]=rotatePoints(shape(:,1),shape(:,2),-deg2rad(angle),0,0);
        
        v = VideoWriter('peaks7.mp4','MPEG-4');
        v.Quality = 100;
        v.FrameRate = 10;
        open(v);
       
        figure; hold on; axis equal
        writeVideo(v,getframe(gca)); %Write frame to video
        writeVideo(v,getframe(gca)); %Write frame to video
        writeVideo(v,getframe(gca)); %Write frame to video
        for ii=1:size(this,1)
            cla
            for iii=1:12
                plot(xs(shape(:,3)==iii),ys(shape(:,3)==iii),'Color',[this(ii,iii)/peak this(ii,iii)/peak this(ii,iii)/peak],'LineWidth',10)
                
            end
            drawnow
            writeVideo(v,getframe(gca)); %Write frame to video
        end
        close(v)
        

    end
    
end

close(DataDB)


%% Analyze which pads are being EXPLORED at a given time, not just touched

clear
DataDB = sqlite('C:\Users\Ryan\Documents\Data\graspHuman.db');
ObjectsDB = sqlite('L:\stimuli\grasp\objects.db');

steps=20;
% thresh=.5; %.5 is 50% of max for each pad

%Right

for angle=90%:90:270
    wherestring=['Variant = "match_haptic_to_vis"  AND ExcludeSubject = 0 AND Congruent = 1 AND Aligned = 1 AND RespClass = "hit" AND Choice2Rotation = ' num2str(angle) ' AND Touchmode = "right" AND ExcludeTrialGrasp = 0'];
    trials=double(cell2mat(fetch(DataDB, ['Select UniqueTrial, Choice2ID FROM trialsTable WHERE ' wherestring])));
    space=12*steps;
    trials(:,3:2+space)=nan;
    
    for i=1:size(trials,1)
        t=trials(i,1); %this trial number
        ts=double(cell2mat(fetch(DataDB,['Select pctPad2_1,pctPad2_2,pctPad2_3,pctPad2_4,pctPad2_5,pctPad2_6,pctPad2_7,pctPad2_8,pctPad2_9,pctPad2_10,pctPad2_11,pctPad2_12 FROM graspTable' num2str(t) ' WHERE TrialPeriod = 1'])));

        %grab times when the object is being touched
        [y, ~]=find(ts>15);
        first=min(y);
        last=max(y);
        ts=diff(ts);
        ts=ts(first:last-1,:);
        
        %Make sure we have at least 10 rows 
        rows=size(ts,1);
        if rows < steps
            continue;
        end
        
        
        
        %grab average pad touch value for a given time window and add to array
        step=rows/steps;
        result=[];
        for ii=0:step:rows-1
           this=ts(floor(ii)+1:floor(ii+step),:);
           result=[result mean(this,1)];
        end
        
        %put that result into trials matrix
        trials(i,3:end)=result;
    end
    
    
    ids=unique(trials(:,2));
    for i=1:size(ids,1) %each shape
        id=ids(i);
        these=trials(trials(:,2)==id,3:end); %Grab results for all trials for this shape
        this=vec2mat(nanmean(these,1),12); %take the average and reshape into matrix
        this=abs(this);
        this=this(1:end-1,:);
        
        biggest=max(max(abs(this)));
        this=this./(biggest);
        
                
        shape=fetch(ObjectsDB, ['SELECT * FROM shapeTable' num2str(ids(i))]);
        shape=[cell2mat(shape(:,1:2)) double(cell2mat(shape(:,3)))];
        [xs, ys]=rotatePoints(shape(:,1),shape(:,2),-deg2rad(angle),0,0);
        
        v = VideoWriter('peaks7.mp4','MPEG-4');
        v.Quality = 100;
        v.FrameRate = 10;
        open(v);
       
        figure; hold on; axis equal
%         writeVideo(v,getframe(gca)); %Write frame to video
%         writeVideo(v,getframe(gca)); %Write frame to video
%         writeVideo(v,getframe(gca)); %Write frame to video
        for ii=1:size(this,1)
            cla
            for iii=1:12
                plot(xs(shape(:,3)==iii),ys(shape(:,3)==iii),'Color',[this(ii,iii) this(ii,iii) this(ii,iii)],'LineWidth',10)
                
            end
            pause(0.2)
            drawnow
%             writeVideo(v,getframe(gca)); %Write frame to video
        end
        close(v)

    end
    
end

close(DataDB)


%% Compare reaction time of different trial outcomes (hit, miss, etc)

clear
DataDB = sqlite('C:\Users\Ryan\Documents\Data\graspHuman.db');

wherestring='Expt = 2 AND  Variant = "match_haptic_to_vis"  AND ExcludeSubject = 0 AND Congruent = 0 AND RespClass = "hit"';
valsCH=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));

wherestring='Expt = 2 AND Variant = "match_haptic_to_vis"  AND ExcludeSubject = 0 AND Congruent = 0 AND RespClass = "miss"';
valsCM=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));

wherestring='Expt = 2 AND Variant = "match_haptic_to_vis"  AND ExcludeSubject = 0 AND Congruent = 0 AND RespClass = "fa"';
valsCF=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));

wherestring='Expt = 2 AND Variant = "match_haptic_to_vis"  AND ExcludeSubject = 0 AND Congruent = 0 AND RespClass = "cr"';
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


%% Compare reaction time of different trial outcomes (hit, miss, etc) for a given subject

clear
DataDB = sqlite('C:\Users\Ryan\Documents\Data\graspHuman.db');
subjects=unique(cellfun(@str2num,fetch(DataDB, ['Select Subject FROM trialsTable WHERE ExcludeSubject = 0 AND Expt = 2'])));

results=[];
for i=1:size(subjects,1)
    s = num2str(subjects(i));
    wherestring=['Subject = ' s ' AND Expt = 2 AND  Variant = "match_haptic_to_vis"  AND Congruent = 0 AND RespClass = "hit"'];
    valsCH=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
    
    wherestring=['Subject = ' s ' AND Expt = 2 AND  Variant = "match_haptic_to_vis"  AND Congruent = 0 AND RespClass = "miss"'];
    valsCM=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
    
    wherestring=['Subject = ' s ' AND Expt = 2 AND  Variant = "match_haptic_to_vis"  AND Congruent = 0 AND RespClass = "cr"'];
    valsCC=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
    
    wherestring=['Subject = ' s ' AND Expt = 2 AND  Variant = "match_haptic_to_vis"  AND Congruent = 0 AND RespClass = "fa"'];
    valsCF=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
    
    if ~isnan(valsCH)
        results=[results; str2double(s) mean(valsCH) mean(valsCM) mean(valsCC) mean(valsCF)];
    end
end

close(DataDB)

for i=1:size(results,1)
    results2(i,:)=[results(i,1) 0 results(i,3)-results(i,2) results(i,4)-results(i,2) results(i,5)-results(i,2)];
end


figure; 
subplot(2,1,1); hold on; xticks([1 2 3 4]); xticklabels({'Hit','Miss','CR','FA'}); title('Unpredictable'); ylabel('Reaction time')
bar(mean(results(:,2:5)))
errorbar(mean(results(:,2:5)),std(results(:,2:5)),'.')

subplot(2,1,2); hold on; xticks([1 2 3 4]); xticklabels({'Hit','Miss','CR','FA'}); title('Unpredictable, normalized by subject'); ylabel('Reaction time')
bar(mean(results2(:,2:5)))
errorbar(mean(results2(:,2:5)),std(results2(:,2:5)),'.')





%% Compare reaction time of different trial outcomes (hit, miss, etc) for a given object

clear
DataDB = sqlite('C:\Users\Ryan\Documents\Data\graspHuman.db');

targets=double(cell2mat(fetch(DataDB, 'Select Target FROM trialsTable')));
targets=unique(targets);

results=[];
for i=1:size(targets,1)
    thisTarg=num2str(targets(i));
    
    wherestring=['Expt = 2 AND Variant = "match_haptic_to_vis" AND Variant = "match_haptic_to_vis"  AND ExcludeSubject = 0 AND Congruent = 1 AND RespClass = "hit" AND Target = ' thisTarg];
    valsHC=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
    
    wherestring=['Expt = 2 AND Variant = "match_haptic_to_vis" AND Variant = "match_haptic_to_vis"  AND ExcludeSubject = 0 AND Congruent = 1 AND RespClass = "miss" AND Target = ' thisTarg];
    valsMC=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
    
    wherestring=['Expt = 2 AND Variant = "match_haptic_to_vis" AND Variant = "match_haptic_to_vis"  AND ExcludeSubject = 0 AND Congruent = 0 AND RespClass = "hit" AND Target = ' thisTarg];
    valsHI=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
    
    wherestring=['Expt = 2 AND Variant = "match_haptic_to_vis" AND Variant = "match_haptic_to_vis"  AND ExcludeSubject = 0 AND Congruent = 0 AND RespClass = "miss" AND Target = ' thisTarg];
    valsMI=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));

    results=[results; str2double(thisTarg) mean(valsMC)-mean(valsHC) mean(valsMI)-mean(valsHI)];
end
close(DataDB)
figure; hold on; xlim([0.6 2.4]); xticks([1 2]); xticklabels({'Hit','Miss'}); ylabel('Reaction time (ms)'); title('Shape-based difference in reaction times');
errorbar([0 nanmean(results(:,2))],[0 nanstd(results(:,2))/sqrt(size(results,1))],'b')
errorbar([0 nanmean(results(:,3))],[0 nanstd(results(:,3))/sqrt(size(results,1))],'k')
legend({'Predictable','Unpredictable'})

[h p]=ttest(results(:,2))
%% See if performance peak is reached in 4 blocks

% clear 
% DataDB = sqlite('C:\Users\Ryan\Documents\Data\graspHuman.db');
% 
% wherestring='Expt = 2 AND Variant = "match_haptic_to_vis" AND Variant = "match_haptic_to_vis"  AND ExcludeSubject = 0 AND SubjectBlock = 4 AND Congruent = 1';
% subjects=unique(cellfun(@str2num,fetch(DataDB, ['Select Subject FROM trialsTable WHERE ' wherestring])));
% subjects=[ones(length(subjects),1) subjects];
% wherestring='Expt = 2 AND Variant = "match_haptic_to_vis" AND Variant = "match_haptic_to_vis"  AND ExcludeSubject = 0 AND SubjectBlock = 4 AND Congruent = 0';
% subjects2=unique(cellfun(@str2num,fetch(DataDB, ['Select Subject FROM trialsTable WHERE ' wherestring])));
% subjects=[subjects; zeros(length(subjects2),1) subjects2];
% 
% for i=1:size(subjects,1)
%     s=num2str(subjects(i,2));
%     firsth=[];
%     firstr=[];
%     for ii=1:4
%         wherestring=['Expt = 2 AND Variant = "match_haptic_to_vis" AND Variant = "match_haptic_to_vis"  AND Subject = ' s ' AND SubjectBlock = ' num2str(ii)];
%         vals=fetch(DataDB, ['Select RespClass, ReactionTime FROM trialsTable WHERE ' wherestring]);
%         hitpC = calcRespClassCorrectRate(vals(:,1));
%         
%         if isempty(firsth)
%             firsth=hitpC;
%             firstr=mean(cell2mat(vals(:,2)));
%         end
%         subjects(i,1+ii*2)=hitpC-firsth;
%         subjects(i,2+ii*2)=mean(cell2mat(vals(:,2)))-firstr;            
%     end
% end
% 
% close(DataDB)
% 
% 
% 
% figure;
% subplot(2,1,1); hold on; xlim([.4 4.4]);  xticks([1 2 3 4]); xlabel('Block'); ylabel('% Correct re: 1st block')
% congs=subjects(subjects(:,1)==1, 3:2:end);
% incs=subjects(subjects(:,1)==0, 3:2:end);
% errorbar(mean(congs),std(congs)./sqrt(size(congs,1)),'b')
% errorbar(mean(incs),std(incs)./sqrt(size(incs,1)),'k')
% legend('Predictable','Unpredictable')
% 
% subplot(2,1,2); hold on; xlim([.4 4.4]);  xticks([1 2 3 4]);  xlabel('Block'); ylabel('RT re: 1st block')
% congs=subjects(subjects(:,1)==1, 4:2:end);
% incs=subjects(subjects(:,1)==0, 4:2:end);
% % plot(mean(congs),'b')
% % plot(mean(incs),'k')
% 
% errorbar(mean(congs),std(congs)./sqrt(size(congs,1)),'b')
% errorbar(mean(incs),std(incs)./sqrt(size(incs,1)),'k')
% legend('Predictable','Unpredictable')
% 
% 
% 


%% Compare people based on instrument playing

clear 
DataDB = sqlite('C:\Users\Ryan\Documents\Data\graspHuman.db');

% wherestring='Expt = 2 AND Variant = "match_haptic_to_vis"  AND ExcludeSubject = 0 AND Instrument = 1 AND Congruent = 1';
% vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
% 
% hitpC1 = calcRespClassCorrectRate(vals);
% a=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
% rtsC1=mean(a);
% rtsC1sem=std(a)/sqrt(length(a));

hitpC1=.9;
rtsC1=1000;
rtsC1sem=2000;

wherestring='Expt = 2 AND Variant = "match_haptic_to_vis"  AND ExcludeSubject = 0 AND Instrument = 2 AND Congruent = 1';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitpC2 = calcRespClassCorrectRate(vals);
a=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
rtsC2=mean(a);
rtsC2sem=std(a)/sqrt(length(a));

wherestring='Expt = 2 AND Variant = "match_haptic_to_vis"  AND ExcludeSubject = 0 AND Instrument = 3 AND Congruent = 1';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitpC3 = calcRespClassCorrectRate(vals);
a=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
rtsC3=mean(a);
rtsC3sem=std(a)/sqrt(length(a));



wherestring='Expt = 2 AND Variant = "match_haptic_to_vis"  AND ExcludeSubject = 0 AND Instrument = 1 AND Congruent = 0';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitpI1 = calcRespClassCorrectRate(vals);
a=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
rtsI1=mean(a);
rtsI1sem=std(a)/sqrt(length(a));

wherestring='Expt = 2 AND Variant = "match_haptic_to_vis"  AND ExcludeSubject = 0 AND Instrument = 2 AND Congruent = 0';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitpI2 = calcRespClassCorrectRate(vals);
a=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
rtsI2=mean(a);
rtsI2sem=std(a)/sqrt(length(a));

wherestring='Expt = 2 AND Variant = "match_haptic_to_vis"  AND ExcludeSubject = 0 AND Instrument = 3 AND Congruent = 0';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitpI3 = calcRespClassCorrectRate(vals);
a=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
rtsI3=mean(a);
rtsI3sem=std(a)/sqrt(length(a));



wherestring='Expt = 2 AND Variant = "match_haptic_to_vis" AND ExcludeSubject = 0 AND Instrument = 1';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitp1 = calcRespClassCorrectRate(vals);
a=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
rts1=mean(a);
rts1sem=std(a)/sqrt(length(a));

wherestring='Expt = 2 AND Variant = "match_haptic_to_vis" AND ExcludeSubject = 0 AND Instrument = 2';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitp2 = calcRespClassCorrectRate(vals);
a=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
rts2=mean(a);
rts2sem=std(a)/sqrt(length(a));

wherestring='Expt = 2 AND Variant = "match_haptic_to_vis"  AND ExcludeSubject = 0 AND Instrument = 3';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitp3 = calcRespClassCorrectRate(vals);
a=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
rts3=mean(a);
rts3sem=std(a)/sqrt(length(a));

close(DataDB)




figure;
subplot(2,2,1); hold on; xlim([0.5 3.5]); xticks([1,2,3]); xticklabels({'Play currently','Played in past','Hasnt played'}); ylabel('% Correct'); %ylim([.90 1])
plot([hitpC1 hitpC2 hitpC3],'b')
plot([hitpI1 hitpI2 hitpI3],'k')
legend('Predictable','Unpredictable')

subplot(2,2,3); hold on; xlim([0.5 3.5]); xticks([1,2,3]); xticklabels({'Play currently','Played in past','Hasnt played'}); ylabel('Reaction time (ms)'); %ylim([2200 3600])
errorbar([rtsC1 rtsC2 rtsC3],[rtsC1sem rtsC2sem rtsC3sem],'b')
errorbar([rtsI1 rtsI2 rtsI3],[rtsI1sem rtsI2sem rtsI3sem],'k')
legend('Predictable','Unpredictable')


subplot(2,2,2); hold on; xlim([0.5 3.5]); xticks([1,2,3]); xticklabels({'Play currently','Played in past','Hasnt played'}); ylabel('% Correct'); %ylim([.90 1])
bar([hitp1 hitp2 hitp3],'FaceColor','w')

subplot(2,2,4); hold on; xlim([0.5 3.5]); xticks([1,2,3]); xticklabels({'Play currently','Played in past','Hasnt played'}); ylabel('Reaction time (ms)'); %ylim([2200 3600])
bar([rts1 rts2 rts3],'FaceColor','w')
errorbar([rts1 rts2 rts3],[rts1sem rts2sem rts3sem],'k.')

%% Compare sexes, correct trials

clear
DataDB = sqlite('C:\Users\Ryan\Documents\Data\graspHuman.db');
wherestring='ExcludeSubject = 0'; %0 is female
subjects=unique(cellfun(@str2num,fetch(DataDB, ['Select Subject FROM trialsTable WHERE ' wherestring])));

results=[];

for i=1:size(subjects,1)
    % first 100 trials from match_haptic_to_vis where the shapes are matched
    wherestring=['Variant = "match_haptic_to_vis"  AND SubjectTrial < 101 AND Subject = ' num2str(subjects(i)) ' AND (RespClass = "hit" OR RespClass = "cr")'];
    a=double(cell2mat(fetch(DataDB, ['Select Congruent, Sex, ReactionTime FROM trialsTable WHERE ' wherestring])));
    wherestring=['Variant = "match_haptic_to_vis"  AND SubjectTrial < 101 AND Subject = ' num2str(subjects(i))];
    resps=calcRespClassCorrectRate(fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]));
    
    
    results = [results; a(1,2) a(1,1) round(mean(a(:,3))) resps];
end

close(DataDB)

wp=results(results(:,1)==0 & results(:,2)==1,3);
wu=results(results(:,1)==0 & results(:,2)==0,3);
mp=results(results(:,1)==1 & results(:,2)==1,3);
mu=results(results(:,1)==1 & results(:,2)==0,3);

wpm=mean(wp);    %women predictable mean RT
wps=std(wp);     %women predictable std RT
wum=mean(wu);    %women unpredictable mean RT
wus=std(wu);     %women unpredictable std RT

mpm=mean(mp);    %men predictable mean RT
mps=std(mp);     %men predictable std RT
mum=mean(mu);    %men unpredictable mean RT
mus=std(mu);     %men unpredictable std RT

wpPC=results(results(:,1)==0 & results(:,2)==1,4);
wuPC=results(results(:,1)==0 & results(:,2)==0,4);
mpPC=results(results(:,1)==1 & results(:,2)==1,4);
muPC=results(results(:,1)==1 & results(:,2)==0,4);

wpmPC=mean(wpPC);    %women predictable mean RT
wpsPC=std(wpPC);     %women predictable std RT
wumPC=mean(wuPC);    %women unpredictable mean RT
wusPC=std(wuPC);     %women unpredictable std RT

mpmPC=mean(mpPC);    %men predictable mean RT
mpsPC=std(mpPC);     %men predictable std RT
mumPC=mean(muPC);    %men unpredictable mean RT
musPC=std(muPC);     %men unpredictable std RT

figure; subplot(1,2,1); hold on; xticks([1 2 3 4]); xticklabels({'F Pred','M Pred','F Unpred','M Unpred'}); ylabel('Reaction time (ms)'); title('Correct trials')
bar([wpm mpm wum mum])
errorbar([wpm mpm wum mum], [wps mps wus mus],'.')
subplot(1,2,2); hold on; xticks([1 2 3 4]); xticklabels({'F Pred','M Pred','F Unpred','M Unpred'}); ylabel('Reaction time (ms)'); title('Correct trials')
bar([wpmPC mpmPC wumPC mumPC])
errorbar([wpmPC mpmPC wumPC mumPC], [wpsPC mpsPC wusPC musPC],'.')



%% Compare people based on age

clear 
DataDB = sqlite('C:\Users\Ryan\Documents\Data\graspHuman.db');

wherestring='Expt = 2 AND Variant = "match_haptic_to_vis"  AND ExcludeSubject = 0 AND Age < 25 AND Congruent = 1';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitpC1 = calcRespClassCorrectRate(vals);
a=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
rtsC1=mean(a);
rtsC1sem=std(a)/sqrt(length(a));

wherestring='Expt = 2 AND Variant = "match_haptic_to_vis"  AND ExcludeSubject = 0 AND Age >=25 AND Age <= 30 AND Congruent = 1';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitpC2 = calcRespClassCorrectRate(vals);
a=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
rtsC2=mean(a);
rtsC2sem=std(a)/sqrt(length(a));

wherestring='Expt = 2 AND Variant = "match_haptic_to_vis"  AND ExcludeSubject = 0 AND Age > 30 AND Congruent = 1';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitpC3 = calcRespClassCorrectRate(vals);
a=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
rtsC3=mean(a);
rtsC3sem=std(a)/sqrt(length(a));



wherestring='Expt = 2 AND Variant = "match_haptic_to_vis"  AND ExcludeSubject = 0 AND Age < 25 AND Congruent = 0';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitpI1 = calcRespClassCorrectRate(vals);
a=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
rtsI1=mean(a);
rtsI1sem=std(a)/sqrt(length(a));

wherestring='Expt = 2 AND Variant = "match_haptic_to_vis"  AND ExcludeSubject = 0 AND Age >=25 AND Age <= 30 AND Congruent = 0';
vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
hitpI2 = calcRespClassCorrectRate(vals);
a=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
rtsI2=mean(a);
rtsI2sem=std(a)/sqrt(length(a));

wherestring='Expt = 2 AND Variant = "match_haptic_to_vis"  AND ExcludeSubject = 0 AND  Age > 30 AND Congruent = 0';
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

vals=double(cell2mat(fetch(DataDB, 'Select UniqueTrial, ReactionTime, GraspTime, Block, Trial FROM trialsTable WHERE Expt = 2 AND Variant = "match_haptic_to_vis"  AND ExcludeTrialGrasp = 0')));
% trials=double(cell2mat(fetch(DataDB, 'Select UniqueTrial FROM trialsTable           WHERE Expt = 2 AND Variant = "match_haptic_to_vis"  AND GraspTime < 200 AND ExcludeTrialGrasp = 0')));

close(DataDB)

figure; hold on; xlabel('Reaction time (ms)'); ylabel('Touch time (ms)')

plot(vals(:,2),vals(:,3),'.')
plot([0 10000],[0 10000])

% hist(vals(:,2),200)

%% See where people tend to look on left vs right blocks

% clear 
% 
% DataDB = sqlite('C:\Users\Ryan\Documents\Data\graspHuman.db');
% 
% %Get subjects
% subjects=unique(cellfun(@str2num,fetch(DataDB, 'Select Subject FROM trialsTable WHERE ExcludeSubject = 0')));
% 
% leftminusright=[];
% both=[];
% figure; subplot(2,1,1); hold on; 
% for s=1:size(subjects,1)
%     subject = num2str(subjects(s));
%     
%     % get trials which were either touch left or touch right
%     rights=double(cell2mat(fetch(DataDB, ['Select UniqueTrial FROM trialsTable WHERE Expt = 2 AND Variant = "match_haptic_to_vis"  AND TouchMode = "right" AND Subject = ' subject])));
%     lefts=double(cell2mat(fetch(DataDB, ['Select UniqueTrial FROM trialsTable WHERE Expt = 2 AND Variant = "match_haptic_to_vis"  AND TouchMode = "left" AND Subject = ' subject])));
%     
%     if isempty(lefts) || isempty(rights)
%         continue;
%     end
%     
%     % get eye pos data for each trial
%     valsmatR=[];
%     for i=1:size(rights,1)
%         thisr=num2str(rights(i));
%         vals=double(cell2mat(fetch(DataDB, ['Select x, y FROM eyeTable' thisr ' WHERE Saccade = 0 AND Blink = 0'])));
%         
%         valsmatR=[valsmatR; vals];
%     end
%     
%     valsmatL=[];
%     for i=1:size(lefts,1)
%         thisl=num2str(lefts(i));
%         vals=double(cell2mat(fetch(DataDB, ['Select x, y FROM eyeTable' thisl ' WHERE Saccade = 0 AND Blink = 0'])));
%         
%         valsmatL=[valsmatL; vals];
%     end
%     
%     plot(mean(valsmatL(:,1)),mean(valsmatL(:,2)),'go')
%     plot(mean(valsmatR(:,1)),mean(valsmatR(:,2)),'ro')
%     
%     plot([mean(valsmatR(:,1)) mean(valsmatL(:,1))],[mean(valsmatR(:,2)) mean(valsmatL(:,2))],'k')
%     
%     both=[both; mean(valsmatL(:,1)) mean(valsmatL(:,2)) mean(valsmatR(:,1)) mean(valsmatR(:,2))];
%    
%     leftminusright=[leftminusright; mean(valsmatL(:,1))-mean(valsmatR(:,1))];
% end
% 
% close(DataDB)
% 
% plot(mean(both(:,3)),mean(both(:,4)),'r.','MarkerSize',25)
% plot(mean(both(:,1)),mean(both(:,2)),'g.','MarkerSize',25)
% xlim([-2 2])
% ylim([-2 2])
% xlabel('Mean subject-wise eye x position')
% ylabel('Mean subject-wise eye y position')
% 
% subplot(2,1,2); hold on; xlabel('Bias in eye x position, negative is towards stim hand')
% hist(leftminusright,[-.9:.2:.9])

%% Correlation between where people look and touch

clear 

DataDB = sqlite('C:\Users\Ryan\Documents\Data\graspHuman.db');

I1=double(cell2mat(fetch(DataDB, ['Select GraspEyeCorr FROM trialsTable WHERE Expt = 2 AND Variant = "match_haptic_to_vis"  AND Congruent = 0 AND ExcludeSubject = 0 AND Aligned = 0 AND (RespClass = "hit" OR RespClass = "miss")'])));
I2=double(cell2mat(fetch(DataDB, ['Select GraspEyeCorr FROM trialsTable WHERE Expt = 2 AND Variant = "match_haptic_to_vis"  AND Congruent = 0 AND ExcludeSubject = 0 AND Aligned = 1 AND  (RespClass = "hit" OR RespClass = "miss")'])));

C1=double(cell2mat(fetch(DataDB, ['Select GraspEyeCorr FROM trialsTable WHERE Expt = 2 AND Variant = "match_haptic_to_vis"  AND Congruent = 1 AND ExcludeSubject = 0 AND (RespClass = "hit" OR RespClass = "miss")'])));


close(DataDB)

figure; hold on;

[y x]=hist(I1,-0.9:.2:.9);
plot(x,y./length(I1),'k')

[y x]=hist(I2,-0.9:.2:.9);
plot(x,y./length(I2),'k:')

[y x]=hist(C1,-0.9:.2:.9);
plot(x,y./length(C1),'b')

legend('Incongruent Misaligned','Incongruent Aligned','Congruent Aligned')
xlabel('Distribution of correlations')
ylabel('Number of trials (normalized)')

%% Correlation between where people look and touch, broken out by instrument experience

clear 

DataDB = sqlite('C:\Users\Ryan\Documents\Data\graspHuman.db');

I1=double(cell2mat(fetch(DataDB, ['Select GraspEyeCorr FROM trialsTable WHERE Expt = 2 AND Variant = "match_haptic_to_vis"  AND Congruent = 0 AND Instrument = 1 AND SubjectBlock > 1 AND ExcludeSubject = 0 AND (RespClass = "hit" OR RespClass = "miss")'])));
I2=double(cell2mat(fetch(DataDB, ['Select GraspEyeCorr FROM trialsTable WHERE Expt = 2 AND Variant = "match_haptic_to_vis"  AND Congruent = 0 AND Instrument = 2 AND SubjectBlock > 1 AND ExcludeSubject = 0 AND (RespClass = "hit" OR RespClass = "miss")'])));
I3=double(cell2mat(fetch(DataDB, ['Select GraspEyeCorr FROM trialsTable WHERE Expt = 2 AND Variant = "match_haptic_to_vis"  AND Congruent = 0 AND Instrument = 3 AND SubjectBlock > 1 AND ExcludeSubject = 0 AND (RespClass = "hit" OR RespClass = "miss")'])));

C1=double(cell2mat(fetch(DataDB, ['Select GraspEyeCorr FROM trialsTable WHERE Expt = 2 AND Variant = "match_haptic_to_vis"  AND Congruent = 1 AND Instrument = 1 AND ExcludeSubject = 0 AND (RespClass = "hit" OR RespClass = "miss")'])));
C2=double(cell2mat(fetch(DataDB, ['Select GraspEyeCorr FROM trialsTable WHERE Expt = 2 AND Variant = "match_haptic_to_vis"  AND Congruent = 1 AND Instrument = 2 AND ExcludeSubject = 0 AND (RespClass = "hit" OR RespClass = "miss")'])));
C3=double(cell2mat(fetch(DataDB, ['Select GraspEyeCorr FROM trialsTable WHERE Expt = 2 AND Variant = "match_haptic_to_vis"  AND Congruent = 1 AND Instrument = 3 AND ExcludeSubject = 0 AND (RespClass = "hit" OR RespClass = "miss")'])));


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
    wherestring=['Expt = 2 AND Variant = "match_haptic_to_vis"  AND ExcludeSubject = 0 AND subject = ' num2str(subjects(i)) ' AND Congruent = 1 AND Choice1ID IS NOT NULL'];
    congTrialsLeft=double(cell2mat(fetch(DataDB, ['Select UniqueTrial FROM trialsTable WHERE ' wherestring])));
    wherestring=['Expt = 2 AND Variant = "match_haptic_to_vis"  AND ExcludeSubject = 0 AND subject = ' num2str(subjects(i)) ' AND Congruent = 1 AND Choice2ID IS NOT NULL'];
    congTrialsRight=double(cell2mat(fetch(DataDB, ['Select UniqueTrial FROM trialsTable WHERE ' wherestring])));
    wherestring=['Expt = 2 AND Variant = "match_haptic_to_vis"  AND ExcludeSubject = 0 AND subject = ' num2str(subjects(i)) ' AND Congruent = 0  AND Choice1ID IS NOT NULL'];
    incongTrialsLeft=double(cell2mat(fetch(DataDB, ['Select UniqueTrial FROM trialsTable WHERE ' wherestring])));
    wherestring=['Expt = 2 AND Variant = "match_haptic_to_vis"  AND ExcludeSubject = 0 AND subject = ' num2str(subjects(i)) ' AND Congruent = 0  AND Choice2ID IS NOT NULL'];
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


%% See if there is a relationship between amount of time a pad is touched and whether the answer is correct or not
clear

threshold=20; %any touch value greater than this is considered a real touch
threshns=10; %must touch pad at least this many times to be considered "touched"

DataDB = sqlite('C:\Users\Ryan\Documents\Data\graspHuman.db');

wherestring='ExcludeSubject = 0';
subjects=unique(cellfun(@str2num,fetch(DataDB, ['Select Subject FROM trialsTable WHERE ' wherestring])));

results=[];
for i=1:size(subjects,1)    
    wherestring=['Expt = 1 AND Variant = "match_haptic_to_vis"  AND ExcludeSubject = 0 AND subject = ' num2str(subjects(i)) ' AND Congruent = 1 AND Choice1ID IS NOT NULL'];
    congTrialsLeft=double(cell2mat(fetch(DataDB, ['Select UniqueTrial FROM trialsTable WHERE ' wherestring])));
    wherestring=['Expt = 2 AND Variant = "match_haptic_to_vis"  AND ExcludeSubject = 0 AND subject = ' num2str(subjects(i)) ' AND Congruent = 1 AND Choice2ID IS NOT NULL'];
    congTrialsRight=double(cell2mat(fetch(DataDB, ['Select UniqueTrial FROM trialsTable WHERE ' wherestring])));
    wherestring=['Expt = 2 AND Variant = "match_haptic_to_vis"  AND ExcludeSubject = 0 AND subject = ' num2str(subjects(i)) ' AND Congruent = 0  AND Choice1ID IS NOT NULL'];
    incongTrialsLeft=double(cell2mat(fetch(DataDB, ['Select UniqueTrial FROM trialsTable WHERE ' wherestring])));
    wherestring=['Expt = 2 AND Variant = "match_haptic_to_vis"  AND ExcludeSubject = 0 AND subject = ' num2str(subjects(i)) ' AND Congruent = 0  AND Choice2ID IS NOT NULL'];
    incongTrialsRight=double(cell2mat(fetch(DataDB, ['Select UniqueTrial FROM trialsTable WHERE ' wherestring])));
    
    for ii=1:size(congTrialsLeft,1)
        ts=double(cell2mat(fetch(DataDB,['SELECT pctPad1_1,pctPad1_2,pctPad1_3,pctPad1_4,pctPad1_5,pctPad1_6,pctPad1_7,pctPad1_8,pctPad1_9,pctPad1_10,pctPad1_11,pctPad1_12 FROM graspTable' num2str(congTrialsLeft(ii)) ' WHERE TrialPeriod = 1'])));
        if size(ts,1) < 10
            continue;
        end
        tsSum=sum(ts);
        resp=fetch(DataDB, ['SELECT RespClass FROM trialsTable WHERE UniqueTrial = ' num2str(congTrialsLeft(ii))]);
        IDs=double(cell2mat(fetch(DataDB,['SELECT SampleID, Choice1ID FROM trialsTable WHERE UniqueTrial = ' num2str(congTrialsLeft(ii))])));
        if strcmp(cell2mat(resp),'hit')
            results=[results; 1 1 IDs tsSum];
        elseif strcmp(cell2mat(resp),'miss')
            results=[results; 1 2 IDs tsSum];
        end
    end
     for ii=1:size(congTrialsRight,1)
         ts=double(cell2mat(fetch(DataDB,['Select pctPad2_1,pctPad2_2,pctPad2_3,pctPad2_4,pctPad2_5,pctPad2_6,pctPad2_7,pctPad2_8,pctPad2_9,pctPad2_10,pctPad2_11,pctPad2_12 FROM graspTable' num2str(congTrialsRight(ii)) ' WHERE TrialPeriod = 1'])));
         if size(ts,1) < 10
            continue;
        end
        tsSum=sum(ts);
        resp=fetch(DataDB, ['SELECT RespClass FROM trialsTable WHERE UniqueTrial = ' num2str(congTrialsRight(ii))]);
        IDs=double(cell2mat(fetch(DataDB,['SELECT SampleID, Choice2ID FROM trialsTable WHERE UniqueTrial = ' num2str(congTrialsRight(ii))])));
        if strcmp(cell2mat(resp),'hit')
            results=[results; 2 1 IDs tsSum];
        elseif strcmp(cell2mat(resp),'miss')
            results=[results; 2 2 IDs tsSum];
        end
    end
    for ii=1:size(incongTrialsLeft,1)
        ts=double(cell2mat(fetch(DataDB,['Select pctPad1_1,pctPad1_2,pctPad1_3,pctPad1_4,pctPad1_5,pctPad1_6,pctPad1_7,pctPad1_8,pctPad1_9,pctPad1_10,pctPad1_11,pctPad1_12 FROM graspTable' num2str(incongTrialsLeft(ii)) ' WHERE TrialPeriod = 1'])));
        if size(ts,1) < 10
            continue;
        end
        tsSum=sum(ts);
        resp=fetch(DataDB, ['SELECT RespClass FROM trialsTable WHERE UniqueTrial = ' num2str(incongTrialsLeft(ii))]);
        IDs=double(cell2mat(fetch(DataDB,['SELECT SampleID, Choice1ID FROM trialsTable WHERE UniqueTrial = ' num2str(incongTrialsLeft(ii))])));
        if strcmp(cell2mat(resp),'hit')
            results=[results; 3 1 IDs tsSum];
        elseif strcmp(cell2mat(resp),'miss')
            results=[results; 3 2 IDs tsSum];
        end
    end
    for ii=1:size(incongTrialsRight,1)
        ts=double(cell2mat(fetch(DataDB,['Select pctPad2_1,pctPad2_2,pctPad2_3,pctPad2_4,pctPad2_5,pctPad2_6,pctPad2_7,pctPad2_8,pctPad2_9,pctPad2_10,pctPad2_11,pctPad2_12 FROM graspTable' num2str(incongTrialsRight(ii)) ' WHERE TrialPeriod = 1'])));
        if size(ts,1) < 10
            continue;
        end
        tsSum=sum(ts);
        resp=fetch(DataDB, ['SELECT RespClass FROM trialsTable WHERE UniqueTrial = ' num2str(incongTrialsRight(ii))]);
        IDs=double(cell2mat(fetch(DataDB,['SELECT SampleID, Choice2ID FROM trialsTable WHERE UniqueTrial = ' num2str(incongTrialsRight(ii))])));
        if strcmp(cell2mat(resp),'hit')
            results=[results; 4 1 IDs tsSum];
        elseif strcmp(cell2mat(resp),'miss')
            results=[results; 4 2 IDs tsSum];
        end
    end

end
close(DataDB)

% pre-process
ids=unique(results(:,3));
for i=1:size(ids,1)
    id=ids(i);
    correct=results(results(:,3)==id & results(:,2)==1,5:end);
    incorrect=results(results(:,3)==id & results(:,2)==2,5:end);
    
    figure; hold on;
    plot(mean(correct,1),'g')
    plot(mean(incorrect,1),'r')
    
end
%% Plot rt vs cr for all subjects, colored according to the correlation between look and touch

clear
DataDB = sqlite('C:\Users\Ryan\Documents\Data\graspHuman.db');

wherestring='ExcludeSubject = 0';
subjects=unique(cellfun(@str2num,fetch(DataDB, ['Select Subject FROM trialsTable WHERE ' wherestring])));

results=[];
for i=1:size(subjects,1)    
    wherestring=['Aligned = 1 AND SubjectTrial <100 AND Variant = "match_haptic_to_vis"  AND ExcludeSubject = 0 AND subject = ' num2str(subjects(i))];
    vals=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
    if isempty(vals)
        continue;
    end
    
    hitpR = calcRespClassCorrectRate(vals);
    a=double(cell2mat(fetch(DataDB, ['Select ReactionTime FROM trialsTable WHERE ' wherestring])));
    rtsR=mean(a);
    congs=double(cell2mat(fetch(DataDB, ['Select Congruent FROM trialsTable WHERE ' wherestring])));
    
%     c=double(cell2mat(fetch(DataDB, ['Select GraspEyeCorr FROM trialsTable WHERE SubjectTrial <100 AND Variant = "match_haptic_to_vis"  AND subject = ' num2str(subjects(i)) ' AND (RespClass = "hit" OR RespClass = "miss")'])));    
        c=double(cell2mat(fetch(DataDB, ['Select GraspEyeCorr FROM trialsTable WHERE SubjectTrial <100 AND Variant = "match_haptic_to_vis"  AND subject = ' num2str(subjects(i)) ' AND Aligned = 1'])));    
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


%% Look at change in grasp:eye correlation over trial number

clear
DataDB = sqlite('C:\Users\Ryan\Documents\Data\graspHuman.db');

a=double(cell2mat(fetch(DataDB, ['Select SubjectTrial FROM trialsTable WHERE Variant = "match_haptic_to_vis" AND Congruent = 1 AND (RespClass = "hit" OR RespClass = "miss")'])));
b=double(cell2mat(fetch(DataDB, ['Select GraspEyeCorr FROM trialsTable WHERE Variant = "match_haptic_to_vis" AND Congruent = 1 AND (RespClass = "hit" OR RespClass = "miss")'])));

c=double(cell2mat(fetch(DataDB, ['Select SubjectTrial FROM trialsTable WHERE Variant = "match_haptic_to_vis" AND Congruent = 0 AND Aligned = 1 AND (RespClass = "hit" OR RespClass = "miss")'])));
d=double(cell2mat(fetch(DataDB, ['Select GraspEyeCorr FROM trialsTable WHERE Variant = "match_haptic_to_vis" AND Congruent = 0 AND Aligned = 1 AND (RespClass = "hit" OR RespClass = "miss")'])));

e=double(cell2mat(fetch(DataDB, ['Select SubjectTrial FROM trialsTable WHERE Variant = "match_haptic_to_vis" AND Congruent = 0 AND Aligned = 0 AND (RespClass = "hit" OR RespClass = "miss")'])));
f=double(cell2mat(fetch(DataDB, ['Select GraspEyeCorr FROM trialsTable WHERE Variant = "match_haptic_to_vis" AND Congruent = 0 AND Aligned = 0 AND (RespClass = "hit" OR RespClass = "miss")'])));

close(DataDB)




figure; hold on; xlabel('Trial number'); ylabel('Correlation, negative is positive')
plot(a,b,'.b','markersize',15)
plot(c,d,'.k','markersize',15)
% plot(e,f,'.g','markersize',15)

P = polyfit(a,b,1);
yfit = P(1).*a + P(2);
w=sortrows([a yfit]);
plot(w(:,1),w(:,2),'b-','linewidth',6);


P = polyfit(c,d,1);
yfit = P(1).*c + P(2);
w=sortrows([c yfit]);
plot(w(:,1),w(:,2),'k-','linewidth',6);


P = polyfit(e,f,1);
yfit = P(1)*e+P(2);
% plot(e,yfit,'g-.');

legend('Predictable','Unpredictable Aligned')

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
    congruents=double(cell2mat(fetch(DataDB, ['Select UniqueTrial, SubjectBlock FROM trialsTable WHERE Expt = 2 AND Variant = "match_haptic_to_vis"  AND Congruent = 1 AND Subject = ' subject])));
    incongruents=double(cell2mat(fetch(DataDB, ['Select UniqueTrial, SubjectBlock FROM trialsTable WHERE Expt = 2 AND Variant = "match_haptic_to_vis"  AND Congruent = 0 AND Subject = ' subject])));    
    
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
        
        %Blinks per second
        b1s=sum(diff(valsmatC(valsmatC(:,1)==1,3))>0)/(sum(valsmatC(:,1)==1)/200);
        b2s=sum(diff(valsmatC(valsmatC(:,1)==2,3))>0)/(sum(valsmatC(:,1)==2)/200);
        
        rmat=[rmat; str2double(subject) 1 mean(b1b) mean(b2b) b1s b2s];        
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
        
%         b1s=valsmatI(valsmatI(:,1)==1,3);
%         b2s=valsmatI(valsmatI(:,1)==2,3);
%         b3s=valsmatI(valsmatI(:,1)==3,3);
%         
        %blinks per second for each block
        b1s=sum(diff(valsmatI(valsmatI(:,1)==1,3))>0)/(sum(valsmatI(:,1)==1)/200);
        b2s=sum(diff(valsmatI(valsmatI(:,1)==2,3))>0)/(sum(valsmatI(:,1)==2)/200);
        
        rmat=[rmat; str2double(subject) 0 mean(b1b) mean(b2b) b1s b2s];
    end
end

close(DataDB)

figure; subplot(2,1,1); hold on; xlabel('Block'); ylabel('% of time with eyes closed'); xticks([1 2])

congs=mean(rmat(rmat(:,2)==1,3:4),1);
incs=mean(rmat(rmat(:,2)==0,3:4),1);

% congssem=std(rmat(rmat(:,2)==1,3:5))/sqrt(size(rmat(rmat(:,2)==1,3:5),1));
% incssem=std(rmat(rmat(:,2)==0,3:5))/sqrt(size(rmat(rmat(:,2)==0,3:5),1));


bar([congs*100; incs*100]')
legend('Predictable','Unpredictable')

subplot(2,1,2); hold on; xlabel('Block'); ylabel('Saccades per second'); xticks([1 2])

congs=mean(rmat(rmat(:,2)==1,5:6),1);
incs=mean(rmat(rmat(:,2)==0,5:6),1);

% congssem=std(rmat(rmat(:,2)==1,3:5))/sqrt(size(rmat(rmat(:,2)==1,3:5),1));
% incssem=std(rmat(rmat(:,2)==0,3:5))/sqrt(size(rmat(rmat(:,2)==0,3:5),1));


bar([congs; incs]')
legend('Predictable','Unpredictable')



%% See if performance in second task is related to total time spent touching in first task. Do it by shape for each subject.
clear 

DataDB = sqlite('C:\Users\Ryan\Documents\Data\graspHuman.db');

%Get subjects
subjects=unique(cellfun(@str2num,fetch(DataDB, 'Select Subject FROM trialsTable WHERE ExcludeSubject = 0 AND Expt = 2')));

% Get info from first task
ma=[];
for i=1:size(subjects,1)
    wherestring=['Variant = "match_haptic_to_vis" AND subject = ' num2str(subjects(i))];
    vals=double(cell2mat(fetch(DataDB, ['Select UniqueTrial, Choice2ID, Condition FROM trialsTable WHERE ' wherestring])));
    for ii=1:size(vals,1) %Step through trials for this subject to count total touches and add to vals matrix
        ts=double(cell2mat(fetch(DataDB,['Select pctPad2_1,pctPad2_2,pctPad2_3,pctPad2_4,pctPad2_5,pctPad2_6,pctPad2_7,pctPad2_8,pctPad2_9,pctPad2_10,pctPad2_11,pctPad2_12 FROM graspTable' num2str(vals(ii,1)) ' WHERE TrialPeriod = 1'])));
        vals(ii,4)=sum(sum(ts));
    end
    
    if length(unique(vals(:,3))) > 1 
        disp whatwhatabort
    end
    
    %calculate total touch time for each shape in first task
    shapes=unique(vals(:,2));
    for ii=1:size(shapes,1)
        ave=sum(vals(vals(:,2)==shapes(ii),4));
        ma=[ma; vals(1,3) subjects(i) shapes(ii) ave];
    end
end

clear ave i ii shapes subjects ts vals wherestring

for i=1:size(ma,1)
   subject=ma(i,2);
   shape=ma(i,3);
   
   wherestring=['Variant = "match_vis_to_haptic" AND subject = ' num2str(subject) ' AND Choice2ID = ' num2str(shape)];
%    resps=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);
   times=double(cell2mat(fetch(DataDB, ['Select StimOn, TargetOn, PostTouchDelay FROM trialsTable WHERE ' wherestring])));
   rts=times(:,2)-times(:,1)-times(:,3);
   
   ma(i,5)=round(mean(rts));
end

close(DataDB)


% plot
figure; hold on;
plot(ma(ma(:,1)==1,4),ma(ma(:,1)==1,5),'b.', 'MarkerSize', 10) %predictable
plot(ma(ma(:,1)==2,4),ma(ma(:,1)==2,5),'k.', 'MarkerSize', 10) %unpredictable

pfit=polyfit(ma(ma(:,1)==1,4),ma(ma(:,1)==1,5),1); %predictable linear fit
ufit=polyfit(ma(ma(:,1)==2,4),ma(ma(:,1)==2,5),1); %unpredictable linear fit

plot([0 1500000],[pfit(2) 1500000*pfit(1)+pfit(2)],'b:')
plot([0 1500000],[ufit(2) 1500000*ufit(1)+ufit(2)],'k:')

plot(mean(ma(ma(:,1)==1,4)),mean(ma(ma(:,1)==1,5)),'b.', 'MarkerSize', 20) %predictable
plot(mean(ma(ma(:,1)==2,4)),mean(ma(ma(:,1)==2,5)),'k.', 'MarkerSize', 20) %unpredictable

xlabel('Cumulative touch time - Task 1')
ylabel('Mean touch time - Task - 2')
legend('Predictable','Unpredictable')

[h p]=ttest2(ma(ma(:,1)==1,4),ma(ma(:,1)==2,4));
[h p2]=ttest2(ma(ma(:,1)==1,5),ma(ma(:,1)==2,5));

disp(['cum. touch time diffs p = ' num2str(p,3) ' task 2 diffs p = ' num2str(p2,3)])


