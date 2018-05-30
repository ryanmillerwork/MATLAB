clear all

difference=0; %Determine whether to calculate difference between actual and expected based on random permutation

padfiltersigma=1; %min 1, 5 is pretty bad
padAngleJitter=0; %30 is pretty bad, set to zero to save time
padXYJitter=0; %5 is pretty bad, 3 is workable
matrixWidth=50;


%% find trials to analyze
DataDB = sqlite('C:\Users\Ryan\Documents\Data\graspHuman.db');
wherestring='ExcludeSubject = 0 AND Congruent = 1 AND RespClass = "hit" AND ExcludeTrialGrasp = 0 AND Target != 2';
trials=double(cell2mat(fetch(DataDB, ['Select UniqueTrial FROM trialsTable WHERE ' wherestring])));

tic
vecMat=[];
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
    
    %% Construct all frames of accumulation of object info

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
        
        if difference
            thesePcts=pcts(i,:);
            thesePcts = thesePcts(randperm(length(thesePcts)));
            this=zeros(matrixWidth,matrixWidth,1);
            for ii=1:12 %For each pad
                if thesePcts(ii)>10 %If this pad is touched
                    angle=max(min(round(randn(1,1)*padAngleJitter),15),-15);    %Choose random angle, bound between +/- 15
                    xshift=max(min(round(randn(1,1)*padXYJitter),15),-15);   %Choose random xshift, bound between +/- 15
                    yshift=max(min(round(randn(1,1)*padXYJitter),15),-15);   %Choose random yshift, bound between +/- 15
                    
                    this=this + jitterPad(filtered(:,:,ii).* thesePcts(ii),angle,xshift,yshift); %Add it to this frame
                end
            end
            vidMat(:,:,i)=vidMat(:,:,i)-this; %Subtract this difference frame from the pile
        end        
    end
    toc
    clear started i this ii pcts f f2 angle xshift yshift filtered
    vidMatCum=sum(vidMat,3);
    vmcvec=vidMatCum(:)';
    vecMat=[vecMat; vmcvec];
%     save(['trial' trial '.mat'],'vidMatCum','-v7.3')

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