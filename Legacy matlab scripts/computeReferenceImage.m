clearvars


%% user settings
%Inputs
basePath = 'C:\Users\Ryan\Documents\Matlab\MatlabData';
fname = 'y_atm_planetEarth_012517.dgz';
chan=25;
sort=1;

%Constants
lag=50; %Presumed lag in visual response
mspf=40; %milliseconds per frame (25 Hz video)
wait=400; %milliseconds to wait because of initial burst response

%%

%First, get data to matlab format
tic
data = dg_read(fullfile(basePath, fname));
data2 = rmfield(data,{'load_params' 'filename' 'version' 'ems_source' 'ems_kern' 'subj'});
subjid=str2double(data.subj(1,end));

clear data basePath fname
toc

%%
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
    trial(i,1).fixation=[fpx fpy]; %pixel location of fixation (from top left)
end
clear sorts times stimOrder

toc

%%

%Third, go trial by trial, load the video file, store frames where there was a spike
figure; 
pile=uint32(zeros(2160,3840,1));
counter=0;
completedList=[];
for i=1:size(trial,1) %For each trial of this neuron
    

%     if trial(i,1).fixation(1) ~= 960 || trial(i,1).fixation(1,2) ~= 540
%         continue;
%     end
    
    xRange=[1920-trial(i,1).fixation(1) 1920-trial(i,1).fixation(1)+1919];
    yRange=[1080-trial(i,1).fixation(2) 1080-trial(i,1).fixation(2)+1079];
    
    disp(['trial: ' num2str(i) ' x-fix position: ' num2str(trial(i,1).fixation(1))])
    
    thisVideo=deblank(trial(i,1).stim);
    file=['C:\Users\Ryan\Documents\MATLAB\Delta videos\' thisVideo 'delta.avi'];
    v=VideoReader(file);
    
    theseSpikes=trial(i,1).spikes;
%     theseSpikes=1:40:10000;
    theseSpikes=theseSpikes(theseSpikes>wait & theseSpikes<2050);
    for ii=1:length(theseSpikes) %For each spike
        counter=counter+1;
        spike=theseSpikes(ii);
        frameTime=(spike-lag-mspf)/1000;
        v.CurrentTime = max([frameTime 0]); %If its less than zero, switch it to zero
        video = uint32(readFrame(v)); %Read next frame after currentTime
        video = video(:,:,1); %All channels are the same
        
        pile(yRange(1):yRange(2),xRange(1):xRange(2))=pile(yRange(1):yRange(2),xRange(1):xRange(2))+video;
        image(pile./counter)
        drawnow

    end
    
end
hold on
plot(1920,1080,'.y')
toc
