function varargout = videoAnalysis(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @videoAnalysis_OpeningFcn, ...
                   'gui_OutputFcn',  @videoAnalysis_OutputFcn, ...
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

function videoAnalysis_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;
guidata(hObject, handles);



function varargout = videoAnalysis_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;





%%

% data files listbox



function dataFilesListbox_Callback(hObject, eventdata, handles)

sel=get(handles.dataFilesListbox,'value');
all=get(handles.dataFilesListbox, 'string');

files=all(sel);

% basePath = 'C:/Users/Ryan/Documents/Matlab/MatlabData/PlanetEarthBlocks';

sel=get(handles.dataFilesListbox,'value');
all=get(handles.dataFilesListbox, 'string');

files=all(sel);

data2=combineDG(files);

%Find unique channels/sorts in master.TDT_spike_codes
chansorts=[0 0];    %Initialize
for i=1:size(data2.TDT_spike_codes) %Go through each row of spike codes which each represent a trial
    these=data2.TDT_spike_codes{i,1}; %spike codes for this trial
    for ii=1:size(these,1) %Go through each row of these which each represent a channel
        sorts=these{ii}; %Grab sort codes for all spikes for this trial/channel
        combos=[repmat(ii,length(sorts),1) sorts]; %add to list
        chansorts=[chansorts; combos]; 
    end
    chansorts=unique(chansorts,'rows'); %Cut out the duplicates
end
chansorts=sortrows(chansorts); %Sort
chansorts=chansorts(chansorts(:,2)~=31,:); %Remove unsorted
chansorts=chansorts(chansorts(:,1)~=0,:); %Remove initializing row

list={[repmat('Chan: ', size(chansorts,1), 1) num2str(chansorts(:,1)) repmat(' Sort: ', size(chansorts,1), 1)  num2str(chansorts(:,2))]};

set(handles.chanSortListbox,'string',list)
set(handles.chanSortListbox,'value',[])


function dataFilesListbox_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

current = pwd;
basePath = 'C:/Users/Ryan/Documents/Matlab/MatlabData/PlanetEarthBlocks';
cd(basePath);
files= dir('*.dgz');
cd(current);

c=struct2cell(files);
set(hObject,'String',c(1,:))


function selectAllDataButton_Callback(hObject, eventdata, handles)
all=get(handles.dataFilesListbox,'string');
set(handles.dataFilesListbox,'value',1:length(all))
dataFilesListbox_Callback(0,0,handles)

function selectNoneDataButton_Callback(hObject, eventdata, handles)


%%

% channel selection



function chanSortListbox_Callback(hObject, eventdata, handles)
function chanSortListbox_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function selectAllChanButton_Callback(hObject, eventdata, handles)
all=get(handles.chanSortListbox,'string');
set(handles.chanSortListbox,'value',1:length(all))



function selectNoneChanButton_Callback(hObject, eventdata, handles)

%%

%options



function colorCheckbox_Callback(hObject, eventdata, handles)

function grayscaleCheckbox_Callback(hObject, eventdata, handles)



function latencyEdit_Callback(hObject, eventdata, handles)

function latencyEdit_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function waitEdit_Callback(hObject, eventdata, handles)
function waitEdit_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function filterPopup_Callback(hObject, eventdata, handles)
function filterPopup_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





function resultsStorageEdit_Callback(hObject, eventdata, handles)

function resultsStorageEdit_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in browseButton.
function browseButton_Callback(hObject, eventdata, handles)
new=uigetdir(pwd);
set(handles.resultsStorageEdit,'String',new)


%%

%Begin

function beginButton_Callback(hObject, eventdata, handles)
%Read in user selections
sel=get(handles.dataFilesListbox,'value');
all=get(handles.dataFilesListbox, 'string');
files=all(sel);

sel=get(handles.chanSortListbox,'value');
all=get(handles.chanSortListbox, 'string');
chansorts=all(sel);





% error checking

if isempty(files)
    warndlg('Choose a data file')
    return;
end

if isempty(chansorts)
    warndlg('Choose a channel/sort')
    return;
end

if ~get(handles.grayscaleCheckbox,'value') && ~get(handles.colorCheckbox,'value')
    warndlg('You must choose to analyze color and/or grayscale')
    return;
end


chansorts=cell2mat(chansorts);
chans=str2num(strtrim(chansorts(:,7:8)));
sorts=str2num(chansorts(:,end));

combos=[chans sorts];

% read in selected options

options.filterSelection=get(handles.filterPopup, 'string');

if get(handles.grayscaleCheckbox,'value')
    options.analyzeGrayscale=1;
else
    options.analyzeGrayscale=0;
end

if get(handles.colorCheckbox,'value')
    options.analyzeColor=1;
else
    options.analyzeColor=0;
end


options.wait=str2num(get(handles.waitEdit,'String'));
options.saveDirectory=get(handles.resultsStorageEdit,'String');
if ~strcmp(options.saveDirectory(end), '\')
    options.saveDirectory=[options.saveDirectory '\'];
end

% get the piles done for these data files according to selected options
for i=1:size(files,1)
    data2=combineDG(files(i,:));
    getSpikes2(files(i,:),data2,combos,options)
end

%For each chan/sort, go through each data file and sum together

for i=1:size(combos,1)
    thisChan=combos(i,1);
    thisSort=combos(i,2);
    for ii=1:size(files,1)

        %Get file name of the raw data
        a=files(ii,:);
        b=char(a);
        c=b(1:end-4);
        
        %Create entire string of results image
        fileString=[c 'chan' num2str(thisChan) 'sort' num2str(thisSort) 'wait' num2str(options.wait) 'color' num2str(options.analyzeColor) 'gray' num2str(options.analyzeGrayscale) options.filterSelection '.png'];
        
        
        try
            thisPile=imread([options.saveDirectory fileString]);
        catch
            continue;
        end

        if ~exist('masterPile')
            masterPile=thisPile;
        else
            masterPile=masterPile+thisPile;
        end
    end
    
    %Ship masterpile out to compilePiles to do the math
    videoRF=compilePiles(masterPile,thisChan,thisSort,options);
    clear masterPile
    
end




