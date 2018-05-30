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

% i=1;
%Randomize for 
% sm(:,2)=sm(randperm(size(sm,1),size(sm,1)),2); 



%Randomize
% sm(:,2)=sm(randperm(size(sm,1),size(sm,1)),2); 



original=sm;


dVisAlone=[];
dVisinVA=[];
for i=1:1000

    
    %Grab subset
    if i==1 %On first run, do the whole thing
%         sm=original;
        
    else
        sm=original(randperm(size(original,1),size(original,1)/2),:);
    end
%     sm(:,2)=sm(randperm(size(sm,1),size(sm,1)),2); 

    
    %First for v in v
    pHit=sum(sm(:,2)==1 & (sm(:,3)==1 | sm(:,3)==3)) / sum(sm(:,2)==1);              % 'V' or 'VA' given 'V' / V
    pMiss=sum(sm(:,2)==1 & (sm(:,3)==2 | sm(:,3)==0)) / sum(sm(:,2)==1);             % '_' or 'A' given 'V' / V
    pFA=sum((sm(:,2)==0 | sm(:,2)==2) & (sm(:,3)==1 | sm(:,3)==3)) / sum((sm(:,2)==0 | sm(:,2)==2));  % 'V' or 'VA' given _ or A / _ or A
    pCR=sum((sm(:,2)==0 | sm(:,2)==2) & (sm(:,3)==0 | sm(:,3)==2)) / sum((sm(:,2)==0 | sm(:,2)==2)); %'_' or 'A' given _ or A / _ or A
    
    pHit=min(pHit,0.999999999); pHit=max(pHit,0.00000001);
    pMiss=min(pMiss,0.999999999); pMiss=max(pMiss,0.00000001);
    pFA=min(pFA,0.999999999); pFA=max(pFA,0.00000001);
    pCR=min(pCR,0.999999999); pCR=max(pCR,0.00000001);
    
    dVisAlone(i) = norminv(pHit) - norminv(pFA);  %-- Calculate d-prime
    
    % Then for v in va    
    pHit=sum(sm(:,2)==3 & (sm(:,3)==1 | sm(:,3)==3)) / sum(sm(:,2)==3);              % 'V' or 'VA' given 'VA' / VA
    pMiss=sum(sm(:,2)==3 & (sm(:,3)==2 | sm(:,3)==0)) / sum(sm(:,2)==3);             % '_' or 'A' given 'VA' / VA
    pFA=sum((sm(:,2)==0 | sm(:,2)==2) & (sm(:,3)==1 | sm(:,3)==3)) / sum((sm(:,2)==0 | sm(:,2)==2));  % 'V' or 'VA' given _ or A / _ or A
    pCR=sum((sm(:,2)==0 | sm(:,2)==2) & (sm(:,3)==0 | sm(:,3)==2)) / sum((sm(:,2)==0 | sm(:,2)==2)); %'_' or 'A' given _ or A / _ or A
    
    pHit=min(pHit,0.999999999); pHit=max(pHit,0.00000001);
    pMiss=min(pMiss,0.999999999); pMiss=max(pMiss,0.00000001);
    pFA=min(pFA,0.999999999); pFA=max(pFA,0.00000001);
    pCR=min(pCR,0.999999999); pCR=max(pCR,0.00000001);
    
    dVisinVA(i) = norminv(pHit) - norminv(pFA);  %-- Calculate d-prime
end
% return

% sm=original;

disp(['pHit: ' num2str(pHit) ' pMiss: ' num2str(pMiss) ' pFA: ' num2str(pFA) ' pCR: ' num2str(pCR) ' dVisinVA: ' num2str(dVisinVA)])

% aud only trials
original=sm;
dAudAlone=[];
dAudinVA=[];
for i=1:1000
    if i==1 %On first run, do the whole thing
%         sm=original;
    else
        sm=original(randperm(size(original,1),size(original,1)/2),:);
    end
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
% 
% pHitA=pHit
% sm=original;

% disp(['pHit: ' num2str(pHit) ' pMiss: ' num2str(pMiss) ' pFA: ' num2str(pFA) ' pCR: ' num2str(pCR) ' dAudAlone: ' num2str(dAudAlone)])

% aud in VA trials
% original=sm;

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
end
% disp(['pHit: ' num2str(pHit) ' pMiss: ' num2str(pMiss) ' pFA: ' num2str(pFA) ' pCR: ' num2str(pCR) ' dAudinVA: ' num2str(dAudinVA)])
% sm=original;

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


% pHitVorA=pHitV+pHitA-(pHitV*pHitA)
% pHitVandA=pHitV*pHitA

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

%% Plot hit rate for auditory frequency
vTrials=responseMat(responseMat(:,4) & ~responseMat(:,5),:);
aTrials=responseMat(~responseMat(:,4) & responseMat(:,5),:);
vaTrials=responseMat(responseMat(:,4) & responseMat(:,5),:);

%plot hit rate across aud freqs
aresp=ones(1,20000);
for i=1:max(aTrials(:,1))
    trialType=[];
    respType=[];
    thisTrial=aTrials(aTrials(:,1)==i,:); %Grab this trial
    if isempty(thisTrial)   %Make sure theres something stored for this trial
        disp(['Empty: ' num2str(i)])
        continue;
    end
    
    thisResps=thisTrial(:,2);
    if isnan(thisTrial(1,2))
        respType=0; %No response
    elseif length(thisResps)==2
        respType=3; %VA response
    elseif isnan(thisResps)
        respType=0; %No response
    elseif thisResps==0
        respType=1; %V response
    elseif thisResps==1
        respType=2; %A response
    end
    
    thisHz=round(thisTrial(1,11));
    
    if respType==2 || respType==3
        aresp(thisHz)=aresp(thisHz)+0.1;
    else
        aresp(thisHz)=aresp(thisHz)-0.1;
    end
end
arespv=ones(1,20000);
for i=1:max(vaTrials(:,1))
    respType=[];
    thisTrial=vaTrials(vaTrials(:,1)==i,:); %Grab this trial
    if isempty(thisTrial)   %Make sure theres something stored for this trial
        disp(['Empty: ' num2str(i)])
        continue;
    end
    
    thisResps=thisTrial(:,2);
    if isnan(thisTrial(1,2))
        respType=0; %No response
    elseif length(thisResps)==2
        respType=3; %VA response
    elseif isnan(thisResps)
        respType=0; %No response
    elseif thisResps==0
        respType=1; %V response
    elseif thisResps==1
        respType=2; %A response
    end
    
    thisHz=round(thisTrial(1,11));
    
    if respType==2 || respType==3
        arespv(thisHz)=arespv(thisHz)+0.1;
    else
        arespv(thisHz)=arespv(thisHz)-0.1;
    end
end
figure;
loglog(20:20000,aresp(20:20000),'r')
hold on;
loglog(20:20000,arespv(20:20000))



%% Plot hit rate for spatial location

screen=ones(1200,1920);

% screen(1:100,1:100)=screen(1:100,1:100)+1; %Top left


for i=1:max(vTrials(:,1))
    respType=[];
    thisTrial=vTrials(vTrials(:,1)==i,:); %Grab this trial
    if isempty(thisTrial)   %Make sure theres something stored for this trial
        disp(['Empty: ' num2str(i)])
        continue;
    end
    
    thisResps=thisTrial(:,2);
    if isnan(thisTrial(1,2))
        respType=0; %No response
    elseif length(thisResps)==2
        respType=3; %VA response
    elseif isnan(thisResps)
        respType=0; %No response
    elseif thisResps==0
        respType=1; %V response
    elseif thisResps==1
        respType=2; %A response
    end
    
    thisX=round(thisTrial(1,16));
    thisY=round(thisTrial(1,17));
    rad=100;
    
    if respType==1 || respType==3
        screen(thisY-rad:thisY+rad,thisX-rad:thisX+rad)=screen(thisY-rad:thisY+rad,thisX-rad:thisX+rad)+0.1;
    else
        screen(thisY-rad:thisY+rad,thisX-rad:thisX+rad)=screen(thisY-rad:thisY+rad,thisX-rad:thisX+rad)-0.1;
    end
end

figure; subplot(2,1,1); imagesc(screen)
axis equal
axis tight
title('Hit rate for vis-only trials')
screen=ones(1200,1920);

% screen(1:100,1:100)=screen(1:100,1:100)+1; %Top left


for i=1:max(vaTrials(:,1))
    respType=[];
    thisTrial=vaTrials(vaTrials(:,1)==i,:); %Grab this trial
    if isempty(thisTrial)   %Make sure theres something stored for this trial
        disp(['Empty: ' num2str(i)])
        continue;
    end
    
    thisResps=thisTrial(:,2);
    if isnan(thisTrial(1,2))
        respType=0; %No response
    elseif length(thisResps)==2
        respType=3; %VA response
    elseif isnan(thisResps)
        respType=0; %No response
    elseif thisResps==0
        respType=1; %V response
    elseif thisResps==1
        respType=2; %A response
    end
    
    thisX=round(thisTrial(1,16));
    thisY=round(thisTrial(1,17));
    rad=100;
    
    if respType==1 || respType==3
        screen(thisY-rad:thisY+rad,thisX-rad:thisX+rad)=screen(thisY-rad:thisY+rad,thisX-rad:thisX+rad)+0.1;
    else
        screen(thisY-rad:thisY+rad,thisX-rad:thisX+rad)=screen(thisY-rad:thisY+rad,thisX-rad:thisX+rad)-0.1;
    end
end

subplot(2,1,2); imagesc(screen)
axis equal
axis tight
title('Hit rate for VA trials')

%% Look at detection probabilities vs SOA

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
    
    if trialType==3
        sm=[sm; i trialType respType round((thisTrial(1,7)-thisTrial(1,6))*1000)];
    end
end

soas=zeros(1,1001);
soas2=zeros(1,1001);
respList=[];
for i=1:size(sm,1)
    thisSOA=500+sm(i,4);
    %     soas2(thisSOA)=soas2(thisSOA)+1;
    if sm(i,3)==1 || sm(i,3)==2
        soas(thisSOA)=soas(thisSOA)+1;
        respList=[respList; 1];
    elseif sm(i,3)==3
        soas(thisSOA)=soas(thisSOA)+2;
        respList=[respList; 2];
        %     elseif sm(i,3)==0
        %         soas(thisSOA)=soas(thisSOA)-1;
    end
end

meanRL=mean(respList);
for i=1:size(sm,1)
    thisSOA=500+sm(i,4);
    soas2(thisSOA)=soas2(thisSOA)+meanRL;
end




figure; subplot(2,1,1); hold on; title('SOAs')

plot(-500:500,smooth(soas,10))
plot(-500:500,smooth(soas2,10),'r')

subplot(2,1,2);
plot(-500:500,smooth(soas-soas2,10))

