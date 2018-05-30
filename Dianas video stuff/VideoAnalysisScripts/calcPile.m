function pile=calcPile(pile, wait, mspf, lag, rasterDur, rasters, i, v, yRange, xRange)

%Step through each column of this raster, count spikes, and add to pile
for ii=wait:mspf:rasterDur-mspf
    startTime=ii;
    stopTime=ii+mspf-1;
    sp=sum(sum(rasters(:,startTime:stopTime,i)));
    if sp>0 %If there is at least one spike during this frame (time adjusted)
        
        v.CurrentTime=(ii-mspf-lag)/1000; %Move to start of appropriate frame
        video = uint32(readFrame(v)); %Read next frame after currentTime
        video = video(:,:,1); %All channels are the same
        video = video .* sp;  %Multiply by the number of spikes in this frames time window
        
        pile(yRange(1):yRange(2),xRange(1):xRange(2))=pile(yRange(1):yRange(2),xRange(1):xRange(2))+video;
        
    end
    
end