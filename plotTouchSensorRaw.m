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
    out = fscanf(s);
    start=strfind(out,'Debug Initialized');
    if ~isempty(start)
        out=out(start:end);
        disp(out)
    end
end

disp('Lets get this party started')

%% Go through the debug messages
while out(1)=='D'
    out = fscanf(s);
    if out(1)=='D'
        disp(out)
    end
end
disp('Debug complete')

%% Now we're getting the data. Plot it.

%Create a baseline for the measurements from the first 
data=str2num(out);
baselineMat=data;
for i=1:9
    out = fscanf(s);
    data=str2num(out);
    baselineMat(i,:)=data;
end
baseline=mean(baselineMat);
baseline(1)=baselineMat(end,1); %Time is last measurement

%Start collecting and plotting actual data, baseline subtracted.
dataMat=repmat(data,100,1);

figure; 
counter=1;
for i=1:5000
    
    cla
    plot(dataMat(:,2:13))
    ylim([-0.5 12.5])
    drawnow
    
    out = fscanf(s);
    data=str2num(out);
    
    if length(data)~=correctLength
        disp(data)
        continue;
    end
    data=data-baseline;
    data(2:end)=data(2:end)/250;
    data(2:25)=data(2:25)+linspace(1,24,24);
    
    counter=counter+1;
    dataMat(counter,:)=data;
    if counter==100
        counter=counter-1;
        dataMat(1:99,:)=dataMat(2:100,:);
    
    end
end
    

fclose(s)
delete(s)
clear s