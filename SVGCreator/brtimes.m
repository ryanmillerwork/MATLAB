start=8/24; %8 oclock
stop=18/24; %6 oclock
step=.25/24; %15 minute steps
% window=30/60/24; %30 minute window (x2)
window=20/60/24; %20 minute window (x2)



figure; hold on;
plot(a(:,1)*24,a(:,2),'.')
for i=start:step:stop
   these=a(a(:,1)>(i-window) & a(:,1)<(i+window),:);
    
   ave=mean(these(:,2));
%    if size(these,1)>4
    plot(i*24,ave,'ro')
%    end
end


xlim([start*24 stop*24])