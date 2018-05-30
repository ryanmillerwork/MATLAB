clear all

plotit=0;

difference=0; %Determine whether to calculate difference between actual and expected based on random permutation

padfiltersigma=1; %min 1, 5 is pretty bad
padAngleJitter=0; %30 is pretty bad, set to zero to save time
padXYJitter=1; %2 is pretty bad, 1 is workable
matrixWidth=50;

subject=3;


%% find trials to analyze
DataDB = sqlite('C:\Users\Ryan\Documents\Data\graspHuman.db');
% wherestring='ExcludeSubject = 0 AND Congruent = 1 AND RespClass = "hit" AND ExcludeTrialGrasp = 0 AND Target != 2';
wherestring=['Subject = ' num2str(subject)];
trials=double(cell2mat(fetch(DataDB, ['Select UniqueTrial FROM trialsTable WHERE ' wherestring])));

% get responses for those trials
resps=fetch(DataDB, ['Select RespClass FROM trialsTable WHERE ' wherestring]);

%% create list of duplicate objects
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
close(ObjectsDB)

% figure; hold on;

tic
vecMat=[];

finalpmat=[];
for tc=1:size(trials,1)
    t=trials(tc);
    
    %% get grasp data for this trial
    
    DataDB = sqlite('C:\Users\Ryan\Documents\Data\graspHuman.db');
    trial=num2str(t);
    sampleID=double(cell2mat(fetch(DataDB, ['SELECT SampleID FROM trialsTable WHERE UniqueTrial = ' trial])));
    try
        id=double(cell2mat(fetch(DataDB, ['SELECT Choice1ID FROM trialsTable WHERE UniqueTrial = ' trial])));
        pcts=double(cell2mat(fetch(DataDB, ['SELECT pctPad1_1, pctPad1_2, pctPad1_3, pctPad1_4, pctPad1_5, pctPad1_6, pctPad1_7, pctPad1_8, pctPad1_9, pctPad1_10, pctPad1_11, pctPad1_12 FROM graspTable' trial ' WHERE TrialPeriod = 1'])));
    catch
        id=double(cell2mat(fetch(DataDB, ['SELECT Choice2ID FROM trialsTable WHERE UniqueTrial = ' trial])));
        pcts=double(cell2mat(fetch(DataDB, ['SELECT pctPad2_1, pctPad2_2, pctPad2_3, pctPad2_4, pctPad2_5, pctPad2_6, pctPad2_7, pctPad2_8, pctPad2_9, pctPad2_10, pctPad2_11, pctPad2_12 FROM graspTable' trial ' WHERE TrialPeriod = 1'])));
    end
    close(DataDB)
    clear DataDB
    
    %% make filtered pads for this object
    tableid=num2str(id);
    
    conn = sqlite('L:\stimuli\grasp\objects.db');
    
    filtered=zeros(matrixWidth,matrixWidth,12);
    for i=1:12
        %get pad data
        mat=fetch(conn,['SELECT * FROM shapeTable' num2str(id) ' WHERE PAD IS ' num2str(i)]);
        mat=cell2mat(mat(:,1:2));
        mat=round(mat.*matrixWidth.*.8)+round(matrixWidth/2); %Scale and shift pad
        
        %Put pad in matrix
        f=zeros(matrixWidth,matrixWidth);
        for ii=1:size(mat,1)
            f(mat(ii,1),mat(ii,2))=1;
        end
        
        %filter
        h=fspecial('log',round(matrixWidth/5),padfiltersigma).*-1; %width, sigma
        filtered(:,:,i) = filter2(h, f);
    end
    
    close(conn)
    
    clear conn h f mat i ii
    
    %% Train classifier
    % Get vis trainer for this object
    load(['target' num2str(sampleID) '.mat'])
    visTrainer=vecMat;
    
    % get history trainer for this subject
    load(['subject' num2str(subject) 'sig1jit1.mat'])
    % parse out matches and non-matches
    [row, ~]=find(groups==sampleID);
    targ1=groups(row,1);
    targ2=groups(row,2);
    
    idMat(idMat==targ1)=1;
    idMat(idMat==targ2)=1;
    idMat(idMat~=1)=-1;
    
    %Remove everything after this trial
    idMat=idMat(1:max([40 tc]));
    vecMat=vecMat(1:max([40 tc]),:);
%     
    %Add currently visualized in high def
    idMat(end+1)=1;
    vecMat(end+1,:)=visTrainer;
    
    %Remove some old ones with a certain halflife
    halflife=150; %trials
    lam=log(2)/halflife;
    for i=1:tc
        p=exp(-lam.*(tc-i)); %Probability that this trial should be kept
        if rand(1) > p %remove this trial from "memory"
            idMat(i)=nan;
        end
    end
    vecMat(isnan(idMat),:)=[];
    idMat(isnan(idMat))=[];
    %Normalize
    %     vecMat(vecMat<0)=0;
    %     for i=1:size(vecMat,1)
    %        vecMat(i,:)= vecMat(i,:)./max(vecMat(i,:));
    %     end
    
    %remove outlier shapes so that there are equal numbers of matches and nonmatches
    
    matches=sum(idMat==1);
    nonmatches=sum(idMat==-1);
    removals=find(idMat==-1,nonmatches-matches);
    
        vecMat(removals,:)=[];
        idMat(removals,:)=[];
    
    
    %     idMat=[idMat; ones(nonmatches-matches,1)];
    %     for i = 1:nonmatches-matches
    %         vecMat=[vecMat; vecMat(end,:)];
    %     end
    %
    
%     vecMat(vecMat>1)=1;
%     vecMat(vecMat<1)=0;

%     for i=1:size(vecMat,1)
%         vecMat(i,:)=vecMat(i,:)./max(vecMat(i,:));
%     end
        
    
    
    
    SVM = svmtrain(idMat, vecMat, '-s 0 -t 3 -b 1 -q');
    %     SVM = svmtrain(idMat, vecMat, '-s 2 -t 3');
    
    
    
    %% Construct all frames of accumulation of object info
    if plotit
        figure;
        subplot(1,4,2); hold on; axis equal; colormap(gray); colorbar; axis tight; xticks([]); yticks([])
        a=vecMat(idMat==1,:);
        b=sum(a,1);
        imagesc(reshape(b,matrixWidth,matrixWidth))
        view(90,-90)
        
        subplot(1,4,3); hold on; axis equal; colormap(gray); colorbar; axis tight; xticks([]); yticks([])
        c=vecMat(idMat==-1,:);
        d=sum(c,1);
        imagesc(reshape(d,matrixWidth,matrixWidth))
        view(90,-90)
    end
    
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
        vidMatCum=sum(vidMat,3);
        vmcl=vidMatCum(:)';
        
%         vmcl(vmcl>1)=1;
%         vmcl(vmcl<1)=0;

%         vmcl=vmcl./max(vmcl);
        
        if plotit
            subplot(1,4,1); hold on; axis equal; colormap(gray); colorbar; axis tight; xticks([]); yticks([])
            cla
            imagesc(reshape(vmcl,50,50))
            view(90,-90)
            drawnow
        end
        %Test
        [predict_label_L, accuracy_L, dec_values_L] = svmpredict(1, vmcl, SVM, '-b 1 -q');
        %         [predict_label_L, accuracy_L, dec_values_L] = svmpredict(1, vmcl, SVM);
        if plotit
            subplot(1,4,4); hold on; ylim([0 1])
            plot(i,dec_values_L(1),'.')
        end
        
        %         drawnow
    end
    toc
    clear started i this ii pcts f f2 angle xshift yshift filtered
    %     drawnow
    %     vmcvec=vidMatCum(:)';
    %     vecMat=[vecMat; vmcvec];
    %     save(['trial' trial '.mat'],'vidMatCum','-v7.3')
    
    %
    if plotit
        subplot(1,4,1); hold on; axis equal; colormap(gray); colorbar; axis tight; xticks([]); yticks([])
        imagesc(reshape(vmcl,50,50))
        view(90,-90)
        drawnow
    end
    
    
    
    %         subplot(1,3,3); hold on; axis equal; colormap(gray); colorbar; axis tight; xticks([]); yticks([])
    %         imagesc(mean(pile3,3))
    %         view(90,-90)
    
    finalpmat=[finalpmat; id==sampleID dec_values_L(1)];
    % return
    %%
    %     vidMatCum=sum(vidMat,3);
    
    
    %% Save to db
    %     if difference
    %         DataDB = sqlite('C:\Users\Ryan\Documents\Data\graspHumanTouchDifference.db');
    %     end
    %
    %     createGraspTouchTable = ['create table IF NOT EXISTS graspTouchTable' trial ' (ind NUMERIC, value NUMERIC)'];
    %     exec(DataDB,createGraspTouchTable)
    %
    %
    %     a=find(vidMatCum);
    %     b=vidMatCum(a);
    %
    %     colnames={'ind','value'};
    %     values=[a b];
    %     insert(DataDB,['graspTouchTable' trial],colnames, values)
    %
    
    %     close(DataDB)
    
    
    
end




figure; hold on;
matches=finalpmat(:,2);
matches(finalpmat(:,1)==0)=nan;
nonmatches=finalpmat(:,2);
nonmatches(finalpmat(:,1)==1)=nan;
plot(smooth(matches,30),'b')
plot(smooth(nonmatches,30),'r')
legend('match','nonmatch')

xlabel('trial')
ylabel('probability of saying match')

figure; hold on;
plot(matches,'g.')
plot(nonmatches,'r.')

finalpmat(:,3)=finalpmat(:,2);
finalpmat(finalpmat(:,1)==0,3)=1-finalpmat(finalpmat(:,1)==0,2);
finalpmat(:,3)=round(finalpmat(:,3));
window=10;

figure; hold on; ylim([0 1])
for i=1:size(matches,1)-window
    plot(i+window/2,sum(finalpmat(i:i+window-1,3))/window,'.')
    
end

rmat=[];
for i=1:size(resps,1)
   if strcmp(resps{i,1}, 'miss') || strcmp(resps{i,1}, 'fa')
       respScore=1;
   else
       respScore=0;
   end
    rmat=[rmat; respScore];
    
end

figure;  
subplot(2,1,1); hold on; title('Correct trials'); ylabel('Trials')
hist(finalpmat(rmat==0,2),20)
subplot(2,1,2); hold on; title('Incorrect trials'); xlabel('P-val of classifier output')
hist(finalpmat(rmat==1,2),20)
