clc

rowLength=30;
remoteIP='128.148.110.217';

%Open connection if necessary
try
    if isempty(u)
        u=udp(remoteIP, 8888,'LocalPort', 6000);
    else
        fclose(u)
    end
catch
    u=udp(remoteIP, 8888,'LocalPort', 6000);
end
    
%Set UDP properties
u.DatagramTerminateMode='on'; %If off, will read everything in buffer, not just one packet
u.inputBufferSize=2048;
fopen(u);
fwrite(u, 1);
pause(0.5)

data=[];
figure; hold on;
axis tight
ylim([0 500])
while 1==1
    while u.BytesAvailable >= rowLength
        new=fread(u,rowLength,'uchar')';
        data = [data; uint8(new)];
    end
    
    %Limit size to ~600,000 rows, around 3 hours
    if size(data,1)>620000
        data=data(20000:end,:);
    end
    
    %Calculate time
    % b=double(data(:,2)).*255+double(data(:,3));
    % b=b/1000;
    
    if ~isempty(data)
        cla
        
        left=double(data(max([1 size(data,1)-200]):end,4:15));
        right=double(data(max([1 size(data,1)-200]):end,19:30));
        
        
        plot([left right+200]) %Plot the last 200 points
%         plot(right) %Plot the last 200 points
        drawnow;
    end
end

fclose(u);
