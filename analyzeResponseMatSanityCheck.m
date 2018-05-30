function analyzeResponseMat(responseMat)
%responseMat has one row for every button press with columns: 
%           1      2       3      4      5         6         7     8         9        10         11         12       13       14         15        16       17      18          19
% Columns trial response elapsed  visYN  audYN   visOn   audOn   visDur    audDur toneScale    toneHz orientation contrast aspectRatio numCycles xcenter ycenter noiseAlpha theAngle

% clear
% load responseMat5

%% Calculate D primes

%Summarize each trial according to stimulus type (0=nothing 1=vis 2=aud 3=VA), and response type (0 1 2 3)
sm=[];
for i=1:max(responseMat(:,1))
    trialType=[];
    respType=[];
    thisTrial=responseMat(responseMat(:,1)==i,:); %Grab this trial
    if isempty(thisTrial)   %Make sure theres something stored for this trial
        disp(['Empty: ' num2str(i)])
        continue;
    end
    
    if ~thisTrial(1,4) && ~thisTrial(1,5)
        trialType=0;
    elseif thisTrial(1,4) && thisTrial(1,5)
        trialType=3;
    elseif thisTrial(1,4) && ~thisTrial(1,5)
        trialType=1;
    elseif ~thisTrial(1,4) && thisTrial(1,5)
        trialType=2;
    end
    
    thisResps=thisTrial(:,2);
    if isnan(thisTrial(1,2))
        respType=0;
    elseif length(thisResps)==2
        respType=3;
    elseif isnan(thisResps)
        respType=0;
    elseif thisResps==0
        respType=1;
    elseif thisResps==1
        respType=2;
    end
    
    sm=[sm; i trialType respType];
    
end

for i=1:1000;
    
%Randomize for 
sm(:,2)=sm(randperm(size(sm,1),size(sm,1)),2); 

% First for vis only trials
% original=sm;
% dVisAlone=[];
% for i=1:1000
%     if i==1 %On first run, do the whole thing
%         sm=original;
%     else
%         sm=original(randperm(size(original,1),size(original,1)/2),:);
%     end
%     sm(:,2)=sm(randperm(size(sm,1),size(sm,1)),2); 
    
    pHit=sum(sm(:,2)==1 & (sm(:,3)==1 | sm(:,3)==3)) / sum(sm(:,2)==1);              % 'V' or 'VA' given 'V' / V
    pMiss=sum(sm(:,2)==1 & (sm(:,3)==2 | sm(:,3)==0)) / sum(sm(:,2)==1);             % '_' or 'A' given 'V' / V
    pFA=sum((sm(:,2)==0 | sm(:,2)==2) & (sm(:,3)==1 | sm(:,3)==3)) / sum((sm(:,2)==0 | sm(:,2)==2));  % 'V' or 'VA' given _ or A / _ or A
    pCR=sum((sm(:,2)==0 | sm(:,2)==2) & (sm(:,3)==0 | sm(:,3)==2)) / sum((sm(:,2)==0 | sm(:,2)==2)); %'_' or 'A' given _ or A / _ or A
    
    pHit=min(pHit,0.999999999); pHit=max(pHit,0.00000001);
    pMiss=min(pMiss,0.999999999); pMiss=max(pMiss,0.00000001);
    pFA=min(pFA,0.999999999); pFA=max(pFA,0.00000001);
    pCR=min(pCR,0.999999999); pCR=max(pCR,0.00000001);
    
    dVisAlone(i) = norminv(pHit) - norminv(pFA);  %-- Calculate d-prime
    
% end
% sm=original;


% hist(dVisAlone)



pHitV=pHit

disp(['pHit: ' num2str(pHit) ' pMiss: ' num2str(pMiss) ' pFA: ' num2str(pFA) ' pCR: ' num2str(pCR) ' dVisAlone: ' num2str(dVisAlone)])

% vis in VA trials

% original=sm;
% dVisinVA=[];
% for i=1:1000
%     if i==1 %On first run, do the whole thing
%         sm=original;
%     else
%         sm=original(randperm(size(original,1),size(original,1)/2),:);
%     end
%     sm(:,2)=sm(randperm(size(sm,1),size(sm,1)),2); 
    
    pHit=sum(sm(:,2)==3 & (sm(:,3)==1 | sm(:,3)==3)) / sum(sm(:,2)==3);              % 'V' or 'VA' given 'VA' / VA
    pMiss=sum(sm(:,2)==3 & (sm(:,3)==2 | sm(:,3)==0)) / sum(sm(:,2)==3);             % '_' or 'A' given 'VA' / VA
    pFA=sum((sm(:,2)==0 | sm(:,2)==2) & (sm(:,3)==1 | sm(:,3)==3)) / sum((sm(:,2)==0 | sm(:,2)==2));  % 'V' or 'VA' given _ or A / _ or A
    pCR=sum((sm(:,2)==0 | sm(:,2)==2) & (sm(:,3)==0 | sm(:,3)==2)) / sum((sm(:,2)==0 | sm(:,2)==2)); %'_' or 'A' given _ or A / _ or A
    
    pHit=min(pHit,0.999999999); pHit=max(pHit,0.00000001);
    pMiss=min(pMiss,0.999999999); pMiss=max(pMiss,0.00000001);
    pFA=min(pFA,0.999999999); pFA=max(pFA,0.00000001);
    pCR=min(pCR,0.999999999); pCR=max(pCR,0.00000001);
    
    dVisinVA(i) = norminv(pHit) - norminv(pFA);  %-- Calculate d-prime
% end

% sm=original;

disp(['pHit: ' num2str(pHit) ' pMiss: ' num2str(pMiss) ' pFA: ' num2str(pFA) ' pCR: ' num2str(pCR) ' dVisinVA: ' num2str(dVisinVA)])

% aud only trials
% original=sm;
% dAudAlone=[];
% for i=1:1000
%     if i==1 %On first run, do the whole thing
%         sm=original;
%     else
%         sm=original(randperm(size(original,1),size(original,1)/2),:);
%     end
%     sm(:,2)=sm(randperm(size(sm,1),size(sm,1)),2); 
    
    pHit=sum(sm(:,2)==2 & (sm(:,3)==2 | sm(:,3)==3)) / sum(sm(:,2)==2);              % 'A' or 'VA' given 'A' / A
    pMiss=sum(sm(:,2)==2 & (sm(:,3)==1 | sm(:,3)==0)) / sum(sm(:,2)==2);             % '_' or 'V' given 'A' / A
    pFA=sum((sm(:,2)==0 | sm(:,2)==1) & (sm(:,3)==2 | sm(:,3)==3)) / sum((sm(:,2)==0 | sm(:,2)==1));  % 'A' or 'VA' given _ or V / _ or V
    pCR=sum((sm(:,2)==0 | sm(:,2)==1) & (sm(:,3)==0 | sm(:,3)==1)) / sum((sm(:,2)==0 | sm(:,2)==1)); %'_' or 'V' given _ or V / _ or V
    
    pHit=min(pHit,0.999999999); pHit=max(pHit,0.00000001);
    pMiss=min(pMiss,0.999999999); pMiss=max(pMiss,0.00000001);
    pFA=min(pFA,0.999999999); pFA=max(pFA,0.00000001);
    pCR=min(pCR,0.999999999); pCR=max(pCR,0.00000001);
    
    dAudAlone(i) = norminv(pHit) - norminv(pFA);  %-- Calculate d-prime
% end

pHitA=pHit
% sm=original;

disp(['pHit: ' num2str(pHit) ' pMiss: ' num2str(pMiss) ' pFA: ' num2str(pFA) ' pCR: ' num2str(pCR) ' dAudAlone: ' num2str(dAudAlone)])

% aud in VA trials
% original=sm;
% dAudinVA=[];
% for i=1:1000
%     if i==1 %On first run, do the whole thing
%         sm=original;
%     else
%         sm=original(randperm(size(original,1),size(original,1)/2),:);
%     end
%     sm(:,2)=sm(randperm(size(sm,1),size(sm,1)),2); 
 
    pHit=sum(sm(:,2)==3 & (sm(:,3)==2 | sm(:,3)==3)) / sum(sm(:,2)==3);              % 'A' or 'VA' given 'VA' / VA
    pMiss=sum(sm(:,2)==3 & (sm(:,3)==1 | sm(:,3)==0)) / sum(sm(:,2)==3);             % '_' or 'V' given 'VA' / VA
    pFA=sum((sm(:,2)==0 | sm(:,2)==1) & (sm(:,3)==2 | sm(:,3)==3)) / sum((sm(:,2)==0 | sm(:,2)==1));  % 'A' or 'VA' given _ or V / _ or V
    pCR=sum((sm(:,2)==0 | sm(:,2)==1) & (sm(:,3)==0 | sm(:,3)==1)) / sum((sm(:,2)==0 | sm(:,2)==1)); %'_' or 'V' given _ or V / _ or V
    
    pHit=min(pHit,0.999999999); pHit=max(pHit,0.00000001);
    pMiss=min(pMiss,0.999999999); pMiss=max(pMiss,0.00000001);
    pFA=min(pFA,0.999999999); pFA=max(pFA,0.00000001);
    pCR=min(pCR,0.999999999); pCR=max(pCR,0.00000001);
    
    dAudinVA(i) = norminv(pHit) - norminv(pFA);  %-- Calculate d-prime
% end
disp(['pHit: ' num2str(pHit) ' pMiss: ' num2str(pMiss) ' pFA: ' num2str(pFA) ' pCR: ' num2str(pCR) ' dAudinVA: ' num2str(dAudinVA)])
% sm=original;


end

%VA in VA trials
pHit=sum(sm(:,2)==3 & (sm(:,3)==3)) / sum(sm(:,2)==3);              % 'VA' given 'VA' / VA
pMiss=sum(sm(:,2)==3 & (sm(:,3)==2 | sm(:,3)==1 | sm(:,3)==0)) / sum(sm(:,2)==3);             % '_' or 'V' or 'A' given 'VA' / VA
pFA=sum((sm(:,2)==0 | sm(:,2)==1 | sm(:,2)==2) & (sm(:,3)==3)) / sum((sm(:,2)==0 | sm(:,2)==1 | sm(:,2)==2));  % 'VA' given A or _ or V / A or _ or V
pCR=sum((sm(:,2)==0 | sm(:,2)==1 | sm(:,2)==2) & (sm(:,3)==2 | sm(:,3)==1 | sm(:,3)==0)) / sum((sm(:,2)==0 | sm(:,2)==1 | sm(:,2)==2)); %'_' or 'V' given _ or V / _ or V

pHit=min(pHit,0.999999999); pHit=max(pHit,0.00000001);
pMiss=min(pMiss,0.999999999); pMiss=max(pMiss,0.00000001);
pFA=min(pFA,0.999999999); pFA=max(pFA,0.00000001);
pCR=min(pCR,0.999999999); pCR=max(pCR,0.00000001);

dVAinVA = norminv(pHit) - norminv(pFA);  %-- Calculate d-prime

pHitVandA=pHit

disp(['pHit: ' num2str(pHit) ' pMiss: ' num2str(pMiss) ' pFA: ' num2str(pFA) ' pCR: ' num2str(pCR) ' dVAinVA: ' num2str(dVAinVA)])


%V or A or VA in VA trials
pHit=sum(sm(:,2)==3 & (sm(:,3)==1 | sm(:,3)==2 | sm(:,3)==3)) / sum(sm(:,2)==3);              % 'VA' or 'V' or 'A' given 'VA' / VA
pMiss=sum(sm(:,2)==3 & (sm(:,3)==0)) / sum(sm(:,2)==3);                                        % '_' given 'VA' / VA
pFA=sum((sm(:,2)==0) & (sm(:,3)==1 | sm(:,3)==2 | sm(:,3)==3)) / sum(sm(:,2)==0);  % 'V' or 'A' or 'VA' given _ / _
pCR=sum((sm(:,2)==0) & (sm(:,3)==0)) / sum(sm(:,2)==0); %'_' given _ / _

pHit=min(pHit,0.999999999);     pHit=max(pHit,0.00000001);
pMiss=min(pMiss,0.999999999);   pMiss=max(pMiss,0.00000001);
pFA=min(pFA,0.999999999);       pFA=max(pFA,0.00000001);
pCR=min(pCR,0.999999999);       pCR=max(pCR,0.00000001);

dAnyinVA = norminv(pHit) - norminv(pFA);  %-- Calculate d-prime

pHitVorA=pHit

disp(['pHit: ' num2str(pHit) ' pMiss: ' num2str(pMiss) ' pFA: ' num2str(pFA) ' pCR: ' num2str(pCR) ' dAnyinVA: ' num2str(dAnyinVA)])




figure;
bar([dVisAlone(1) dVisinVA(1) dAudAlone(1) dAudinVA(1) dVAinVA dAnyinVA])
view(90,90)
xticklabels({'V|V','V|VA','A|A','A|VA','V AND A|VA','V OR A|VA'})


pHitVorA=pHitV+pHitA-(pHitV*pHitA)
pHitVandA=pHitV*pHitA

[h p]=ttest2(dVisAlone,dVisinVA)

if h
    hold on;
    plot(1.5,1,'*')
end

[h p]=ttest2(dAudAlone,dAudinVA)

if h
    hold on;
    plot(3.5,1,'*')
end

figure; subplot(2,1,1); hold on;
title('Discriminability of V in V (blue) or VA (red)')
[y x]=hist(dVisAlone,-1:.01:10);
plot(x,y)
[y x]=hist(dVisinVA,-1:.01:10);
plot(x,y,'r')


subplot(2,1,2); hold on;
title('Discriminability of A in A (blue) or VA (red)')
[y x]=hist(dAudAlone,-1:.01:10);
plot(x,y)
[y x]=hist(dAudinVA,-1:.01:10);
plot(x,y,'r')


(mean(dVisAlone)-mean(dVisinVA))/std(dVisAlone)
(mean(dAudAlone)-mean(dAudinVA))/std(dAudAlone)

return
