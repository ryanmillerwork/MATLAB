% this is a set of scripts that work with finding circles which encompass certain portions of blobs from teh objects database. method 3 was used to populate 'circlesTable'



%% Method 1: Takes in shape from database, finds a circle which doesnt overlap 'keepout' area but does overlap a certain percentage of the shape outline

shapeID='11';
overlapRange=[.3 .6]; %circle will overlap this range of the points (proportion)

% Read in shape from database
conn = sqlite('L:\stimuli\grasp\objects.db');
shape=double(cell2mat(fetch(conn, ['Select x,y FROM shapeTable' shapeID])));
close(conn);

% manually add 'keepout' zone as third column
shape=[shape zeros(size(shape,1),1)];
shape(1:100,3)=1;

% Find a match
minPts=size(shape,1) * overlapRange(1); %given the number of pts in this shape, calculate minimum number of pts we need inside circle
maxPts=size(shape,1) * overlapRange(2); %given the number of pts in this shape, calculate maximum number of pts we need inside circle
keepout=shape(shape(:,3)==1,1:2);
keepin=shape(shape(:,3)==0,1:2);
tic
figure; hold on;
plot(keepout(:,1),keepout(:,2),'r')
plot(keepin(:,1),keepin(:,2),'g')
for o=1:100
    %while loop takes 1.3-1.5 ms each when doing it 1000 times
    match=0;
    while match==0
        %Pick a circle center and radius
        x=randn(1);
        y=randn(1);
        r=abs(randn(1))/5;
        
        %Make sure that circle doesnt overlap any of the keepout area
        dists=pdist2([x,y],keepout);
        if sum(dists < r) > 0  %if we violated keepout rule, start over
            continue;
        end
        
        %Make sure that circle DOES overlap the correct proportion
        dists=pdist2([x,y],keepin);
        inCircle=sum(dists < r);
        if inCircle > minPts && inCircle < maxPts %if we did not violate keepin rule
            in=keepin(dists<r,:);
            match=1;
        end
    end
    
    % Plot
    
    % subplot(1,2,1); hold on; xlim([-1 1]); ylim([-1 1]); axis square
    % plot(keepout(:,1),keepout(:,2),'r')
    % plot(keepin(:,1),keepin(:,2),'g')
    % viscircles([x,y],r)
    %
    % subplot(1,2,2);
    xlim([-1 1]); ylim([-1 1]); axis square
    a=plot(in(:,1),in(:,2),'k','LineWidth',10);
    a.Color=[0,0,0,0.01];
end
toc

%% Method 2: Choose edges of circle as edges of shape pads and draw a circle


conn = sqlite('L:\stimuli\grasp\objects.db');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%try fit circle through 3 points
% [r c]=fit_circle_through_3_points([0 0; 1 1; 0 2])






% shapes=unique(cell2mat(fetch(conn, 'Select ID FROM locationTable')));



%input variables
shapeID='11';
shape=fetch(conn, ['Select x,y,pad FROM shapeTable' shapeID]);
shape=[double(cell2mat(shape(:,1:2))) double(cell2mat(shape(:,3)))];


nPadsShow=12;            %number of contiguous pads to show in full
dontshow=[];     %list of pads to not show any part of. increasing clockwise order (e.g., [1 2] or [7 8] or [12 1])

if (nPadsShow + length(dontshow) + 2) > 12
    disp('agh we cant do that')
    return;
end

%make list of sets of keepinpads
sets=setdiff(1:12,dontshow)';
for i=2:nPadsShow
    sets=[sets padWrap(sets(:,end)+1,12)];
end

% remove sets which violate keep out rules
avoid=[padWrap(dontshow(1)-1,12) dontshow padWrap(dontshow(end)+1,12)];
[rows,~]=find(ismember(sets,avoid));

sets(rows,:)=[];



%pick a set of pads to show
keepinpads=sets(randperm(size(sets,1),1),:);
keepoutpads=setdiff(1:12,[padWrap(keepinpads(1)-1,12) keepinpads padWrap(keepinpads(end)+1,12)]);

% grab portions of shape that must not be shown and portions that must be shown
keepout=shape(ismember(shape(:,3),keepoutpads),1:2);
keepin=shape(ismember(shape(:,3),keepinpads),1:2);

% Find a match
match=0;
while match==0
    %Pick a circle center and radius
    x=randn(1);
    y=randn(1);
    r=abs(randn(1))/2;
    
    %Make sure that circle doesnt overlap any of the keepout area
    dists=pdist2([x,y],keepout);
    if sum(dists < r) > 0  %if we violated keepout rule, start over
        continue;
    end
    
    %Make sure that circle DOES overlap the correct proportion
    dists=pdist2([x,y],keepin);
    inCircle=sum(dists < r);
    if inCircle == size(keepin,1) %if we did not violate keepin rule
        distsAll=pdist2([x,y],shape(:,1:2));
        in=shape(distsAll<r,1:2);
        match=1;
    end
end

p1=[keepin(1,1) keepin(1,2)];
p2=[keepin(end,1) keepin(end,2)];
p3=[2 2];
% [r c]=fit_circle_through_3_points([p1;p2;p3])



        

       
% Plot

subplot(1,2,1); hold on; xlim([-1 1]); ylim([-1 1]); axis square
plot(keepout(:,1),keepout(:,2),'r')
plot(keepin(:,1),keepin(:,2),'g')
viscircles([x,y],r);

% viscircles(c',r);

subplot(1,2,2);
hold on; xlim([-1 1]); ylim([-1 1]); axis square
a=plot(in(:,1),in(:,2),'k','LineWidth',2);
drawnow
%     a.Color=[0,0,0,0.01];


toc

close(conn);

%% Method 3: Ignore keep out, make exhaustive list of circles around every possible set of pads and put in database


conn = sqlite('L:\stimuli\grasp\objects.db');


shapes=unique(cell2mat(fetch(conn, 'Select ID FROM locationTable')));

%input variables
for qwer = 1:5
    datetime('now')
for s=1:size(shapes,1)
    shapeID=num2str(shapes(s));
    shape=fetch(conn, ['Select x,y,pad FROM shapeTable' shapeID]);
    shape=[double(cell2mat(shape(:,1:2))) double(cell2mat(shape(:,3)))];
    
    for nPadsShow = 1:12
        cla
        
        %make list of sets of keepinpads
        sets=[1:12]';
        for i=2:nPadsShow
            sets=[sets padWrap(sets(:,end)+1,12)];
        end
        
        for setChoice=1:size(sets,1)
            %pick a set of pads to show
            keepinpads=sets(setChoice,:);
            marginpads=[padWrap(keepinpads(1)-1,12) padWrap(keepinpads(end)+1,12)];%pad to left and right
            marginpads=setdiff(marginpads,keepinpads);  %margin pad that isnt part of keepinpads
            keepoutpads=setdiff(1:12,[keepinpads marginpads]); %numers 1-12 that arent part of keepin or margin

            % grab portions of shape that must not be shown and portions that must be shown
            keepout=shape(ismember(shape(:,3),keepoutpads),1:2);
            margins=shape(ismember(shape(:,3),marginpads),1:2);
            keepin=shape(ismember(shape(:,3),keepinpads),1:2);
            
            % Find a match
            match=0;
            tic
            while match==0
                %only try for 10 seconds
                if toc > 20
                    disp(['skipping ID ' shapeID ' pads ' num2str(keepinpads)])
                    match=1;
                end
                
                %Pick a circle center and radius
                x=randn(1)/3;
                y=randn(1)/3;
                r=abs(randn(1))/3;
                
                %Make sure that circle doesnt overlap any of the keepout area
                dists=pdist2([x,y],keepout);
                if sum(dists < r) > 0  %if we violated keepout rule, start over
                    continue;
                end
                
                %Make sure that circle clips through some of the margins
                if ~isempty(margins) %will be empty if we want to show all 12 pads
                    dists=pdist2([x,y],margins);
                    if sum(dists < r) == length(dists)  %if we violated margins rule, start over
                        continue;
                    end
                end
                
                %Make sure that circle DOES overlap the correct proportion
                dists=pdist2([x,y],keepin);
                inCircle=sum(dists < r);
                if inCircle == size(keepin,1) %if we did not violate keepin rule
                    distsAll=pdist2([x,y],shape(:,1:2));
                    in=shape(distsAll<r,1:2);
                    match=1;
                    
                    %put in database
                    colnames = {'blobID', 'nPads', 'firstPad', 'lastPad','xc','yc','r'};
                    values=[str2num(shapeID) length(keepinpads) keepinpads(1) keepinpads(end) x y r];
                    insert(conn,'circlesTable',colnames, values)
                    
                    hold on; xlim([-1 1]); ylim([-1 1]); axis square
                    plot(keepout(:,1),keepout(:,2),'r')
                    plot(keepin(:,1),keepin(:,2),'g')
                    plot(margins(:,1),margins(:,2),'b')
                    viscircles([x,y],r);
                    drawnow
                    
                end
            end
        end
    end
end

end

close(conn);

%% Plot circle and shape from db
circleID=2699;

conn = sqlite('L:\stimuli\grasp\objects.db');
shapeID=double(cell2mat(fetch(conn, ['Select blobID FROM circlesTable WHERE circleID = ' num2str(circleID)])));             %shape id for this circle
shape=double(cell2mat(fetch(conn, ['Select x,y FROM shapeTable' num2str(shapeID)])));                                       %shape xs and ys
pads=double(cell2mat(fetch(conn, ['Select pad FROM shapeTable' num2str(shapeID)])));                                        %pad number for each x and y
cparams=double(cell2mat(fetch(conn, ['Select xc,yc,r FROM circlesTable WHERE circleID = ' num2str(circleID)])));            %circle parameters x y and r
margins=double(cell2mat(fetch(conn, ['Select firstPad,lastPad FROM circlesTable WHERE circleID = ' num2str(circleID)])));   %first and last pad wholly included in circle
close(conn);

padChanges=[1; find(diff(pads))]; %rows where pad number changes

cla; hold on; axis equal; xlim([-1 1])
plot(shape(:,1),shape(:,2))                                     %plot shape
plot(shape(padChanges,1),shape(padChanges,2),'.k')              %mark edges of pads
plot(shape(pads==margins(1),1),shape(pads==margins(1),2),'g')   %plot first pad wholly within circle
plot(shape(pads==margins(2),1),shape(pads==margins(2),2),'r')   %plot last pad wholly within circle
viscircles([cparams(1),cparams(2)],cparams(3));                 %plot circle





%% plot all circles
conn = sqlite('L:\stimuli\grasp\objects.db');
cparams=double(cell2mat(fetch(conn, 'Select xc,yc,r FROM circlesTable')));            %circle parameters x y and r
close(conn);

figure; hold on;
for i=1:size(cparams,1)
    viscircles([cparams(i,1),cparams(i,2)],cparams(i,3));                 %plot circle 
end
