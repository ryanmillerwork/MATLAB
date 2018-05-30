%This function is intended to read n points of data from two attached objects and match them to objects in the "objectInfo" database

n=100;
load C:\Users\Ryan\Documents\MATLAB\SVGCreator\objectInfo

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
fwrite(u, 'a');
fwrite(u, 'A');
pause(0.1)
fwrite(u, '-');
pause(0.5)

data=[];
% figure; hold on;
% axis tight
% ylim([0 500])
cont=1;
while cont
    while u.BytesAvailable >= rowLength
        new=fread(u,rowLength,'uchar')';
        data = [data; uint8(new)];
    end
        
    %Limit size to ~600,000 rows, around 3 hours
    if size(data,1)>n
        cont=0;
    end
    

    
    %Calculate time
    % b=double(data(:,2)).*255+double(data(:,3));
    % b=b/1000;
    
%     if ~isempty(data)
%         cla
%         
%         left=double(data(max([1 size(data,1)-200]):end,4:15));
%         right=double(data(max([1 size(data,1)-200]):end,19:30));
%         
%         
%         plot([left right+200]) %Plot the last 200 points
% %         plot(right) %Plot the last 200 points
%         drawnow;
%     end
end

fclose(u);

left=mean(double(data(:,4:15)));
right=mean(double(data(:,19:30)));


%% compute correlation with each object in database
matchMat=[];
for i=1:size(objectInfo,2)
    this=objectInfo(i).calibration;
    temp=corrcoef(left,this);
    leftR=temp(1,2);
    
    temp=corrcoef(right,this);
    rightR=temp(1,2);
    
    matchMat=[matchMat; leftR rightR];
end

%% Find match and plot
[a leftID]=max(matchMat(:,1));
[a rightID]=max(matchMat(:,2));

figure; subplot(1,2,1); hold on; axis equal; title('Left')
plot(objectInfo(leftID).points(:,1),objectInfo(leftID).points(:,2))


subplot(1,2,2); hold on; axis equal; title('Right')
plot(objectInfo(rightID).points(:,1),objectInfo(rightID).points(:,2))