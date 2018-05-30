function varargout = graspTrialViewer(varargin)
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
global gui plotFigure

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

%Get subjects
subjects=getSubjects;
set(gui.subjectpopup,'String',subjects)
set(gui.subjectpopup,'Value',1)
subjectpopup_Callback(1)

             
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

function subjectpopup_Callback(varargin)
global gui
subjects=get(gui.subjectpopup,'String');
subject=subjects{get(gui.subjectpopup,'Value')};

dates={};
files=dir('C:\Users\Ryan\Documents\Data\DGZs\Monkey\*.dgz');
for i=1:size(files,1)
    file=files(i,1).name;
    parts=strsplit(file,'_');
%     if subject(1)=='a' %monkeys
%         dates{i}='asdf';
%     elseif strcmp(parts{1},subject)
        date=parts{end};
        dates{i}=date(1:end-4);
%     end
end
dates=dates(~cellfun('isempty',dates));
dates=unique(dates);

set(gui.datepopup,'String',dates)
set(gui.datepopup,'Value',1)

datepopup_Callback(1)

function datepopup_Callback(varargin)
%figure out selected file to load
global gui d
subjects=get(gui.subjectpopup,'String');
subject=subjects{get(gui.subjectpopup,'Value')};

dates=get(gui.datepopup,'String');
date=dates{get(gui.datepopup,'Value')};

%read in chosen file
file=dir(['C:\Users\Ryan\Documents\Data\DGZs\Monkey\' subject '*' date '.dgz']);
loadFile(file(1,1).name);

%find blocks in this data file and save it to the popup 
blocks={unique(d.blocks)};
set(gui.blockpopup,'String',blocks)
set(gui.blockpopup,'Value',1)

blockpopup_Callback(1)


function blockpopup_Callback(varargin)
global gui d
%Find selected block
blocks=get(gui.blockpopup,'String');
block=str2double(blocks{get(gui.blockpopup,'Value')});

%find trials for this block
trials=num2str(d.trials(d.blocks==block));

set(gui.triallist,'String',{trials})
set(gui.triallist,'Value',1)

function frameSlider_Callback(hObject, eventdata, handles)
global plotax
plotax.sliderVal=get(hObject,'Value');
updatePlot(plotax.sliderVal)

function frameSlider_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
global plotax
plotax.slider=hObject;


function [] = play_cb(varargin) 
global plotax d options

%Clear screens
cla(plotax.screen)
cla(plotax.left)
cla(plotax.right)

%Get data
options=getOptionsFromGUI;         
% trial=double(options.trial);
options.row=find(d.blocks==str2double(options.block) & d.trials == str2double(options.trial));

%Update text boxes on plot

set(plotax.trialInfo,'String',{options.subject; options.date; ['Block ' num2str(str2double(options.block))]; ['Trial ' num2str(str2double(options.trial))]})
set(plotax.playbackRateText,'String',[num2str(options.playbackrate) 'x'])

%reformat and adjust shape data
sampleShapeAdjusted=adjustShape(d.sampleCoords{options.row,1},d.samplePosition{options.row,1},d.sampleScale(options.row,1),d.sampleRotation(options.row,1));
choice1ShapeAdjusted=adjustShape(d.choice1Coords{options.row,1},[0 0 0],8,d.choice1Rotation(options.row,1));
choice2ShapeAdjusted=adjustShape(d.choice2Coords{options.row,1},[0 0 0],8,d.choice2Rotation(options.row,1));

%Calculate mean x and y vals for each pad on screen
plotax.padMeans=calcPadMeans(sampleShapeAdjusted);

%Plot
plotax.leftButton=plotHardware(plotax.left,0,'human');
plotax.rightButton=plotHardware(plotax.right,1,'human');

[plotax.shape, plotax.sampleShapeHandles] = plotPads(plotax.screen,sampleShapeAdjusted);
set(plotax.shape,'Visible','off')
set(plotax.sampleShapeHandles,'Visible','off')
if ~strcmp(deblank(d.touchMode(options.row,:)),'right')
[~, plotax.choice1ShapeHandles] = plotPads(plotax.left,choice1ShapeAdjusted);
end
if ~strcmp(deblank(d.touchMode(options.row,:)),'left')
[~, plotax.choice2ShapeHandles] = plotPads(plotax.right,choice2ShapeAdjusted);
end

plotax.fixation = plot(plotax.screen,0,0,'.w','MarkerSize',20);
set(plotax.fixation,'Visible','off')

plot(plotax.screen,0,0,'.')
drawnow

%trial duration
trialDur=d.responseTime(options.row); % time of button press in milliseconds

set(plotax.slider,'Max',trialDur+20)
set(plotax.slider,'Value',0)

tic;
elapsed = toc * 1000 * options.playbackrate;
%plot loop
while elapsed < trialDur
    elapsed = ceil(toc * 1000 * options.playbackrate);
    
    if elapsed > trialDur
        set(plotax.slider,'Value',trialDur)
    else
        set(plotax.slider,'Value',elapsed)
    end
    
    updatePlot(elapsed)
    drawnow
end


function [] = save_cb(varargin) 
global plotax d options plotFigure

%Clear screens
cla(plotax.screen)
cla(plotax.left)
cla(plotax.right)

%Get data
options=getOptionsFromGUI;       
options.row=find(d.blocks==str2double(options.block) & d.trials == str2double(options.trial));

%Update text boxes on plot
set(plotax.trialInfo,'String',{options.subject; options.date; ['Block ' num2str(str2double(options.block))]; ['Trial ' num2str(str2double(options.trial))]})
set(plotax.playbackRateText,'String',[num2str(options.playbackrate) 'x'])

%reformat and adjust shape data
sampleShapeAdjusted=adjustShape(d.sampleCoords{options.row,1},d.samplePosition{options.row,1},d.sampleScale(options.row,1),d.sampleRotation(options.row,1));
choice1ShapeAdjusted=adjustShape(d.choice1Coords{options.row,1},[0 0 0],8,d.choice1Rotation(options.row,1));
choice2ShapeAdjusted=adjustShape(d.choice2Coords{options.row,1},[0 0 0],8,d.choice2Rotation(options.row,1));

%Calculate mean x and y vals for each pad on screen
plotax.padMeans=calcPadMeans(sampleShapeAdjusted);

%Plot
plotax.leftButton=plotHardware(plotax.left,0,'human');
plotax.rightButton=plotHardware(plotax.right,1,'human');

[plotax.shape, plotax.sampleShapeHandles] = plotPads(plotax.screen,sampleShapeAdjusted);
set(plotax.shape,'Visible','off')
set(plotax.sampleShapeHandles,'Visible','off')
if ~strcmp(deblank(d.touchMode(options.row,:)),'right')
    [~, plotax.choice1ShapeHandles] = plotPads(plotax.left,choice1ShapeAdjusted);
end
if ~strcmp(deblank(d.touchMode(options.row,:)),'left')
    [~, plotax.choice2ShapeHandles] = plotPads(plotax.right,choice2ShapeAdjusted);
end

plotax.fixation = plot(plotax.screen,0,0,'.w','MarkerSize',20);
set(plotax.fixation,'Visible','off')

plot(plotax.screen,0,0,'.')
drawnow

%trial duration
trialDur=d.responseTime(options.row); % time of button press in milliseconds

set(plotax.slider,'Max',trialDur+20)
set(plotax.slider,'Value',0)

% v = VideoWriter('peaks6.mp4','MPEG-4');
v = VideoWriter('peaks6.avi');
v.Quality = 100;
v.FrameRate = 30;
open(v);

tic;
elapsed = 0;
n = 1;
%plot loop
while elapsed < (trialDur + options.playbackrate * 1000 / v.FrameRate)
    disp new
    if elapsed > trialDur
        set(plotax.slider,'Value',trialDur)
    else
        set(plotax.slider,'Value',elapsed)
    end

    updatePlot(elapsed)

    drawnow
%     frame(n) = getframe(plotFigure);
  
        tic
    writeVideo(v,getframe(plotFigure))
    toc

    
    n=n+1;

    
    elapsed = elapsed + options.playbackrate * 1000 / v.FrameRate;
end

close(v)
disp('Video written')


% plot(plotax.screen, sampleShape(:,1),sampleShape(:,2),'color',[.2 .4 .6],'linewidth',5)
% plot(plotax.left, 1,1,'o')
% plot(plotax.right, 1,1,'o')

% cla(plotax.screen)
% plot(plotax.screen, 1,1,'or')
% set(plotax.right,'xlim',[0 10])


function updatePlot(elapsed)
global plotax options d scatter1

sampleOnTime=d.stimOn(options.row) + d.sampleAvailOn(options.row);
sampleOffTime=d.stimOn(options.row) + d.sampleAvailOff(options.row);

%Time
set(plotax.playbackRateText,'String',{[num2str(options.playbackrate) 'x']; [num2str(ceil(elapsed)-sampleOnTime) ' ms']})

%Fixation
if (elapsed >= d.fixOn(options.row)) && (elapsed < d.fixOff(options.row))
    set(plotax.fixation,'Visible','on')
else
    set(plotax.fixation,'Visible','off')
end

%Turn on vis stim only when it was actually visible
if (elapsed >= sampleOnTime) && (elapsed < sampleOffTime)
    set(plotax.shape,'Visible','on')
    set(plotax.sampleShapeHandles,'Visible','on')
else
    set(plotax.shape,'Visible','off')
    set(plotax.sampleShapeHandles,'Visible','off')
end

%Eyes
eyerate=1000/d.ems{options.row,1}{1,1}; %sampling rate
eyex=d.ems{options.row,1}{2,1};
eyey=d.ems{options.row,1}{3,1};
eyeSample=ceil(elapsed * eyerate/1000);
if eyeSample <= length(eyex)
    if exist('scatter1')
        delete(scatter1);
    end
    scatter1=scatter(plotax.screen,eyex(1:eyeSample),eyey(1:eyeSample), ...
        'MarkerFaceColor','k','MarkerFaceAlpha',0.12,'MarkerEdgeAlpha',0);
end

%Pad
%Calculate distance between eyes and each pad
if eyeSample > 0
    dists=calcDistanceToEachPad(eyex(eyeSample),eyey(eyeSample));
    for i=1:12
        dist=0.45 - min(dists(i)/10,0.45);
        set(plotax.sampleShapeHandles(i),'Color',[0.15+dist 0.35+dist 0.55+dist])
    end
end
gTimesLeft=d.graspLeftTimes{options.row,1}; %times of sample in milliseconds
gTimesRight=d.graspRightTimes{options.row,1}; %times of sample in milliseconds
if gTimesLeft(end) > elapsed
    gTimesLeft(gTimesLeft > elapsed) = -inf;
    gTimesRight(gTimesRight > elapsed) = -inf;
    [~, touchIndLeft]=max(gTimesLeft);
    [~, touchIndRight]=max(gTimesRight);
    
    leftGraspVals=d.graspPctsLeft{options.row,1}{touchIndLeft,1};
    rightGraspVals=d.graspPctsRight{options.row,1}{touchIndRight,1};
    
    for i=1:12
        tl=leftGraspVals(i) / 255;
        tl=min(max(tl,0),0.2)*2;
        tr=rightGraspVals(i) / 255;
        tr=min(max(tr,0),0.2)*2;
        if ~strcmp(deblank(d.touchMode(options.row,:)),'right')
            set(plotax.choice1ShapeHandles(i),'Color',[0.15+tl 0.35+tl 0.55+tl])
        end
        if ~strcmp(deblank(d.touchMode(options.row,:)),'left')
            set(plotax.choice2ShapeHandles(i),'Color',[0.15+tr 0.35+tr 0.55+tr])
        end
    end
end

%Buttons
%Figure out button timing
[lbda, lbua, rbda, rbua] = getButtonTiming(options.row);
if elapsed > lbda && elapsed < lbua
    set(plotax.leftButton,'visible','off')

else
    set(plotax.leftButton,'visible','on')

end
if elapsed > rbda && elapsed < rbua
    set(plotax.rightButton,'visible','off')

else
    set(plotax.rightButton,'visible','on')

end



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
options.subject=string(subjects(get(gui.subjectpopup,'val')));
dates=get(gui.datepopup,'string');
options.date=string(dates(get(gui.datepopup,'val')));
blocks=get(gui.blockpopup,'string');
options.block=string(blocks(get(gui.blockpopup,'val')));
trials=get(gui.triallist,'string');
options.trial=string(trials(get(gui.triallist,'val')));
playbacks=get(gui.playbackratepopup,'string');
options.playbackrate=double(string(playbacks(get(gui.playbackratepopup,'val'))));


function subjects = getSubjects
subjects={};
files=dir('C:\Users\Ryan\Documents\Data\DGZs\Monkey\*.dgz');
for i=1:size(files,1)
   file=files(i,1).name;
   parts=strsplit(file,'_');
   subject=parts{1};
   subjects{i}=subject;
end
subjects=unique(subjects);

function adjusted=adjustShape(shapeRough, offsets, scale, rotation)
shape=[];

%Reformat
for i=1:size(shapeRough,1)
    xs=shapeRough{i,1}(1:2:end);
    ys=shapeRough{i,1}(2:2:end);
    pad=repmat(i,length(xs),1);
    shape=[shape; xs ys pad];
end
xs=shape(:,1);
ys=shape(:,2);

%Scale
if scale == 0
    scale=10;
end
xs=xs.*scale;
ys=ys.*scale;

%Rotate
[xs, ys]=rotatePoints(xs,ys,-deg2rad(rotation),0,0); %Rotated without slots

adjusted=[xs ys shape(:,3)];

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


function [lbda, lbua, rbda, rbua] = getButtonTiming(trial)
global d

rbda=d.responseTime(trial) + d.responseTime(trial) * ~d.response(trial);
lbda=d.responseTime(trial) + d.responseTime(trial) * d.response(trial);
lbua= lbda + 300;
rbua= rbda + 300;

function [x_rotated, y_rotated]=rotatePoints(x,y,theta,x_center,y_center)
v = [x';y'];
center = repmat([x_center; y_center], 1, length(x)); %Matrix for centering
R = [cos(theta) -sin(theta); sin(theta) cos(theta)]; % define a counter-clockwise rotation matrix
s = v - center;     % shift points in the plane so that the center of rotation is at the origin
so = R*s;           % apply the rotation about the origin
vo = so + center;   % shift again so the origin goes back to the desired center of rotation

x_rotated = vo(1,:)';
y_rotated = vo(2,:)';

function loadFile(fname)
clearvars -global d
global d

basePath = 'C:\Users\Ryan\Documents\Data\DGZs\Monkey\';
data = dg_read(fullfile(basePath, fname));

%ignored columns: load_params, filename, version, status, endtrial, endobs, stimtriggers, onlinesacs, onlineacqs
% onlineacqs_params, stimevents, stimdata, presrank, ems2, ems_kern, 
%basic info
d.subject=data.subj(1,:);
d.date=[num2str(data.month(1,:)) num2str(data.day(1,:)) num2str(data.year(1,:))];
d.blocks=data.file;
d.stim=data.stimtype;

d.fixOn=data.fixon;
d.fixOff=data.fixoff;
d.stimOn=data.stimon;
d.stimOff=data.stimoff;
d.response=data.resp;
d.responseTime=data.response;
d.answer=data.side;
d.reactionTime=data.rts;
d.target=data.target;
d.delay=data.delay;
d.touchMode=data.touch_mode;
d.trials=data.obsid;

%sample info
d.sampleMode=data.sample_mode;
d.sampleID=data.sample_id;
d.sampleSide=data.sample_side;
d.sampleAvailOn=data.sample_availOn;
d.sampleAvailOff=data.sample_availOff;
d.samplePosition=data.sample_position;
d.sampleScale=data.sample_scale;
d.sampleRotation=data.sample_rotation;
d.sampleCoords=data.grasp_coords_sample;

%choice 1 (left touch) info
d.choice1Mode=data.choice1_mode;
d.choice1ID=data.choice1_id;
d.choice1Port=data.choice1_port;
d.choice1Angle=data.choice1_rotation;
d.choice1AvailOn=data.choice1_availOn;
d.choice1AvailOff=data.choice1_availOff;
d.choice1Match=data.choice1_ismatch;
d.choice1Coords=data.grasp_coords_left;
d.choice1Rotation=data.choice1_rotation;

%choice 2 (right touch) info
d.choice2Mode=data.choice2_mode;
d.choice2ID=data.choice2_id;
d.choice2Port=data.choice2_port;
d.choice2Angle=data.choice2_rotation;
d.choice2AvailOn=data.choice2_availOn;
d.choice2AvailOff=data.choice2_availOff;
d.choice2Match=data.choice2_ismatch;
d.choice2Coords=data.grasp_coords_right;
d.choice2Rotation=data.choice2_rotation;

%psychophys data
d.ems=data.ems;
% ems2=data.ems2;
d.graspTimes=data.grasp_pcts_times;
d.graspLeftTimes=data.grasp_pcts_left_times;
d.graspRightTimes=data.grasp_pcts_right_times;
d.graspPctsLeft=data.grasp_pcts_left;
d.graspPctsRight=data.grasp_pcts_right;
d.graspValsLeft=data.grasp_vals_left;
d.graspValsRight=data.grasp_vals_right;

try
d.flip=data.flip;
catch end

