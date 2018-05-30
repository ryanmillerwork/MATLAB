clear all

% load classifier
load classifierSVM; Mdl=SVMModel;


%% find trials to analyze
DataDB = sqlite('C:\Users\Ryan\Documents\Data\graspHuman.db');
wherestring='ExcludeSubject = 0 AND Congruent = 1 AND RespClass = "hit" AND ExcludeTrialGrasp = 0';
trials=double(cell2mat(fetch(DataDB, ['Select UniqueTrial FROM trialsTable WHERE ' wherestring])));

tic
for t=trials'
    %% get grasp data for this trial    
    DataDB = sqlite('C:\Users\Ryan\Documents\Data\graspHuman.db');
    trial=num2str(t);
    try
        id=double(cell2mat(fetch(DataDB, ['SELECT Choice1ID FROM trialsTable WHERE UniqueTrial = ' trial])));
        pcts=double(cell2mat(fetch(DataDB, ['SELECT pctPad1_1, pctPad1_2, pctPad1_3, pctPad1_4, pctPad1_5, pctPad1_6, pctPad1_7, pctPad1_8, pctPad1_9, pctPad1_10, pctPad1_11, pctPad1_12 FROM graspTable' trial ' WHERE TrialPeriod = 1'])));
    catch
        id=double(cell2mat(fetch(DataDB, ['SELECT Choice2ID FROM trialsTable WHERE UniqueTrial = ' trial])));
        pcts=double(cell2mat(fetch(DataDB, ['SELECT pctPad2_1, pctPad2_2, pctPad2_3, pctPad2_4, pctPad2_5, pctPad2_6, pctPad2_7, pctPad2_8, pctPad2_9, pctPad2_10, pctPad2_11, pctPad2_12 FROM graspTable' trial ' WHERE TrialPeriod = 1'])));
    end
    close(DataDB)
    clear DataDB
    
    %% calculate midpoints for each pad and rotate
    conn = sqlite('L:\stimuli\grasp\objects.db');
    mids=[]; %Midpoints of each pad    
    for i=1:12
        mat=fetch(conn,['SELECT * FROM shapeTable' num2str(id) ' WHERE PAD IS ' num2str(i)]);
        mat=cell2mat(mat(:,1:2));        
        
        xmid=mean(mat(:,1));
        ymid=mean(mat(:,2));
        
        mids=[mids; xmid ymid];
    end
    close(conn)
    [rad,dist] = cart2pol(mids(:,1),mids(:,2)); %Convert to polar coordinates
   
    %Reorder matrix so that first angle > zero is first value
    first=find(rad>0,1);
    dist=dist([first:end 1:first-1]);
    rad=rad([first:end 1:first-1]);
    
    %% step through samples and calculate points at each time period
    X=nan(size(pcts,1),size(pcts,2)*2);
    
    stds=100-pcts;
    stds(stds<0)=0;
    stds=stds+1;
%     stds=nthroot(stds,13);
    stds=stds./200;
    %     stds=stds./10;
    %     stds=stds.^.1;
    
    %Choose variables
    for i=1:size(X,1)
        
            for ii=1:12
                if pcts(i,ii) > 15
                    X(i,ii)=rad(ii) + randn(1,1) * stds(i,ii);
                    X(i,ii+12)=dist(ii) + randn(1,1) * stds(i,ii);
                end
            end

            firstrow=max([1 i-100]);
            this=nanmean(X(firstrow:i,:));
            
            if ~isnan(this)
            [yhat,PostProbs,MisClassCost] = predict(Mdl,this);
%             [yhat,PostProbs,MisClassCost] = predict(Mdl,nanmean(X));
            Y=repmat(16,size(yhat,1),1);
%             C = confusionmat(Y,yhat);
            disp(['trial: ' num2str(t) ' classified as: ' num2str(yhat) ', actual id: ' num2str(id) ', p=' num2str(max(PostProbs))])
            
            cla
            polarplot(nanmean(X(firstrow:i,1:12)),nanmean(X(firstrow:i,13:24)))
            hold on
            drawnow
            end
    
        
        

    end
    
    
    

    
    C = confusionmat(Y,yhat);
    figure;
    imagesc(C)
%     
    disp(['trial: ' num2str(t) ' classified as: ' num2str(yhat) ', actual id: ' num2str(id)])
    return
    
%     %% Construct all frames of accumulation of object info
% 
%     vidMat=zeros(500,500,size(pcts,1));
%     for i=1:size(pcts,1) %For each row
%         thesePcts=pcts(i,:);
%         this=zeros(500,500,1);
%         for ii=1:12 %For each pad
%             if thesePcts(ii)>10 %If this pad is touched
%                 angle=max(min(round(randn(1,1)*10),15),-15);    %Choose random angle, bound between +/- 15
%                 xshift=max(min(round(randn(1,1)*10),15),-15);   %Choose random xshift, bound between +/- 15
%                 yshift=max(min(round(randn(1,1)*10),15),-15);   %Choose random yshift, bound between +/- 15
%                 
%                 this=this + jitterPad(filtered(:,:,ii).* thesePcts(ii),angle,xshift,yshift); %Add it to this frame
%             end
%         end
%             
%         vidMat(:,:,i)=this; %Add this frame to the pile
%         
%         if difference
%             thesePcts=pcts(i,:);
%             thesePcts = thesePcts(randperm(length(thesePcts)));
%             this=zeros(500,500,1);
%             for ii=1:12 %For each pad
%                 if thesePcts(ii)>10 %If this pad is touched
%                     angle=max(min(round(randn(1,1)*10),15),-15);    %Choose random angle, bound between +/- 15
%                     xshift=max(min(round(randn(1,1)*10),15),-15);   %Choose random xshift, bound between +/- 15
%                     yshift=max(min(round(randn(1,1)*10),15),-15);   %Choose random yshift, bound between +/- 15
%                     
%                     this=this + jitterPad(filtered(:,:,ii).* thesePcts(ii),angle,xshift,yshift); %Add it to this frame
%                 end
%             end
%             vidMat(:,:,i)=vidMat(:,:,i)-this; %Subtract this difference frame from the pile
%         end        
%     end
%     toc
%     clear started i this ii pcts f f2 angle xshift yshift filtered
    
%     save(['trial' trial '.mat'],'vidMat','-v7.3')

    %%
%     vidMatCum=sum(vidMat,3);


%     %% Save to db
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
%     
%     close(DataDB)
    
    
    
end











return

%% Calculate running sum
tic
vidMatCum=zeros(size(vidMat));
for i=2:size(vidMat,3)
    vidMatCum(:,:,i)=vidMatCum(:,:,i-1) + vidMat(:,:,i);
end
toc
clear vidMat i
%% Plot


figure; hold on; axis equal; colormap(gray); colorbar; axis tight


%Prep video
% v = VideoWriter(['vid' trial '.mp4'],'MPEG-4');
% v.Quality = 100;
% v.FrameRate = 50;
% open(v);

tic
for i=1:size(vidMatCum,3)
    
    cla
    imagesc(vidMatCum(:,:,i))
    
    drawnow
end
toc

%     if started
%         ave=sum(vidMat,3);
%         imagesc(ave)
%         writeVideo(v,getframe(gca)); %Write frame to video
%         drawnow
%     end
%     disp(num2str(i))
% close(v)