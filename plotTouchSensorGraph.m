clc

correctLength=25; %Number of columns we're expecting to get.
%% Initialize serial port
try
    fclose(s)
catch
end
s = serial('COM10', 'BaudRate', 250000);


fopen(s)

%% First we have to clear out the initial crap. "Debug initialized" is the signal that the arduino is started
start=[];
while isempty(start)
    raw = fscanf(s);
    start=strfind(raw,'Debug Initialized');
    if ~isempty(start)
        raw=raw(start:end);
        disp(raw)
    end
end

disp('Lets get this party started')

%% Go through the debug messages
while raw(1)=='D'
    raw = fscanf(s);
    if raw(1)=='D'
        disp(raw)
    end
end
disp('Debug complete')

%% Now we're getting the data. Plot it.

%Create a baseline for the measurements from the first 
data=str2num(raw);
baselineMat=data;
for i=1:19
    raw = fscanf(s);
    data=str2num(raw);
    baselineMat(i,:)=data;
end
baseline=mean(baselineMat);
baseline(1)=baselineMat(end,1); %Time is last measurement

%Start collecting and plotting actual data, baseline subtracted.
data=data-baseline+255;
data(2:end)=data(2:end)/255;
% dataMat=repmat(data,100,1);

figure; 
counter=1;
fullData=[];
for i=1:20000
    
    while s.bytesAvailable > 24
        raw = fscanf(s);
        
    end
    data=str2num(raw);
    
    if length(data)~=correctLength
        disp(data)
        continue;
    end
    data=data-baseline+255;
    data(2:end)=data(2:end)/255;
    data(2:end)=min(data(2:end),1);
    data(2:end)=max(data(2:end),0);
    data(2:end)=(data(2:end)).^5;
    
    subplot(1,2,1); hold on;
    cla
    %Front face
    rectangle('Position',[-2 0.5 4 8.5],'FaceColor',[data(2) data(2) data(2)])
    rectangle('Position',[-2 -9 4 8.5],'FaceColor',[data(3) data(3) data(3)])
    
    %Left face
%     rectangle('Position',[-7 1 4 8],'FaceColor',[data(5) data(5) data(5)])
%     rectangle('Position',[-7 -9 4 8],'FaceColor',[data(6) data(6) data(6)]) 
%     rectangle('Position',[-12 -9 4 18],'FaceColor',[data(13) data(13) data(13)]) 
    
    fill([-4.5 -2.5 -2.5 -4.5],[.5 .5 9 11],[data(5) data(5) data(5)])
    fill([-4.5 -2.5 -2.5 -4.5],[-.5 -.5 -9 -11],[data(6) data(6) data(6)])
    fill([-7 -5 -5 -7],[-13.5 -11.5 11.5 13.5],[data(13) data(13) data(13)])
    
    %Right face
%     rectangle('Position',[3 1 4 8],'FaceColor',[data(10) data(10) data(10)]) 
%     rectangle('Position',[3 -9 4 8],'FaceColor',[data(9) data(9) data(9)])
%     rectangle('Position',[8 -9 4 18],'FaceColor',[data(12) data(12) data(12)])
    
    fill([4.5 2.5 2.5 4.5],[.5 .5 9 11],[data(10) data(10) data(10)])
    fill([4.5 2.5 2.5 4.5],[-.5 -.5 -9 -11],[data(9) data(9) data(9)])
    fill([7 5 5 7],[-13.5 -11.5 11.5 13.5],[data(12) data(12) data(12)])
    
    
    %Top face
%     rectangle('Position',[-2 10 4 8],'FaceColor',[data(8) data(8) data(8)])
%     rectangle('Position',[-2 19 4 8],'FaceColor',[data(11) data(11) data(11)])
    fill([-2 2 4 -4],[9.5 9.5 11.5 11.5],[data(8) data(8) data(8)])
    fill([-4.5 4.5 6.5 -6.5],[12 12 14 14],[data(11) data(11) data(11)])
    
    %Bottom face
%     rectangle('Position',[-2 -18 4 8],'FaceColor',[data(7) data(7) data(7)])
%     rectangle('Position',[-2 -27 4 8],'FaceColor',[data(4) data(4) data(4)])
    fill([-2 2 4 -4],[-9.5 -9.5 -11.5 -11.5],[data(7) data(7) data(7)])
    fill([-4.5 4.5 6.5 -6.5],[-12 -12 -14 -14],[data(4) data(4) data(4)])
    
    axis equal
    axis tight
%     drawnow
    
    subplot(1,2,2); hold on;
    
    %Top
    rectangle('Position',[-2 -2 4 4],'Curvature',[1 1],'FaceColor',[data(15) data(15) data(15)])
    
    %left
    fill([-4.5 -2.5 -2.5 -4.5],[-4 -2 2 4],[data(20) data(20) data(20)])
    fill([-7 -5 -5 -7],[-6.5 -4.5 4.5 6.5],[data(19) data(19) data(19)])
    
    %right
    fill([4.5 2.5 2.5 4.5],[-4 -2 2 4],[data(17) data(17) data(17)])
    fill([7 5 5 7],[-6.5 -4.5 4.5 6.5],[data(16) data(16) data(16)])
    
    %top
    fill([-4 -2 2 4],[4.5 2.5 2.5 4.5],[data(22) data(22) data(22)])
    fill([-6.5 -4.5 4.5 6.5],[7 5 5 7],[data(21) data(21) data(21)])
    
    %bottom
    fill([-4 -2 2 4],[-4.5 -2.5 -2.5 -4.5],[data(14) data(14) data(14)])
    fill([-6.5 -4.5 4.5 6.5],[-7 -5 -5 -7],[data(18) data(18) data(18)])
    
    
    axis equal
    axis tight
    drawnow

end
    

fclose(s)
delete(s)
clear s