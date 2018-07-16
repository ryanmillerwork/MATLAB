function varargout = SVGCreator(varargin)
% SVGCREATOR MATLAB code for SVGCreator.fig
%      SVGCREATOR, by itself, creates a new SVGCREATOR or raises the existing
%      singleton*.
%
%      H = SVGCREATOR returns the handle to a new SVGCREATOR or the handle to
%      the existing singleton*.
%
%      SVGCREATOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SVGCREATOR.M with the given input arguments.
%
%      SVGCREATOR('Property','Value',...) creates a new SVGCREATOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SVGCreator_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SVGCreator_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SVGCreator

% Last Modified by GUIDE v2.5 16-May-2017 15:47:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SVGCreator_OpeningFcn, ...
                   'gui_OutputFcn',  @SVGCreator_OutputFcn, ...
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
% End initialization code - DO NOT EDIT


% --- Executes just before SVGCreator is made visible.
function SVGCreator_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject; % Choose default command line output for SVGCreator
guidata(hObject, handles);% Update handles structure

%Find files and put them in listbox 'chooseFile'
files=ls;
dgzs=[];
for i=1:size(files,1)
    file=strtrim(files(i,:));
    if length(file)<4
        continue;
    end
    if strcmp(file(end-3:end),'.dgz')
        dgzs=[dgzs; file(1:end-4)];
    elseif strcmp(file(end-3:end),'.csv')
        dgzs=[dgzs; file(1:end-4)];
    end
    dgzs
end

set(handles.chooseFile,'string',{dgzs})


loadFile(handles)

function loadFile(handles)
global xs ys options
%Get the chosen file
files=get(handles.chooseFile,'string');
chosen=files(get(handles.chooseFile,'value'));
filename=[chosen{1} '.dgz'];

%Read the dgz into xs and ys
c=dg_read(fullfile(pwd, filename));
xs=c.union{1,1};
ys=c.union{2,1};

%Plot input in the first box
plot(handles.axes1,xs,ys)
set(handles.axes1,'visible','off');
axis equal

%Read options
options.unitsPerMM=str2double(get(handles.EditUnitsPerMM,'String'));
options.ratio=str2double(get(handles.EditRadsPerPoint,'String'));
options.contacts=str2double(get(handles.EditNContacts,'String'));
options.slotDepth=str2double(get(handles.editSlotDepth,'String'))*options.unitsPerMM;
options.slotWidth=str2double(get(handles.EditSlotWidth,'String'));
options.maxWidth=str2double(get(handles.editMaxWidth,'String'));
options.symmetric=get(handles.radioSymm,'Value');
options.left=get(handles.radioLeft,'Value');
for i=1:6
    radio=['handles.radioPair' num2str(i)];
    if get(eval(radio),'Value')
        options.radio=i;
    end
end

%Update the save box string 
saveString=[chosen{1} '_' num2str(options.unitsPerMM) '_' num2str(options.ratio) '_' num2str(options.contacts) '_' num2str(options.slotDepth/options.unitsPerMM) '_' num2str(options.slotWidth) '_' num2str(options.maxWidth) '_' num2str(options.symmetric) '_' num2str(options.radio) '_' num2str(options.left) '.svg'];
set(handles.editFilename,'string',saveString)
set(handles.textFolder,'string',pwd);


pointsAlongPerim(handles)

function pointsAlongPerim(handles)
%Replace imported points with new points drawn at specified increment (0.1 mm)
global xs ys options points

%Calculate distance of every point from every other point and scale object so that furthest point is 50 mm away 
big=0;
for i=1:length(xs)-1
    for ii=i:length(xs)
        this=sqrt((xs(ii)-xs(i))^2 + (ys(ii)-ys(i))^2);
        if this>big
            big=this;
        end
    end
end

ratio=big/(options.unitsPerMM*options.maxWidth);
xs=xs./ratio;
ys=ys./ratio;


% axes(handles.axes1)
% hold on;
% plot(handles.axes1,xs,ys,'r')
% set(handles.axes1,'visible','off');
% axis equal


%step through x,y pairs, draw a line to the next one, pick points every dt units, add all to list "points"
dt=options.unitsPerMM*0.1; %Desired distance between points is 0.1 mm
points=[xs(1) ys(1)];
for i=1:size(xs,1)
    %This x,y. starts from where we left off last round
    if i==1
        x0=xs(i);
        y0=ys(i);
    else
        x0=x(end);
        y0=y(end);
    end        
    
    %Next x,y, wrap around to start at the end
    if i<size(xs,1)
        x1=xs(i+1);
        y1=ys(i+1);
    else
        x1=xs(1);
        y1=ys(1);
    end
    
    [x, y]=makePointsAlongLine(dt,x0,x1,y0,y1);
    if ~isempty(x) %If there are any interpolated points, add to list
        points=[points; x' y'];    %add interpolated points
    else %In case the spacing was already so tight that theres no room, effectively skip current x1,y1
        x=x0;
        y=y0;
    end
end

points=calcTangents(points); %Find tangents and change in tangent from point to point
npoints=size(points,1);

%calculate total change in angle
totalAngle=sum(abs(points(:,4)));
totalScore=totalAngle+(npoints)/options.ratio; %Npoints+1 because we wrap around at the end
scoreEach=totalScore/options.contacts;

%Find point of maximum deflection and use that as a start point
first=find(points(:,4)==min(points(:,4)));

%rearrange points matrix according to where we want to start
points=[points(first:end,:); points(1:first-1,:)];

%Move through matrix and accumulate score
counter=0;
samples=0;
for i=1:npoints
    points(i,5)=counter;
    samples=samples+1;
    counter=counter + abs(points(i,4)) + 1/options.ratio;
    if counter >= (scoreEach+0.00001)
        counter=counter-scoreEach;
        samples=0;
        points(i,5)=0;
    end    
end

borders=points(points(:,5)==0,:);

if size(borders,1) ~= (options.contacts)
    errordlg('Wrong number of contacts')
end

handleSymmetry(handles)

function handleSymmetry(handles)
global options points slotSpots angle x_noslot y_noslot

%% First, rotate object so that selected pair is vertical about x=0, and shift center to 0,0
%Find selected points (opposite slots)
pair(1)=options.radio;
pair(2)=pair(1)+floor(options.contacts/2);

slots=points(points(:,5)==0,:); 
x0=slots(pair(1),1);
y0=slots(pair(1),2);
x1=slots(pair(2),1);
y1=slots(pair(2),2);

%Calculate angle between selected points
angle=atan((y1-y0)/(x1-x0)); %Angle between the two selected points
% Quadrant 2
if x1<x0
    angle=angle+pi;
end
% Quadrant 4
if x1>x0 && y1<y0
    angle=angle+pi*2;
end

angle=angle+pi/2;

%Find midpoint
xmid=(x1+x0)/2;
ymid=(y1+y0)/2;

[x_ro, y_ro]=rotatePoints(points(:,1),points(:,2),-angle,xmid,ymid); %Rotated without slots

%Shift to center
x_ro=x_ro-xmid;
y_ro=y_ro-ymid;

%% Find first and mid points and reorder points
% %Find first point and mid point so we can re-order the list of points to simplify finding symmetry if necessary
slotSpots=find(points(:,5)==0); %Indices where there were slices
% if x_ro(slotSpots(pair(1))+10) < 0
    first=slotSpots(pair(1)); %selection 1:6
    mp=slotSpots(pair(2)); %Selection 1:6 +6
% else %Not necessary probably
%     disp boooooo 
%     first=slotSpots(pair(2));
%     mp=slotSpots(pair(1));
% end
slotSpots=points(:,5)~=0; %1 where theres a slot

%Reorder according to that start point
x_ro=[x_ro(first:end) x_ro(1:first-1)];
y_ro=[y_ro(first:end) y_ro(1:first-1)];
slotSpots=[slotSpots(first:end)' slotSpots(1:first-1)'];

%% Reflect if requested 
newmp=mp-first+1;
if ~options.symmetric
    x_rm=x_ro;
    y_rm=y_ro;
elseif options.symmetric && options.left    %Left symmetric
    x_rm=[x_ro(1:newmp)  x_ro(newmp-1:-1:2)*-1];
    y_rm=[y_ro(1:newmp)  y_ro(newmp-1:-1:2)];
    slotSpots=[slotSpots(1:newmp) slotSpots(newmp-1:-1:2)];
elseif options.symmetric && ~options.left    %Right symmetric
    x_rm=[x_ro(newmp:end) 0 x_ro(end:-1:newmp+1)*-1];
    y_rm=[y_ro(newmp:end) y_ro(end) y_ro(end:-1:newmp+1)];
    slotSpots=[slotSpots(newmp:end) 0 slotSpots(end:-1:newmp+1)];
end

x_rm(abs(x_rm)<0.00001) = 0;

%% Add knife slots
global newxs newys
[newxs, newys]=addKnifeSlots(x_rm,y_rm,slotSpots); %Rounding errors cause the midpoint to be reaalllly close to zero

%% Center on center of mass
newxs=newxs-mean(newxs);
newys=newys-mean(newys);

%% Plot
axes(handles.axes2); cla; hold on; axis equal
plot(points(:,1),points(:,2))
plot(points(points(:,5)==0,1),points(points(:,5)==0,2),'k.','MarkerSize',20)
plot(points(1,1),points(1,2),'g.','MarkerSize',20)
plot([x0 x1],[y0 y1]) %Slice
set(gca,'visible','off');

axes(handles.axes3); cla; 
blob=plotFinal(newxs,newys);
plot([0 0],[-1 1],':k')
plot([-1 1],[0 0],'k:')

rotate(blob,[0 0 1],angle*360/(2*pi))

[x_noslot, y_noslot]=rotatePoints(x_rm',y_rm',angle,1,1);

x_noslot=x_noslot-mean(x_noslot);
y_noslot=y_noslot-mean(y_noslot);

function circle(x,r)
global options
%x is distance from center of plot to center of each hole
%r is the radius of each hole

x=x*options.unitsPerMM;
r=r*options.unitsPerMM;

xs=[x 0 -x 0];
ys=[0 x 0 -x];

viscircles([xs' ys'], repmat(r,4,1),'linewidth',1,'color',[0 0.5 0.8]);

function blob=plotFinal(xs,ys)
hold on;
axis equal
xlim([-0.6 0.6]) %.0132 for 0.6, .0121 for 0.55, .011 for 0.5
ylim([-0.6 0.6])
blob=plot(xs,ys);
plot([0 0],[-.05 .05],':')
plot([-.05 .05],[0 0],':')
circle(8,1.25); %Distance of holes from center, radius of each hole
set(gca,'visible','off');

function [newxs, newys]=addKnifeSlots(xs,ys,slotSpots)
global options

%% Build first four columns of points: xs, ys, tangent, delta tangent
points=calcTangents([xs' ys']); %Find tangents and change in tangent from point to point

%% Add fifth column indicating placement of slices
% %calculate total change in angle
points=[points slotSpots'];

%% Draw knife slots

points=[points points(:,1:2)];
npoints=size(points,1);
for i=1:length(xs)
    x1=points(i,1);
    y1=points(i,2);
        
    %If theres no slot to deal with, move on
    if points(i,5)~=0
%         points(i,6)=x1;
%         points(i,7)=y1;
        continue;
    end
    
    %Find perpendicular angle (pointing in) to current tangent
    thisAngle=points(i,3);
    rightAngle=thisAngle+pi/2;
    
    %Slot bottom
    x2 = x1 + options.slotDepth*cos(rightAngle);
    y2 = y1 + options.slotDepth*sin(rightAngle);
    
    %Store slot bottom at surrounding spots
    for ii=-options.slotWidth:options.slotWidth %-10 to 10
        
        %Figure out row of points where we want to be
        if (i+ii)<1
            thisInd=npoints+(i+ii);
        elseif (i+ii)>npoints
            thisInd=i+ii-npoints;
        else
            thisInd=i+ii;
            
        end
        
        points(thisInd,6:7)=[x2 y2]; %Store slot bottom at this spot        
    end
    
end
newxs=[points(1:end-1,6); points(1,6)];
newys=[points(1:end-1,7); points(1,7)];

function points=calcTangents(points)
global options
%Step through full list of points, calculate tangent at each point
width=options.slotWidth; %Number of points back and forward to calculate slope over
npoints=size(points,1);
for i=1:npoints
    if i<(width+1)        
        i1=npoints-(width-i);
        i2=i+width;
    elseif npoints<(i+width)
        i1=i-width;
        i2=i-npoints+width;
    else
        i1=i-width;
        i2=i+width;
    end

    x0=points(i1,1);
    y0=points(i1,2);
    x1=points(i2,1);
    y1=points(i2,2);
    
    angle=atan((y1-y0)/(x1-x0));
    
    %Quadrant 2
    if x1<x0
        angle=angle+pi;
    end
    %Quadrant 4
    if x1>x0 && y1<y0
        angle=angle+pi*2;
    end
    
    
    points(i,3)=angle;
end

%Calculate change in angles
for i=1:npoints
    if i==1
        points(i,4)=angdiff(points(end,3),points(2,3));
    elseif i<npoints
        points(i,4)=angdiff(points(i-1,3),points(i+1,3));
    else
        points(i,4)=angdiff(points(i-1,3),points(1,3));
    end
end

function [x, y]=makePointsAlongLine(dt,x0,x1,y0,y1)

d=sqrt((x1-x0)^2 + (y1-y0)^2); %distance between this point and the next point

%Will hold coordinates of points and return it
x=[];
y=[];
for i=1:floor(d/dt) %floor(d/dt) is number of points between start and end at the specified increment
    r=dt/d;                 %Ratio of desired to actual distance    
    x(i)=((1-r)*x0+r*x1);   %x val of point 
    y(i)=((1-r)*y0+r*y1);
    
    %Update start point and distance to end
    x0=x(i);
    y0=y(i);
    d=sqrt((x1-x0)^2 + (y1-y0)^2); %distance between this point and the next point
end

function [x_rotated, y_rotated]=rotatePoints(x,y,theta,x_center,y_center)
v = [x';y'];
center = repmat([x_center; y_center], 1, length(x)); %Matrix for centering
R = [cos(theta) -sin(theta); sin(theta) cos(theta)]; % define a counter-clockwise rotation matrix
s = v - center;     % shift points in the plane so that the center of rotation is at the origin
so = R*s;           % apply the rotation about the origin
vo = so + center;   % shift again so the origin goes back to the desired center of rotation

x_rotated = vo(1,:);
y_rotated = vo(2,:);

function buttonSave_Callback(hObject, eventdata, handles)
global x_noslot y_noslot options points slotSpots
filename=get(handles.editFilename,'string');

%Replot data, save as svg, close figure
global newxs newys angle
fig=figure; 
blob=plotFinal(newxs,newys);
rotate(blob,[0 0 1],angle*360/(2*pi));
print(fig,filename,'-dsvg')
close(fig)

winopen(filename)

%Handle storing to mat file
% load objectInfo
% 
% ID=size(objectInfo,2)+1;
% 
% objectInfo(ID).points=[x_noslot' y_noslot'];
% objectInfo(ID).fileName=filename;

% save objectInfo objectInfo

%Save to database
files=get(handles.chooseFile,'string');
chosen=files(get(handles.chooseFile,'value'));
addRowToTable([x_noslot' y_noslot' slotSpots'], chosen, options.unitsPerMM, options.ratio, options.contacts, options.slotDepth/options.unitsPerMM, options.slotWidth, options.maxWidth, options.symmetric, options.radio, options.left)

function varargout = SVGCreator_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function EditUnitsPerMM_Callback(hObject, eventdata, handles)
loadFile(handles)
function EditUnitsPerMM_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function EditRadsPerPoint_Callback(hObject, eventdata, handles)
loadFile(handles)

function EditRadsPerPoint_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function EditNContacts_Callback(hObject, eventdata, handles)
loadFile(handles)

function EditNContacts_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function editSlotDepth_Callback(hObject, eventdata, handles)
loadFile(handles)

function editSlotDepth_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function EditSlotWidth_Callback(hObject, eventdata, handles)
loadFile(handles)

function EditSlotWidth_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function chooseFile_Callback(hObject, eventdata, handles)
cla(handles.axes1)
cla(handles.axes2)
cla(handles.axes3)
loadFile(handles)

function chooseFile_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function editFilename_Callback(hObject, eventdata, handles)
function editFilename_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function uibuttongroup3_SelectionChangedFcn(hObject, eventdata, handles)
loadFile(handles)

function uibuttongroup2_SelectionChangedFcn(hObject, eventdata, handles)
loadFile(handles)

function uibuttongroup1_SelectionChangedFcn(hObject, eventdata, handles)
loadFile(handles)



function editMaxWidth_Callback(hObject, eventdata, handles)
loadFile(handles)
function editMaxWidth_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
