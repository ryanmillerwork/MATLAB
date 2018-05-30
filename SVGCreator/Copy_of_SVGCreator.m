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

% Last Modified by GUIDE v2.5 02-May-2017 13:13:10

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
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SVGCreator (see VARARGIN)

% Choose default command line output for SVGCreator
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


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
    end
end

set(handles.chooseFile,'string',{dgzs})


loadFile(handles)

function loadFile(handles)
global xs ys options
%Get the chosen file
files=get(handles.chooseFile,'string');
chosen=files(get(handles.chooseFile,'value'));
filename=[chosen{1} '.dgz'];

%Update the save box
set(handles.editFilename,'string',chosen{1})

%Read the dgz into xs and ys
c=dg_read(fullfile('C:\Users\Ryan\Documents\MATLAB\PlotPointsPerim', filename));
xs=c.union{1,1};
ys=c.union{2,1};

%Plot input in the first box
plot(handles.axes1,xs,ys)
axis equal

%Read options
options.unitsPerMM=str2double(get(handles.EditUnitsPerMM,'String'));
options.ratio=str2double(get(handles.EditRadsPerPoint,'String'));
options.contacts=str2double(get(handles.EditNContacts,'String'));
options.slotDepth=str2double(get(handles.editSlotDepth,'String'))*options.unitsPerMM;
options.slotWidth=str2double(get(handles.EditSlotWidth,'String'));
options.symmetric=get(handles.radioSymm,'Value');
options.left=get(handles.radioLeft,'Value');
for i=1:6
    radio=['handles.radioPair' num2str(i)];
    if get(eval(radio),'Value')
        options.radio=i;
    end
end

pointsAlongPerim(handles)

function pointsAlongPerim(handles)
%Replace imported points with new points drawn at specified increment (0.1 mm)
global xs ys options points

%step through x,y pairs, draw a line to the next one, pick points every dt units, add all to list "points"
dt=options.unitsPerMM/10; %Desired distance between points is 0.1 mm
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
global options points x_rm y_rm x_ro y_ro

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

%-----good above here

%% Find first and mid points and reorder points
% %Find first point and mid point so we can re-order the list of points to simplify finding symmetry if necessary
slotSpots=find(points(:,5)==0); %Indices where there were slices
if x_ro(slotSpots(pair(1))+10) < 0
    first=slotSpots(pair(1)); %selection 1:6
    mp=slotSpots(pair(2)); %Selection 1:6 +6
else %Not necessary probably
    disp boooooo 
    first=slotSpots(pair(2));
    mp=slotSpots(pair(1));
end













%Reorder according to that start point
x_ro=[x_ro(first:end) x_ro(1:first-1)];
y_ro=[y_ro(first:end) y_ro(1:first-1)];

%Find transition midpoint
% x_ro(abs(x_ro)<0.00001)=0; %Rounding errors cause the midpoint to be reaalllly close to zero
% mp=find(x_ro==0);
% mp=mp(end);

%----reorder seems to be working

%% Reflect if requested 
newmp=mp-first+1;
if ~options.symmetric
    x_rm=x_ro;
    y_rm=y_ro;
elseif options.symmetric && options.left    %Left symmetric
    x_rm=[x_ro(1:newmp)  x_ro(newmp-1:-1:2)*-1];
    y_rm=[y_ro(1:newmp)  y_ro(newmp-1:-1:2)];
%     x_rm(1)=0;
elseif options.symmetric && ~options.left    %Right symmetric
    x_rm=[x_ro(newmp+1:end) x_ro(end:-1:newmp+1)*-1];
    y_rm=[y_ro(newmp+1:end) y_ro(end:-1:newmp+1)];
%     x_rm(1)=0;
end

x_rm(abs(x_rm)<0.00001) = 0;

%---seems to be working
%% Add knife slots
[newxs, newys]=addKnifeSlots(x_rm,y_rm); %Rounding errors cause the midpoint to be reaalllly close to zero

%% Plot
axes(handles.axes2); cla; hold on; axis equal
plot(points(:,1),points(:,2))
plot(points(points(:,5)==0,1),points(points(:,5)==0,2),'k.','MarkerSize',20)
plot(points(1,1),points(1,2),'g.','MarkerSize',20)
plot([x0 x1],[y0 y1]) %Slice

axes(handles.axes3); cla; hold on;  axis equal
xlim([-0.5 0.5])
ylim([-0.5 0.5])

plot(newxs,newys)
plot([0 0],[-1 1],':')




%recycled slot points
slotSpots=slotSpots(pair(1):pair(2))-first+1;

plot(x_ro(slotSpots),y_ro(slotSpots),'ro')

%add slots





function [newxs, newys]=addKnifeSlots(xs,ys)
global options

%% Build first four columns of points: xs, ys, tangent, delta tangent
points=calcTangents([xs' ys']); %Find tangents and change in tangent from point to point

%% Build fifth column of points: accumulated score
%calculate total change in angle
npoints=size(points,1);
totalAngle=sum(abs(points(:,4)));
totalScore=totalAngle+(npoints+1)/options.ratio
scoreEach=totalScore/options.contacts;

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


%% Draw knife slots
for i=1:length(xs)
    x1=points(i,1);
    y1=points(i,2);
        
    %If theres no slot to deal with, move on
    if points(i,5)~=0
        points(i,6)=x1;
        points(i,7)=y1;
        continue;
    end
    
    %Find perpindicular angle (pointing in) to current tangent
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

% global mirrored
% mirrored=points;





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
    
%     if d < (dt/2) %If the next point 
%         x=x(1:end-1);
%         y=y(1:end-1);
%         continue;
%     end
%         
    
%     plot(x(i), y(i),'ro')
%     drawnow
%     pause(0.05)
    
end


function [x_rotated, y_rotated]=rotatePoints(x,y,theta,x_center,y_center)

% define the x- and y-data for the original line we would like to rotate
% x = xs';
% y = ys';
% create a matrix of these points, which will be useful in future calculations
v = [x';y'];
% choose a point which will be the center of rotation
% x_center = x(3);
% y_center = y(3);
% create a matrix which will be used later in calculations
center = repmat([x_center; y_center], 1, length(x));
% define a 60 degree counter-clockwise rotation matrix
% theta = pi/3;       % pi/3 radians = 60 degrees
R = [cos(theta) -sin(theta); sin(theta) cos(theta)];
% do the rotation...
s = v - center;     % shift points in the plane so that the center of rotation is at the origin
so = R*s;           % apply the rotation about the origin
vo = so + center;   % shift again so the origin goes back to the desired center of rotation
% this can be done in one line as:
% vo = R*(v - center) + center
% pick out the vectors of rotated x- and y-data
x_rotated = vo(1,:);
y_rotated = vo(2,:);
% make a plot
plot(x, y, 'k-', x_rotated, y_rotated, 'r-', x_center, y_center, 'bo');
axis equal


% --- Outputs from this function are returned to the command line.
function varargout = SVGCreator_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function EditUnitsPerMM_Callback(hObject, eventdata, handles)
loadFile(handles)
function EditUnitsPerMM_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditUnitsPerMM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EditRadsPerPoint_Callback(hObject, eventdata, handles)
loadFile(handles)
function EditRadsPerPoint_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditRadsPerPoint (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EditNContacts_Callback(hObject, eventdata, handles)
loadFile(handles)
function EditNContacts_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditNContacts (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editSlotDepth_Callback(hObject, eventdata, handles)
loadFile(handles)
function editSlotDepth_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editSlotDepth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EditSlotWidth_Callback(hObject, eventdata, handles)
loadFile(handles)
function EditSlotWidth_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditSlotWidth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in chooseFile.
function chooseFile_Callback(hObject, eventdata, handles)
cla(handles.axes1)
cla(handles.axes2)
cla(handles.axes3)
loadFile(handles)

function chooseFile_CreateFcn(hObject, eventdata, handles)
% hObject    handle to chooseFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in buttonSave.
function buttonSave_Callback(hObject, eventdata, handles)
% hObject    handle to buttonSave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function editFilename_Callback(hObject, eventdata, handles)
% hObject    handle to editFilename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editFilename as text
%        str2double(get(hObject,'String')) returns contents of editFilename as a double


% --- Executes during object creation, after setting all properties.
function editFilename_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editFilename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when selected object is changed in uibuttongroup3.
function uibuttongroup3_SelectionChangedFcn(hObject, eventdata, handles)
loadFile(handles)

% --- Executes when selected object is changed in uibuttongroup2.
function uibuttongroup2_SelectionChangedFcn(hObject, eventdata, handles)
loadFile(handles)


% --- Executes when selected object is changed in uibuttongroup1.
function uibuttongroup1_SelectionChangedFcn(hObject, eventdata, handles)
loadFile(handles)
