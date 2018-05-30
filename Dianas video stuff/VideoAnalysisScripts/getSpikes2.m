
function getSpikes2(filename,data2,list,options)
fileStore=char(filename);
tic

% data2=combineDG;


rasterDur=2000; %Length of rasters in milliseconds

latency=50; %Presumed latency in visual response
mspf=40; %milliseconds per frame (25 Hz video)
wait=options.wait; %milliseconds to wait because of initial burst response
ppd=59; %Pixels per degree

%List of channel/sorts to look at
% list=[
%     4 1;
%     5 1;
%     6 1;
%     9 1;
%     10 1;
%     11 1;
%     12 1;
%     13 1;
%     15 0;
%     16 1;
%     17 1;
%     18 1;
%     18 2;
% %     19 1;
% %     21 1;
%     25 1;
%     26 1;
%     27 1;
%     28 1;
%     32 1
%     ];

% parpool(4)

for listI=1:size(list,1) %For each neuron in the list
    chanID=list(listI,1);
    sortID=list(listI,2);
    
   
    savestring=[fileStore(1:end-4) 'chan' num2str(chanID) 'sort' num2str(sortID) 'wait' num2str(options.wait) 'color' num2str(options.analyzeColor) 'gray' num2str(options.analyzeGrayscale) options.filterSelection];
    
    current = pwd;
%     basePath = 'C:/Users/Ryan/Documents/Matlab/MatlabData/PlanetEarthBlocks';
    cd(options.saveDirectory);
    currentFiles= dir('*.png');
    cd(current);
    
    %Make sure this one hasn't been done before.
    skip=0;
    for i=1:size(currentFiles,1)
       if strcmp(currentFiles(i,1).name(1:end-4),savestring)
           skip=1;
       end
    end
    if skip
        disp(['Skipping: ' savestring])
        continue;
    end
       
%     figure;
    
    
    
    %Second, get spikes into a more convenient format, times adjusted to stimOn=0
    stimOrder=data2.stim_clipname;
    counter=0;
    for i=1:size(stimOrder,1) %For each trial, grab spike times and spike codes
        
        %If we're not supposed to analyze grayscale and this is grayscale, skip
        if options.analyzeGrayscale == 0 && data2.stim_grayscale(i) == 1
            continue;
        end
        %If we're not supposed to analyze color and this is color, skip
        if options.analyzeColor == 0 && data2.stim_grayscale(i) == 0
            continue;
        end
        
        counter = counter+1;
        sorts=data2.TDT_spike_codes{i,1}{chanID,1};
        times=data2.TDT_spike_times{i,1}{chanID,1};
        
        stimStart=data2.stimon(i);
        fixX=data2.fixStartX(i); %Fixation x in degrees
        fixY=data2.fixStartY(i); %Fixation y in degrees
        screenWidth=data2.stim_xscales(i); %screen width in degrees
        screenHeight=data2.stim_yscales(i); %screen height in degrees
        
        fpx=round(1920/2 + fixX*(1920/screenWidth));
        fpy=round(1080/2 - fixY*(1080/screenHeight));
        
        
        trial(counter,1).stim=stimOrder(i,:);
        trial(counter,1).spikes=times(sorts==sortID)-stimStart;
        trial(counter,1).fixX=fpx; %x pixel location of fixation (from top left)
        trial(counter,1).fixY=fpy; %y pixel location of fixation (from top left)
        trial(counter,1).datecode=data2.datecode(i);
        trial(counter,1).block=data2.file(i);
        %         trial(counter,1).stimName=[deblank(trial(counter,1).stim) num2str(trial(counter,1).fixX) num2str(trial(counter,1).fixY)];
        %         trial(i,1).gray=data2.stim_grayscale(i);
    end
    clear sorts times stimOrder
    
    if ~exist('trial')
        continue;
    end
    
    %Go through whole list and make a unique ID that is constant across all blocks on all days for each video stimulus
    strings=cellfun(@char,{trial.stim},'unif',0)';
    uniqueStrings=unique(strings);
    for iii=1:size(strings,1)
        loges=strfind(uniqueStrings,strings{iii});
        location=find(~cellfun(@isempty,loges));
        trial(iii,1).stimID=location;
    end
    
    clear strings uniqueStrings loges location
    
    %Add a column to trial which shows unique id for that block/day combination
    dates=cell2mat(cellfun(@double,{trial.datecode},'unif',0)');
    blocks=cell2mat(cellfun(@double,{trial.block},'unif',0)');
    
    combos=[dates blocks];
    uniqueCombos=unique(combos,'rows');
    
    for iii=1:size(combos)
        trial(iii,1).blockID=find(ismember(uniqueCombos,combos(iii,:),'rows')');
    end
    
    %Calculate firing rate on every block within the relevant time window and store to rateList
    rateList=nan(size(trial,1),2);
    for iii=1:size(trial,1)
        thisBlock=trial(iii,1).blockID;     %Grab block ID for this trial
        theseSpikes=trial(iii,1).spikes;    %Grab spikes for this trial
        if isempty(theseSpikes)             %Make sure there are some spikes
            rate=0;
        else
            theseSpikes=theseSpikes(theseSpikes>wait & theseSpikes < rasterDur);    %Remove spikes that aren't in the relevant window
            rate=length(theseSpikes)/(rasterDur-wait)*1000;                         %Firing rate for this trial within prescribed window
        end
        rateList(iii,:)=[thisBlock rate];
    end
    
    %Average firing rate across all trials for this block
    blockRateList=[];
    for iii=unique(rateList(:,1))' %For each unique block
        allRates=rateList(rateList(:,1)==iii,2); %grab all rates for this block
        blockRateList=[blockRateList; iii mean(allRates)];
    end
    
    %Add column to trial that shows baseline firing rate for this neuron for this block
    for iii=1:size(trial,1)
        trial(iii,1).baseline=blockRateList(blockRateList(:,1)==trial(iii,1).blockID,2);
    end
    
    
    
    % Go through each unique block and count up total spikes within relevant time window (wait:rasterDur)
    
    
    
    
    
    %     return
    toc
    
    %% Fourth, reformat responses into rasters for each unique stimulus
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
    scrambled=rasters;
    scrambled2=rasters;
    scrambled3=rasters;
    
    %Fill the raster with spikes
    for i=1:size(trial,1)
        theseSpikes=round(trial(i,1).spikes);  %Spikes for this trial
        theseSpikes=theseSpikes(theseSpikes>0 & theseSpikes<=rasterDur);
        thisLayer=c(i);                 %Layer of raster for this condition
        thisRow=sum(c(1:i-1)==c(i))+1;    %Row of raster for this trial
        
        rasters(thisRow,theseSpikes,thisLayer)=1;
        
        
        thisBaseline=trial(i,1).baseline;
        
        %         theseSpikes=
        
        scrambled(thisRow,:,thisLayer)=rand(1,size(scrambled,2))<(thisBaseline/1000);
        scrambled2(thisRow,:,thisLayer)=rand(1,size(scrambled,2))<(thisBaseline/1000);
        scrambled3(thisRow,:,thisLayer)=rand(1,size(scrambled,2))<(thisBaseline/1000);
        
    end
    
    clear theseSpikes thisLayer thisRow
    %     return
    
    %Plotting
    % for i=1:size(rasters,3)
    %     this=rasters(:,:,i);
    %     [y, x]=find(this);
    %     figure; hold on;
    %     plot(x,y,'.')
    %     title([trial(b(i),1).stim num2str(uniqueConds(i,:))])
    % end
    
    
    %% Fifth, go through the rasters, load the video file, store frames where there was a spike(s)
    
    pile=uint32(zeros(2160,3840,1));
    
%     figure;
    
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
        
        pile=calcPile(pile, wait, mspf, latency, rasterDur, rasters, i, v, yRange, xRange);
        subplot(3,1,1);
        cla
        imagesc(pile)
        drawnow
        %         return
        
    end
    
%     pile = imgaussfilt(pile,ppd);
    
%         imagesc(pile)
%         drawnow

    %Plot some helpers
    hold on;
    title(savestring)
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
    
    
    %Fifth, calculate three reference images
    pileR1=uint32(zeros(2160,3840,1));
    pileR2=uint32(zeros(2160,3840,1));
%     pileR3=uint32(zeros(2160,3840,1));
    
    
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
        
        %         %Scramble spike times (Switched to doing this above)
        %         subRasters=rasters(:,wait:end,:); %Only grab the time that we're actually going to analyze
        %
        %         ind=find(subRasters); %Find indices of spikes
        %         newInds=randperm(max(ind),length(ind)); %Create new index of spikes randomly placed
        %         newInds2=randperm(max(ind),length(ind)); %Create new index of spikes randomly placed
        %         newInds3=randperm(max(ind),length(ind)); %Create new index of spikes randomly placed
        %         scrambled=zeros(size(subRasters)); %Create array of zeros to hold scrambled spikes
        %         scrambled2=scrambled;
        %         scrambled3=scrambled;
        %         scrambled(newInds)=1; %Place scrambled spikes
        %         scrambled2(newInds2)=1; %Place scrambled spikes
        %         scrambled3(newInds3)=1; %Place scrambled spikes
        
        %         rastersS=rasters; %First set the scrambled one to the un-scrambled, then add scrambled to relevant window
        
        %Add frames to pile for three references
        %         rastersS(:,wait:end,:)=scrambled;
        pileR1=calcPile(pileR1, wait, mspf, latency, rasterDur, scrambled, i, v, yRange, xRange);
        
        %         rastersS(:,wait:end,:)=scrambled2;
        pileR2=calcPile(pileR2, wait, mspf, latency, rasterDur, scrambled2, i, v, yRange, xRange);
        
        %         rastersS(:,wait:end,:)=scrambled3;
%         pileR3=calcPile(pileR3, wait, mspf, latency, rasterDur, scrambled3, i, v, yRange, xRange);
        
        %take average of reference piles
        %         refpile=mean([pileR1 pileR2 pileR3])
        subplot(3,1,2);
        cla
        imagesc(pileR1)
        drawnow
        
    end
    
%     pileR1 = imgaussfilt(pileR1,ppd);
%     pileR2 = imgaussfilt(pileR2,ppd);
%     pileR3 = imgaussfilt(pileR3,ppd);

    
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
    
    
    
    
    d1=double(pileR1)-double(pileR2);
%     d2=double(pileR1)-double(pileR3);
%     d3=double(pileR2)-double(pileR3);
    
    
    
    %     imagesc(d1)
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
    
    %     colorbar
    
    
    
    %Plot result
    subplot(3,1,3); hold on;
    cla
    
    aveRefPile=mean(cat(3,double(pileR1),double(pileR2)),3);
    difference=double(pile)-aveRefPile;
    difference=difference/max(max(abs(d1)));
    %     difference=difference./max(max(difference));
    %     difference=difference./counter;
    
    
    low=min(min(difference));
    high=max(max(difference));
    difference(1,1)=max(abs([low high]));
    difference(end,1)=max(abs([low high]))*-1;
    
    imagesc(flipud(difference))
    
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
    
%     savestring=[filename 'chan' num2str(chanID) 'sort' num2str(sortID)]
    
    %If any of the piles are too big for 16 bit, scale them down and note that fact by adding '32bit'
    if max(max(pile))>65535 || max(max(pileR1))>65535 || max(max(pileR2))>65535
        savestring=[savestring '32bit'];
        pile=pile./65537;
        pileR1=pileR1./65537;
        pileR2=pileR2./65537;
%         pileR3=pileR3./65537;
    end   
    
    pile=uint16(pile);
    pileR1=uint16(pileR1);
    pileR2=uint16(pileR2);
%     pileR3=uint16(pileR3);
    
    p=cat(3,pile,pileR1,pileR2); %Put together into a single matrix that can be saved as rgb png
    
    
            
    
    fullfile=[options.saveDirectory savestring '.png']
    
    imwrite(p,fullfile)

    
    toc
    
end