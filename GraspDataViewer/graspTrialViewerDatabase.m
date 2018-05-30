function varargout = graspTrialViewerDatabase(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @graspTrialViewer_OpeningFcn, ...
                   'gui_OutputFcn',  @graspTrialViewer_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end


function graspTrialViewer_OpeningFcn(hObject, eventdata, handles, varargin)
clc
handles.output = hObject;
guidata(hObject, handles);
global gui plotFigure conn


plotFigure=gcf;

% Now create the other GUI with the controls
gui.fh = figure('units','pixels',...
    'position',[0 50 200 1000],...
    'menubar','none',...
    'name','Options',...
    'numbertitle','off',...
    'resize','off');

uicontrol('style','text',...
    'unit','pixel',...
    'position',[20 976 50 20],...
    'string',{'Species: '});
gui.speciespopup = uicontrol('style','popupmenu',...
    'unit','pixel',...
    'position',[80 980 100 20],...
    'string',{'Monkey', 'Human'},...
    'callback',{@speciespopup_Callback,hObject});

uicontrol('style','text',...
    'unit','pixel',...
    'position',[20 946 50 20],...
    'string',{'Subject: '});
gui.subjectpopup = uicontrol('style','popupmenu',...
    'unit','pixel',...
    'position',[80 950 100 20],...
    'string',{'abraham', 'human12'},...
    'callback',{@subjectpopup_Callback,hObject});

uicontrol('style','text',...
    'unit','pixel',...
    'position',[20 916 50 20],...
    'string',{'Date: '});
gui.datepopup = uicontrol('style','popupmenu',...
    'unit','pixel',...
    'position',[80 920 100 20],...
    'string',{'10-20-2020', '2'},...
    'callback',{@datepopup_Callback,hObject});

uicontrol('style','text',...
    'unit','pixel',...
    'position',[20 886 50 20],...
    'string',{'Block: '});
gui.blockpopup = uicontrol('style','popupmenu',...
    'unit','pixel',...
    'position',[80 890 100 20],...
    'string',{'100', '2'},...
    'callback',{@blockpopup_Callback,hObject});

uicontrol('style','text',...
    'unit','pixel',...
    'position',[20 856 50 20],...
    'string',{'Trial: '});
gui.triallist = uicontrol('style','listbox',...
    'unit','pixel',...
    'position',[80 150 100 730],...
    'string',{'1', '2'},...
    'callback',{@play_cb,hObject});

uicontrol('style','text',...
    'unit','pixel',...
    'position',[10 116 70 20],...
    'string',{'Playback rate: '});
gui.playbackratepopup = uicontrol('style','popupmenu',...
    'unit','pixel',...
    'position',[80 120 100 20],...
    'string',{'0.1', '0.2', '0.5', '1', '1.5'},...
    'value',3,...
    'callback',{@play_cb,hObject});

uicontrol('style','pushbutton',...
    'unit','pixel',...
    'position',[40 80 120 30],...
    'string',{'Play'},...
    'callback',{@play_cb,hObject});

uicontrol('style','pushbutton',...
    'unit','pixel',...
    'position',[40 40 120 30],...
    'string',{'Save'},...
    'callback',{@save_cb,hObject});


speciespopup_Callback
             
function varargout = graspTrialViewer_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function figure1_DeleteFcn(hObject, eventdata, handles)
global gui
try
    close(gui.fh);
catch
end

function axesScreen_CreateFcn(hObject, eventdata, handles)
global plotax
plotax.screen = hObject;
axis equal
xlim([-16 16])
ylim([-9 9])
hold(hObject,'on')


function axesLeft_CreateFcn(hObject, eventdata, handles)
global plotax
plotax.left = hObject;
axis equal
xlim([-12.8 12.8])
hold(hObject,'on')

function axesRight_CreateFcn(hObject, eventdata, handles)
global plotax
plotax.right = hObject;
axis equal
xlim([-12.8 12.8])
hold(hObject,'on')

function playbackRateText_CreateFcn(hObject, eventdata, handles)
global plotax
plotax.playbackRateText = hObject;

function trialInfo_CreateFcn(hObject, eventdata, handles)
global plotax
plotax.trialInfo = hObject;

function speciespopup_Callback(varargin)
global gui conn
species=get(gui.speciespopup,'String');
species=species{get(gui.speciespopup,'Value')};
% evalc('conn = mksqlite(0,''open'', [''C:\Users\Ryan\Documents\Data\grasp'' species ''.db''])'); %will create if it doesn't exist, evalc to suppress annoying version info being printed
conn = sqlite(['C:\Users\Ryan\Documents\Data\grasp' species '.db']);

%Get subjects
subjects=unique(fetch(conn,'SELECT Subject FROM trialsTable'));
set(gui.subjectpopup,'String',subjects)
set(gui.subjectpopup,'Value',1)
subjectpopup_Callback(1)
    
    


function subjectpopup_Callback(varargin)
global gui conn
subjects=get(gui.subjectpopup,'String');
subject=subjects{get(gui.subjectpopup,'Value')};

dates={unique(num2str(cell2mat(fetch(conn,['SELECT Date FROM trialsTable WHERE Subject = "' subject '"']))),'rows')};

set(gui.datepopup,'String',dates)
set(gui.datepopup,'Value',1)

datepopup_Callback(1)

function datepopup_Callback(varargin)
global gui conn
subjects=get(gui.subjectpopup,'String');
subject=subjects{get(gui.subjectpopup,'Value')};

dates=get(gui.datepopup,'String');
date=dates{get(gui.datepopup,'Value')};

blocks={unique(num2str(cell2mat(fetch(conn,['SELECT Block FROM trialsTable WHERE Subject = "' subject '" AND Date = "' date '"']))),'rows')};
set(gui.blockpopup,'String',blocks)
set(gui.blockpopup,'Value',1)

blockpopup_Callback(1)


function blockpopup_Callback(varargin)
global gui conn
%Find selections
subjects=get(gui.subjectpopup,'String');
subject=subjects{get(gui.subjectpopup,'Value')};

dates=get(gui.datepopup,'String');
date=dates{get(gui.datepopup,'Value')};

blocks=get(gui.blockpopup,'String');
block=str2double(blocks{get(gui.blockpopup,'Value')});

%find trials for this block
trials=cell2mat(fetch(conn,['SELECT Trial FROM trialsTable WHERE Subject = "' subject '" AND Date = "' date '" AND Block = "' num2str(block) '"']));

set(gui.triallist,'String',{trials})
set(gui.triallist,'Value',1)

function frameSlider_Callback(hObject, eventdata, handles)
global plotax options sampleTiming
plotax.sliderVal=get(hObject,'Value');

% set(plotax.playbackRateText,'String',{[num2str(options.playbackrate) 'x']; [num2str(ceil(plotax.sliderVal)) ' ms']})       %Playback rate and current time
set(plotax.playbackRateText,'String',{[num2str(options.playbackrate) 'x']; [num2str(ceil(plotax.sliderVal)-(sampleTiming(1)+sampleTiming(2))) ' ms']})       %Playback rate and current time

updatePlot(plotax.sliderVal)

function frameSlider_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
global plotax
plotax.slider=hObject;


function [] = play_cb(varargin) 
global plotax options conn fixTiming sampleTiming eyerate eyePos gTimesL gTimesR leftGraspVals rightGraspVals buttonTiming pupil eyePosSac eyePosBlink padMat

%Get data from database
options=getOptionsFromGUI;         
options.trialID=num2str(cell2mat(fetch(conn,['SELECT UniqueTrial FROM trialsTable WHERE Subject = "' options.subject '" AND Date = "' options.date '" AND Block = "' options.block '" AND Trial = "' options.trial '"'])));
sampleShape=fetch(conn,['SELECT SampleID, SamplePosition, SampleScale, SampleRotation FROM trialsTable WHERE UniqueTrial = "' options.trialID '"']);
try choice1Shape=fetch(conn,['SELECT Choice1ID, Choice1Position, Choice1Scale, Choice1Rotation FROM trialsTable WHERE UniqueTrial = "' options.trialID '"']); catch; choice1Shape=nan; end
try choice2Shape=fetch(conn,['SELECT Choice2ID, Choice2Position, Choice2Scale, Choice2Rotation FROM trialsTable WHERE UniqueTrial = "' options.trialID '"']); catch; choice2Shape=nan; end
eyerate=double(cell2mat(fetch(conn,['SELECT Rate FROM eyeTable' options.trialID ' WHERE RATE IS NOT NULL']))); %sampling rate
eyePos=double(cell2mat(fetch(conn,['SELECT X, Y FROM eyeTable' options.trialID ' WHERE X IS NOT NULL']))); %sampling rate
eyePosSac=double(cell2mat(fetch(conn,['SELECT Saccade FROM eyeTable' options.trialID ' WHERE X IS NOT NULL']))); %sampling rate
eyePosBlink=double(cell2mat(fetch(conn,['SELECT Blink FROM eyeTable' options.trialID ' WHERE X IS NOT NULL']))); %sampling rate
pupil=double(cell2mat(fetch(conn,['SELECT Pupil FROM eyeTable' options.trialID ' WHERE X IS NOT NULL']))); %sampling rate
fixTiming=double(cell2mat(fetch(conn,['SELECT FixOn, FixOff FROM trialsTable WHERE UniqueTrial = "' options.trialID '"'])));
sampleTiming=double(cell2mat(fetch(conn,['SELECT TargetOn, SampleAvailOn, SampleAvailOff FROM trialsTable WHERE UniqueTrial = "' options.trialID '"'])));
buttonTiming=double(cell2mat(fetch(conn,['SELECT Response, ResponseTime FROM trialsTable WHERE UniqueTrial = "' options.trialID '"'])));
trialDur=cell2mat(fetch(conn,['SELECT ResponseTime FROM trialsTable WHERE UniqueTrial = "' options.trialID '"'])); % time of button press in milliseconds
flip=cell2mat(fetch(conn,['SELECT Flip FROM trialsTable WHERE UniqueTrial = "' options.trialID '"'])); % whether vis stim is flipped L/R or not

%Get shape from database
conn2 = sqlite('L:\stimuli\grasp\objects.db');
sampleShapeAdjusted=adjustShape(conn2, sampleShape);
choice1ShapeAdjusted=adjustShape(conn2, choice1Shape);
choice2ShapeAdjusted=adjustShape(conn2, choice2Shape);
close(conn2);

%Flip sample shape if necessary
if flip
    sampleShapeAdjusted(:,1)=sampleShapeAdjusted(:,1) * -1;
end

plotax.padMeans=calcPadMeans(sampleShapeAdjusted); %Calculate mean x and y vals for each pad on screen

%Clear screens
cla(plotax.screen)
cla(plotax.left)
cla(plotax.right)

%Update text boxes on plot
set(plotax.trialInfo,'String',{['Subject: ' options.subject]; ['Date: ' options.date]; ['Block: ' num2str(str2double(options.block))]; ['Trial: ' num2str(str2double(options.trial))]})
set(plotax.playbackRateText,'String',[num2str(options.playbackrate) 'x'])

%Plot buttons
plotax.leftButton=plotHardware(plotax.left,0,'human');
plotax.rightButton=plotHardware(plotax.right,1,'human');

%Plot pads
[plotax.shape, plotax.sampleShapeHandles] = plotPads(plotax.screen,sampleShapeAdjusted);
set(plotax.shape,'Visible','off')
set(plotax.sampleShapeHandles,'Visible','off')

gTimesL=nan;
leftGraspVals=nan;
gTimesR=nan;
rightGraspVals=nan;
if iscell(choice1Shape)
    [~, plotax.choice1ShapeHandles] = plotPads(plotax.left,choice1ShapeAdjusted);
    gTimesL=cell2mat(fetch(conn,['SELECT Time_1 FROM graspTable' options.trialID ' WHERE TrialPeriod = 1.0']));
    leftGraspVals=double(cell2mat(fetch(conn,['SELECT pctPad1_1, pctPad1_2, pctPad1_3, pctPad1_4, pctPad1_5, pctPad1_6, pctPad1_7, pctPad1_8, pctPad1_9, pctPad1_10, pctPad1_11, pctPad1_12 FROM graspTable' options.trialID ' WHERE TrialPeriod = 1'])));
end
if iscell(choice2Shape)
    [~, plotax.choice2ShapeHandles] = plotPads(plotax.right,choice2ShapeAdjusted);
    gTimesR=cell2mat(fetch(conn,['SELECT Time_2 FROM graspTable' options.trialID ' WHERE TrialPeriod = 1']));
    rightGraspVals=double(cell2mat(fetch(conn,['SELECT pctPad2_1, pctPad2_2, pctPad2_3, pctPad2_4, pctPad2_5, pctPad2_6, pctPad2_7, pctPad2_8, pctPad2_9, pctPad2_10, pctPad2_11, pctPad2_12 FROM graspTable' options.trialID ' WHERE TrialPeriod = 1'])));
end

%Plot fixation and turn off for now
plotax.fixation = plot(plotax.screen,0,0,'.w','MarkerSize',20);
set(plotax.fixation,'Visible','off')

%Plot 0,0 just as reference
plot(plotax.screen,0,0,'.')

%Set properties of slider bar
set(plotax.slider,'Max',trialDur+20)
set(plotax.slider,'Value',0)

%plot loop
elapsed = 0;
padMat=[];
tic;
while elapsed < (trialDur+100)
    elapsed = ceil(toc * 1000 * options.playbackrate);                                                                                                  %Current time, adjusting for the desired playback rate 
    set(plotax.playbackRateText,'String',{[num2str(options.playbackrate) 'x']; [num2str(ceil(elapsed)-(sampleTiming(1)+sampleTiming(2))) ' ms']})       %Playback rate and current time
    set(plotax.slider,'Value',min([trialDur elapsed]))                                                                                                  %Slider position
    updatePlot(elapsed) %Update 3 plots
end


function [] = save_cb(varargin) 
global plotFigure plotax options conn fixTiming sampleTiming eyerate eyePos gTimesL gTimesR leftGraspVals rightGraspVals buttonTiming padMat

%Get data from database
options=getOptionsFromGUI;         
options.trialID=num2str(cell2mat(fetch(conn,['SELECT UniqueTrial FROM trialsTable WHERE Subject = "' options.subject '" AND Date = "' options.date '" AND Block = "' options.block '" AND Trial = "' options.trial '"'])));
sampleShape=fetch(conn,['SELECT SampleID, SamplePosition, SampleScale, SampleRotation FROM trialsTable WHERE UniqueTrial = "' options.trialID '"']);
try choice1Shape=fetch(conn,['SELECT Choice1ID, Choice1Position, Choice1Scale, Choice1Rotation FROM trialsTable WHERE UniqueTrial = "' options.trialID '"']); catch; choice1Shape=nan; end
try choice2Shape=fetch(conn,['SELECT Choice2ID, Choice2Position, Choice2Scale, Choice2Rotation FROM trialsTable WHERE UniqueTrial = "' options.trialID '"']); catch; choice2Shape=nan; end
eyerate=double(cell2mat(fetch(conn,['SELECT Rate FROM eyeTable' options.trialID ' WHERE RATE IS NOT NULL']))); %sampling rate
eyePos=double(cell2mat(fetch(conn,['SELECT X, Y FROM eyeTable' options.trialID ' WHERE X IS NOT NULL']))); %sampling rate
fixTiming=double(cell2mat(fetch(conn,['SELECT FixOn, FixOff FROM trialsTable WHERE UniqueTrial = "' options.trialID '"'])));
sampleTiming=double(cell2mat(fetch(conn,['SELECT TargetOn, SampleAvailOn, SampleAvailOff FROM trialsTable WHERE UniqueTrial = "' options.trialID '"'])));
buttonTiming=double(cell2mat(fetch(conn,['SELECT Response, ResponseTime FROM trialsTable WHERE UniqueTrial = "' options.trialID '"'])));
trialDur=cell2mat(fetch(conn,['SELECT ResponseTime FROM trialsTable WHERE UniqueTrial = "' options.trialID '"'])); % time of button press in milliseconds

%Get shape from database
conn2 = sqlite('L:\stimuli\grasp\objects.db');
sampleShapeAdjusted=adjustShape(conn2, sampleShape);
choice1ShapeAdjusted=adjustShape(conn2, choice1Shape);
choice2ShapeAdjusted=adjustShape(conn2, choice2Shape);
close(conn2);

plotax.padMeans=calcPadMeans(sampleShapeAdjusted); %Calculate mean x and y vals for each pad on screen

%Clear screens
cla(plotax.screen)
cla(plotax.left)
cla(plotax.right)

%Update text boxes on plot
set(plotax.trialInfo,'String',{options.subject; options.date; ['Block ' num2str(str2double(options.block))]; ['Trial ' num2str(str2double(options.trial))]})
set(plotax.playbackRateText,'String',[num2str(options.playbackrate) 'x'])

%Plot buttons
plotax.leftButton=plotHardware(plotax.left,0,'human');
plotax.rightButton=plotHardware(plotax.right,1,'human');

%Plot pads
[plotax.shape, plotax.sampleShapeHandles] = plotPads(plotax.screen,sampleShapeAdjusted);
set(plotax.shape,'Visible','off')
set(plotax.sampleShapeHandles,'Visible','off')

gTimesL=nan;
leftGraspVals=nan;
gTimesR=nan;
rightGraspVals=nan;
if iscell(choice1Shape)
    [~, plotax.choice1ShapeHandles] = plotPads(plotax.left,choice1ShapeAdjusted);
    gTimesL=cell2mat(fetch(conn,['SELECT Time_1 FROM graspTable' options.trialID]));
    leftGraspVals=double(cell2mat(fetch(conn,['SELECT pctPad1_1, pctPad1_2, pctPad1_3, pctPad1_4, pctPad1_5, pctPad1_6, pctPad1_7, pctPad1_8, pctPad1_9, pctPad1_10, pctPad1_11, pctPad1_12 FROM graspTable' options.trialID ' WHERE TrialPeriod = 1'])));
end
if iscell(choice2Shape)
    [~, plotax.choice2ShapeHandles] = plotPads(plotax.right,choice2ShapeAdjusted);
    gTimesR=cell2mat(fetch(conn,['SELECT Time_2 FROM graspTable' options.trialID]));
    rightGraspVals=double(cell2mat(fetch(conn,['SELECT pctPad2_1, pctPad2_2, pctPad2_3, pctPad2_4, pctPad2_5, pctPad2_6, pctPad2_7, pctPad2_8, pctPad2_9, pctPad2_10, pctPad2_11, pctPad2_12 FROM graspTable' options.trialID ' WHERE TrialPeriod = 1'])));
end

%Plot fixation and turn off for now
plotax.fixation = plot(plotax.screen,0,0,'.w','MarkerSize',20);
set(plotax.fixation,'Visible','off')

%Plot 0,0 just as reference
plot(plotax.screen,0,0,'.')

%Set properties of slider bar
set(plotax.slider,'Max',trialDur+20)
set(plotax.slider,'Value',0)

% Set up video
v = VideoWriter('peaks7.mp4','MPEG-4');
v.Quality = 100;
v.FrameRate = 50;
open(v);

%plot loop
elapsed = 0;
tic;
padMat=[];
while elapsed < (trialDur + options.playbackrate * 1000 / v.FrameRate)
    set(plotax.playbackRateText,'String',{[num2str(options.playbackrate) 'x']; [num2str(ceil(elapsed)-(sampleTiming(1)+sampleTiming(2))) ' ms']})       %Playback rate and current time
    set(plotax.slider,'Value',min([trialDur elapsed]))                                                                                                  %Slider position
    updatePlot(elapsed) %Update 3 plots
    writeVideo(v,getframe(plotFigure)); %Write frame to video
    elapsed = elapsed + options.playbackrate * 1000 / v.FrameRate; %Update time by adding a constant
end
close(v)
disp(['Video written in ' num2str(toc) ' seconds'])


function updatePlot(elapsed)
global plotax scatter1 scatter2 scatter3 fixTiming sampleTiming eyerate eyePos gTimesL gTimesR leftGraspVals rightGraspVals buttonTiming eyePosSac eyePosBlink padMat
gtl = gTimesL;
gtr = gTimesR;
sampleOnTime=sampleTiming(1)+sampleTiming(2);
sampleOffTime=sampleTiming(1)+sampleTiming(3);

% --Fixation
if (elapsed >= fixTiming(1)) && (elapsed < fixTiming(2))
    set(plotax.fixation,'Visible','on')
else
    set(plotax.fixation,'Visible','off')
end

% --Vis stim and touch panels
if (elapsed >= sampleOnTime) && (elapsed < sampleOffTime)
    set(plotax.shape,'Visible','on')
    set(plotax.sampleShapeHandles,'Visible','on')
else
    set(plotax.shape,'Visible','off')
    set(plotax.sampleShapeHandles,'Visible','off')
end

% --Eyes
eyeSample=ceil(elapsed * eyerate/1000);
stimOnSample=ceil(fixTiming(2) * eyerate/1000);
if eyeSample <= length(eyePos(:,1))
    if exist('scatter1','var'); delete(scatter1); end
    if exist('scatter2','var'); delete(scatter2); end
    if exist('scatter3','var'); delete(scatter3); end
%     sacTimes=find(eyePosSac(1:eyeSample));      %row number for eye position samples when theyre saccading
%     blinkTimes=find(eyePosBlink(1:eyeSample));  %row number for eye position samples when theyre blinking
    
    if elapsed > fixTiming(2) %if the fixation is off, we only want to plot eye position from that time forward
        sacTimes=find(eyePosSac(stimOnSample:eyeSample));      %row number for eye position samples when theyre saccading
        blinkTimes=find(eyePosBlink(stimOnSample:eyeSample));  %row number for eye position samples when theyre blinking
        regx=eyePos(stimOnSample:eyeSample,1);
        regy=eyePos(stimOnSample:eyeSample,2);
    else
        sacTimes=find(eyePosSac(1:eyeSample));      %row number for eye position samples when theyre saccading
        blinkTimes=find(eyePosBlink(1:eyeSample));  %row number for eye position samples when theyre blinking
        regx=eyePos(1:eyeSample,1);
        regy=eyePos(1:eyeSample,2);
        
    end
    
%     regx=eyePos(1:eyeSample,1);
%     regy=eyePos(1:eyeSample,2);
    
    blinkx=regx(blinkTimes);
    blinky=regy(blinkTimes);
    
    sacx=regx(sacTimes);
    sacy=regy(sacTimes);
    

    
    regx(union(sacTimes,blinkTimes))=[];
    regy(union(sacTimes,blinkTimes))=[];    
    
    scatter1=scatter(plotax.screen,regx,regy,'MarkerFaceColor','k','MarkerFaceAlpha',0.12,'MarkerEdgeAlpha',0);
    scatter2=scatter(plotax.screen,blinkx,blinky,'MarkerFaceColor',[0 .3 .1],'MarkerFaceAlpha',0.2,'MarkerEdgeAlpha',0);
    scatter3=scatter(plotax.screen,sacx,sacy,'MarkerFaceColor',[0 .1 .4],'MarkerFaceAlpha',0.2,'MarkerEdgeAlpha',0);
end

% --Buttons
if elapsed > (buttonTiming(2) + 100000 * buttonTiming(1))
    set(plotax.leftButton,'visible','off')
else
    set(plotax.leftButton,'visible','on')
end

if elapsed > (buttonTiming(2) + 100000 * ~buttonTiming(1))
    set(plotax.rightButton,'visible','off')
else
    set(plotax.rightButton,'visible','on')
end

% --Pads
%Calculate distance between eyes and each pad and color pads appropriately
dists=nan(1,12);
if eyeSample > 0
    dists=calcDistanceToEachPad(eyePos(eyeSample,1),eyePos(eyeSample,2));
    for i=1:12
        dist=0.45 - min(dists(i)/10,0.45);
        set(plotax.sampleShapeHandles(i),'Color',[0.15+dist 0.35+dist 0.55+dist])
    end
end
%If there is a left haptic object and the trial isnt over, update colors
% graspVals=nan(1,12);
if isfield(plotax,'choice1ShapeHandles') && (gtl(end) > elapsed)
    %Find first sample set after current time
    gtl(gtl > elapsed) = -inf;
    [~, touchInd]=max(gtl);
    lgv=min(max(leftGraspVals(touchInd,:) / 200,0),0.44);
%     graspVals=lgv;
    for i=1:12
        set(plotax.choice1ShapeHandles(i),'Color',[0.15+lgv(i) 0.35+lgv(i) 0.55+lgv(i)])
    end    
end
%If there is a right haptic object and the trial isnt over, update colors
if isfield(plotax,'choice2ShapeHandles') && (gtr(end) > elapsed)
    gtr(gtr > elapsed) = -inf;
    [~, touchInd]=max(gtr);
    try
    rgv=min(max(rightGraspVals(touchInd,:) / 200,0),0.44);
%     graspVals=rgv;
    for i=1:12
        set(plotax.choice2ShapeHandles(i),'Color',[0.15+rgv(i) 0.35+rgv(i) 0.55+rgv(i)])
    end
    catch
    end
end



%-- add touch and look data to results matrix for correlation analysis

% if sum(graspVals>.15) && ~eyePosBlink(eyeSample) && ~eyePosSac(eyeSample)
%     padMat(end+1,:,1)=graspVals;
%     padMat(end,:,2)=dists;
% else
%     padMat(end+1,:,1)=nan(1,12);
%     padMat(end,:,2)=nan(1,12);
% end

drawnow

function [dists] = calcDistanceToEachPad(eyex,eyey)
global plotax
pms=plotax.padMeans;
dists=[];
for i=pms(:,1)'
    
    thisPadX=pms(pms(:,1)==i,2);
    thisPadY=pms(pms(:,1)==i,3);

    distance = sqrt( (thisPadX-eyex).^2 + (thisPadY-eyey).^2);
    dists=[dists; distance];
end
    
function options = getOptionsFromGUI()
global gui

subjects=get(gui.subjectpopup,'string');
options.subject=cell2mat(subjects(get(gui.subjectpopup,'val')));
dates=get(gui.datepopup,'string');
options.date=cell2mat(dates(get(gui.datepopup,'val')));
blocks=get(gui.blockpopup,'string');
options.block=cell2mat(blocks(get(gui.blockpopup,'val')));
trials=get(gui.triallist,'string');
options.trial=cell2mat(trials(get(gui.triallist,'val')));
playbacks=get(gui.playbackratepopup,'string');
options.playbackrate=double(string(playbacks(get(gui.playbackratepopup,'val'))));

function adjusted=adjustShape(conn,shapeInfo)
%make sure theres something here
if ~iscell(shapeInfo(1))
    adjusted=nan;
    return
end

%read in shape from db
shape=fetch(conn,['SELECT x, y, pad FROM shapeTable' num2str(shapeInfo{1})]);
scale=double(shapeInfo{3});
rotation=double(shapeInfo{4});

xs=double(cell2mat(shape(:,1)));
ys=double(cell2mat(shape(:,2)));

%Scale
if scale == 0
    scale=10;
end

xs=double(xs.*scale);
ys=double(ys.*scale);

%Rotate
[xs, ys]=rotatePoints(xs,ys,-deg2rad(rotation),0,0); %Rotated without slots

adjusted=[xs ys double(cell2mat(shape(:,3)))];

function means=calcPadMeans(shape)
means=[];
for i=1:max(shape(:,3))
   means = [means; i mean(shape(shape(:,3)==i,1)) mean(shape(shape(:,3)==i,2))];
end

function [shapeHandle, shapeHandles] = plotPads(ax,shape)
color=[0.2 0.4 0.6];
linewidth=5;

shapeHandle=fill(ax,shape(:,1),shape(:,2),'w');
shapeHandles=[];
for i=1:max(shape(:,3))
    xs=shape(shape(:,3)==i,1);
    ys=shape(shape(:,3)==i,2);
    
    shapeHandles=[shapeHandles; plot(ax,xs,ys,'color',color,'linewidth',linewidth)];    
end

function button=plotHardware(ax,side, animal)
%Plot circle for back of object
t = 0 : pi/30 : 2*pi;
x = cos(t)*5;
y = sin(t)*5;
fill(ax,x,y,[0.5 0.5 0.5])

%Plot response buttons
if (strcmp(animal,'human'))
    x = cos(t) * 2 - 8 + side * 16;
    y = sin(t) * 1.4 - 3;
    fill(ax,x,y-.3,[0.1 0.2 0.3])
    button=fill(ax,x,y,[0.2 0.4 0.6]);
else
    x = cos(t) * 2 + 8 - side * 16;
    y = sin(t) * 1.4 - 3;
    fill(ax,x,y-.3,[0.1 0.2 0.3])
    button=fill(ax,x,y,[0.2 0.4 0.6]);   
end


function [x_rotated, y_rotated]=rotatePoints(x,y,theta,x_center,y_center)
v = [x';y'];
center = repmat([x_center; y_center], 1, length(x)); %Matrix for centering
R = [cos(theta) -sin(theta); sin(theta) cos(theta)]; % define a counter-clockwise rotation matrix

s = v - center;     % shift points in the plane so that the center of rotation is at the origin
so = R*s;           % apply the rotation about the origin
vo = so + center;   % shift again so the origin goes back to the desired center of rotation

x_rotated = vo(1,:)';
y_rotated = vo(2,:)';
