clearvars

basePath = 'C:\Users\Ryan\Documents\Matlab\MatlabData';
fname = 'y_atm_planetEarth_012517.dgz';
%First, get data to matlab format
tic
data = dg_read(fullfile(basePath, fname));
data2 = rmfield(data,{'load_params' 'filename' 'version' 'ems_source' 'ems_kern' 'subj'});
subjid=str2double(data.subj(1,end));

clear data basePath fname
toc

%List of channel/sorts to look at
list=[4 1;
    5 1;
    6 1;
    9 1;
    10 1;
    11 1;
    12 1;
    13 1;
    15 0;
    16 1;
    17 1;
    18 1;
    18 2;
    19 1;
    21 1;
    25 1;
    26 1;
    27 1;
    28 1;
    32 1];

for listI=1:size(list,1)
    chan=list(listI,1);
    sort=list(listI,2);
    rasterDur=2000; %Length of rasters in milliseconds
    
    lag=50; %Presumed lag in visual response
    mspf=40; %milliseconds per frame (25 Hz video)
    wait=400; %milliseconds to wait because of initial burst response
    
    
    %Second, get spikes into a more convenient format, times adjusted to stimOn=0
    stimOrder=data2.stim_clipname;
    for i=1:size(stimOrder,1) %For each trial, grab spike times and spike codes
        sorts=data2.TDT_spike_codes{i,1}{chan,1};
        times=data2.TDT_spike_times{i,1}{chan,1};
        
        stimStart=data2.stimon(i);
        fixX=data2.fixStartX(i); %Fixation x in degrees
        fixY=data2.fixStartY(i); %Fixation y in degrees
        screenWidth=data2.stim_xscales(i); %screen width in degrees
        screenHeight=data2.stim_yscales(i); %screen height in degrees
        
        fpx=round(1920/2 + fixX*(1920/screenWidth));
        fpy=round(1080/2 + fixY*(1080/screenHeight));
        
        
        trial(i,1).stim=stimOrder(i,:);
        trial(i,1).spikes=times(sorts==sort)-stimStart;
        trial(i,1).fixX=fpx; %x pixel location of fixation (from top left)
        trial(i,1).fixY=fpy; %y pixel location of fixation (from top left)
        trial(i,1).stimID=data2.stim_ids(i);
    end
    clear sorts times stimOrder
    
    toc
    
    %Fourth, reformat responses into rasters for each unique stimulus
    %make list of trial types, accounting for both stimulus id and fixation position
    stims=[trial(:,1).stimID]';
    fixX=[trial(:,1).fixX]';
    fixY=[trial(:,1).fixY]';
    
    allConds=[stims fixX fixY];
    [uniqueConds, b, c]=unique(allConds,'rows');
    %Find maximum number of iterations of each condition
    maxTrials=0;
    for i=1:length(c)
        trials=sum(c==c(i));
        if trials>maxTrials
            maxTrials=trials;
        end
    end
    
    clear stims fixX fixY trials
    
    %Initialize rasters which will hold all spikes
    rasters=zeros(maxTrials,rasterDur,size(uniqueConds,1));
    
    %Fill the raster with spikes
    for i=1:size(trial,1)
        theseSpikes=round(trial(i,1).spikes);  %Spikes for this trial
        theseSpikes=theseSpikes(theseSpikes>0 & theseSpikes<=rasterDur);
        thisLayer=c(i);                 %Layer of raster for this condition
        thisRow=sum(c(1:i-1)==c(i))+1;    %Row of raster for this trial
        
        rasters(thisRow,theseSpikes,thisLayer)=1;
        
    end
    
    clear theseSpikes thisLayer thisRow
    
    %Plotting
    % for i=1:size(rasters,3)
    %     this=rasters(:,:,i);
    %     [y, x]=find(this);
    %     figure; hold on;
    %     plot(x,y,'.')
    %     title([trial(b(i),1).stim num2str(uniqueConds(i,:))])
    % end
    
    
    %Fourth, go through the rasters, load the video file, store frames where there was a spike(s)
    
    pile=uint16(zeros(2160,3840,1));

    figure;
    subplot(3,1,1);
    for i=1:size(rasters,3) %For each layer of the raster (stimulus)
        disp(['Layer ' num2str(i)])
        
        %Prep video
        thisVideo=deblank(trial(b(i),1).stim);
        file=['C:\Users\Ryan\Documents\MATLAB\Delta videos\' thisVideo 'delta.avi'];
        v=VideoReader(file);
        
        %Prep location on screen
        fixX=trial(b(i),1).fixX;
        fixY=trial(b(i),1).fixY;
        xRange=[1920 - fixX 1920 - fixX + 1919];
        yRange=[1080 - fixY 1080 - fixY + 1079];
        
        %% temp for identifying image that occurs randomly
%         subRasters=rasters(:,wait:end,:); %Only grab the time that we're actually going to analyze
%         
%         ind=find(subRasters); %Find indices of spikes
%         newInds=randperm(max(ind),length(ind)); %Create new index of spikes randomly placed
%         scrambled=zeros(size(subRasters)); %Create array of zeros to hold scrambled spikes
%         scrambled(newInds)=1; %Place scrambled spikes
%         
%         rastersS=rasters;
%         rastersS(:,wait:end,:)=scrambled;
%         rasters=rastersS;
        
        %% end temp
        
        pile=calcPile(wait, mspf, rasterDur, rasters, i, v, yRange, xRange);
        
        imagesc(pile)
        drawnow
        
    end
    
    %Plot some helpers
    hold on;
    title(['Chan: ' num2str(chan) ', Sort: ' num2str(sort)])
    plot(1920,1080,'.y')
    
    x=1920;
    y=1080;
    r=1920/screenWidth*10;
    
    ang=0:0.01:2*pi;
    xp=r*cos(ang);
    yp=r*sin(ang);
    plot(x+xp,y+yp,'y:');
    
    
    %Fifth, calculate a reference image
    refpile=uint16(zeros(2160,3840,1));

    subplot(3,1,2);
    for i=1:size(rasters,3) %For each layer of the raster (stimulus)
        disp(['Layer ' num2str(i)])
        
        %Prep video
        thisVideo=deblank(trial(b(i),1).stim);
        file=['C:\Users\Ryan\Documents\MATLAB\Delta videos\' thisVideo 'delta.avi'];
        v=VideoReader(file);
        
        %Prep location on screen
        fixX=trial(b(i),1).fixX;
        fixY=trial(b(i),1).fixY;
        xRange=[1920 - fixX 1920 - fixX + 1919];
        yRange=[1080 - fixY 1080 - fixY + 1079];
        
        %Scramble spike times
        subRasters=rasters(:,wait:end,:); %Only grab the time that we're actually going to analyze
        
        ind=find(subRasters); %Find indices of spikes
        newInds=randperm(max(ind),length(ind)); %Create new index of spikes randomly placed
        scrambled=zeros(size(subRasters)); %Create array of zeros to hold scrambled spikes
        scrambled(newInds)=1; %Place scrambled spikes
        
        rastersS=rasters;
        rastersS(:,wait:end,:)=scrambled;
        
        %Step through each column of this raster, count spikes, and add to pile
        for ii=wait:mspf:rasterDur-mspf
            startTime=ii;
            stopTime=ii+mspf-1;
            sp=sum(sum(rastersS(:,startTime:stopTime,i)));
            if sp>0 %If there is at least one spike during this frame (time adjusted)

                
                v.CurrentTime=(ii-mspf-lag)/1000; %Move to start of appropriate frame
                video = uint16(readFrame(v)); %Read next frame after currentTime
                video = video(:,:,1); %All channels are the same
                video = video .* sp;  %Multiply by the number of spikes in this frames time window
                
                refpile(yRange(1):yRange(2),xRange(1):xRange(2))=refpile(yRange(1):yRange(2),xRange(1):xRange(2))+video;
                
            end
            
        end
        
        imagesc(refpile)
        drawnow
        
    end
    
    %Plot some helpers
    hold on
    plot(1920,1080,'.y')
    
    x=1920;
    y=1080;
    r=1920/screenWidth*10;
    
    ang=0:0.01:2*pi;
    xp=r*cos(ang);
    yp=r*sin(ang);
    plot(x+xp,y+yp,'y:');
    
    %% Compute difference
    subplot(3,1,3); hold on;
    
    difference=double(pile)-double(refpile);
%     difference=difference./max(max(difference));
%     difference=difference./counter;

    
    low=min(min(difference));
    high=max(max(difference));
    difference(1,1)=max(abs([low high]));
    difference(end,1)=max(abs([low high]))*-1;
    
	imagesc(difference)
    
    plot(1920,1080,'.y')
    
    x=1920;
    y=1080;
    r=1920/screenWidth*10;
    
    ang=0:0.01:2*pi;
    xp=r*cos(ang);
    yp=r*sin(ang);
    plot(x+xp,y+yp,'y:');
    
    r=1920/screenWidth*20;
    
    ang=0:0.01:2*pi;
    xp=r*cos(ang);
    yp=r*sin(ang);
    plot(x+xp,y+yp,'y:');
    
    xlim([1 size(pile,2)])
    ylim([1 size(pile,1)])
    
    colorbar
    
    %%
    
    
    toc
end