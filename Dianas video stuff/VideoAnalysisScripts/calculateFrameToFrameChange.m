%Read in CSV with info about clips needed
fid = fopen('PlanetEarthShortList02.csv');
line={};
line=[line; textscan(fid, '%s%s%s%s%s%s', 1, 'delimiter',',')];
i=1;
while ~isempty(line{i,1})
    line=[line; textscan(fid, '%s%s%s%s%d%d', 1, 'delimiter',',')];
    i=i+1;
end
line=line(1:end-1,:);
fclose(fid)


% read in list of files that are already done
list=ls('*delta.avi');

% Loop through line, check if file has been done already, and do it if not

for i=2:size(line,1)
    file=char(line{i,1});
    file=[file(1:end-3) 'avi'];
    clip=char(line{i,2})
    start=double(line{i,5});
    stop=double(line{i,6});
    
    present=0;
    for ii=1:size(list,1)
        if findstr(list(ii,:),clip)
            present=1;
        end
    end
    if present
        continue;
    end
    
    
    
    
    v=VideoReader(file);
    vW = VideoWriter([clip 'delta.avi']);
    vW.FrameRate = 25;
    
    
    frameStart=start;    %Frame number to jump to
    frameStop=stop;
    timePerFrame=40;    %Inter-frame interval (ms; 40 for 25 Hz)
    
    v.CurrentTime = timePerFrame*frameStart/1000; %Time in seconds to move to
    
    
    vidFrames = zeros(1080,1920,15); %initialize matrix that will hold 4 frames of rgb data
    
    %Read in first three frames
    % vidFrames(:,:,4:6)  =   readFrame(v);
    % vidFrames(:,:,7:9)  =   readFrame(v);
    disp(['Read: ' num2str(v.CurrentTime*25)])
    vidFrames(:,:,13:15)=   readFrame(v);
    
    distanceMat(:,:,1)=zeros(size(vidFrames,1),size(vidFrames,2));
    distanceMat(:,:,2)=zeros(size(vidFrames,1),size(vidFrames,2));
    distanceMat(:,:,3)=zeros(size(vidFrames,1),size(vidFrames,2));
    distanceMat(:,:,4)=calcChange(vidFrames(:,:,10:12),vidFrames(:,:,13:15));
    
    change=distanceMat(:,:,4) + distanceMat(:,:,3)./2 + distanceMat(:,:,2)./4 + distanceMat(:,:,1)./8;
    counter=1;
    
    tic
    
    open(vW)
    while hasFrame(v) & v.CurrentTime <= (timePerFrame*frameStop/1000)
        
        image(change.*255)
        
        writeVideo(vW,change)
        
        %Update frames
        vidFrames(:,:,1:12)=vidFrames(:,:,4:15);
        disp(['Read: ' num2str(v.CurrentTime*25)])
        vidFrames(:,:,13:15)=   readFrame(v);
        
        %Do math
        %Calculate distance on each change
        
        
        distanceMat(:,:,1)=distanceMat(:,:,2);
        distanceMat(:,:,2)=distanceMat(:,:,3);
        distanceMat(:,:,3)=distanceMat(:,:,4);
        distanceMat(:,:,4)=calcChange(vidFrames(:,:,10:12),vidFrames(:,:,13:15));
        counter=counter+1;
        
        change=distanceMat(:,:,4) + distanceMat(:,:,3)./2 + distanceMat(:,:,2)./4 + distanceMat(:,:,1)./8;
        
        %Need to normalize by maximum possible change values
        if counter==2
            change=change/1.5;
        elseif counter==3
            change=change/1.75;
        elseif counter>3
            change=change/1.875;
        end
        
        
        
        
    end
    
    image(change.*255)
    writeVideo(vW,change)
    toc
    
    close(vW)
    
end