function result=compilePiles(masterpile,thisChan,thisSort,options)
%% Compute difference


ppd=59; %Pixels per degree
screenWidth=32.467;

pile=masterpile(:,:,1);
pileR1=masterpile(:,:,2);
pileR2=masterpile(:,:,3);




d1=double(pileR1)-double(pileR2);


%Plot result
figure; hold on;


aveRefPile=mean(cat(3,double(pileR1),double(pileR2)),3);
difference=double(pile)-aveRefPile;
difference=difference/max(max(abs(d1)));

difference = imgaussfilt(difference,ppd);

low=min(min(difference));
high=max(max(difference));
difference(1,1)=max(abs([low high]));
difference(end,1)=max(abs([low high]))*-1;

imagesc(flipud(difference))
colorbar


title(['Channel: ' num2str(thisChan) ' Sort: ' num2str(thisSort)])


%Plot circles

plot(1920,1080,'.y')

x=1920;
y=1080;
r=1920/screenWidth*10;

ang=0:0.01:2*pi;
xp=r*cos(ang);
yp=r*sin(ang);
plot(x+xp,y+yp,'y:');

r=1920/screenWidth*20;

ang=0:0.01:2*pi;
xp=r*cos(ang);
yp=r*sin(ang);
plot(x+xp,y+yp,'y:');

xlim([1 size(pile,2)])
ylim([1 size(pile,1)])

drawnow

result=0;