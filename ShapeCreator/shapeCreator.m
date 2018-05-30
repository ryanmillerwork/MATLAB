clear




% theta = linspace(0, 2*pi, 100);
% x1 = cos(theta) - 0.5;
% y1 = -sin(theta);    % -sin(theta) to make a clockwise contour
% x2 = x1 + 1;
% y2 = y1;
% [xa, ya] = polybool('union', x1, y1, x2, y2);
% 
% 
% subplot(2, 2, 1)
% patch(xa, ya, 1, 'FaceColor', 'r')
% axis equal, axis off, hold on
% plot(x1, y1, x2, y2, 'Color', 'k')
% title('Union')
% 
% return
% 
% 
% 

warning('off','all')




%Create some points
npoints=4;
npolys=3;
scale=1;

blobs={};

figure; hold on; xlim([-1.5 1.5]); ylim([-1.5 1.5])
for i=1:npolys
    thetas=rand(npoints,1)*2*pi;
    thetas=sort(thetas);
    
    rhos=rand(npoints,1)*scale/2+scale/2;
    
    
    [x,y] = pol2cart(thetas,rhos);
    
    x(end+1)=x(1);
    y(end+1)=y(1);
    
    
    fnplt(cscvn([x';y']))
    c=fnplt(cscvn([x';y']));
    
    blobs{i}=c;
    
    plot(x,y,'o')
    fill(c(1,:),c(2,:),'r')
    
    pause(1)
end

shapes={};

figure;
for i=1:45 %iteration
    subplot(5,9,i); hold on; axis off; axis equal
    
    one=blobs{1};
    two=blobs{2};
    three=blobs{3};
    
    
    %order to rotate
    order=randperm(npolys,npolys);
    
    % amount to rotate
    rotate1=round(rand(1)*90)+90; %Can be anywhere between 0 and 180
    rotate2=round(rand(1)*-180); %can be between 0 and -180
    rotate3=-1*(rotate1+rotate2); %Equal to opposite of sum of previous two so total angle adds up to 0
    
    one=blobs{order(1)};
    two=blobs{order(2)};
    three=blobs{order(3)};
    
    
    %rotate
    [one_x_r, one_y_r]=rotatePoints(one(1,:)',one(2,:)',rotate1,0,0);
    [two_x_r, two_y_r]=rotatePoints(two(1,:)',two(2,:)',rotate2,0,0);
    [three_x_r, three_y_r]=rotatePoints(three(1,:)',three(2,:)',rotate3,0,0);
    
    %translate
%     one_x_r=one(1,:)+randn(1)/10;
%     one_y_r=one(2,:)+randn(1)/10;
%     
%     two_x_r=two(1,:)+randn(1)/10;
%     two_y_r=two(2,:)+randn(1)/10;
%     
%     three_x_r=three(1,:)+randn(1)/10;
%     three_y_r=three(2,:)+randn(1)/10;
    
    [xa, ya] = polybool('union', one_x_r,one_y_r, two_x_r, two_y_r);
    [xa, ya] = polybool('union', xa, ya, three_x_r, three_y_r);
    
    patch(xa, ya, 1, 'FaceColor', 'r','LineStyle','none')
    
    shapes{i}={xa ya};
    
%     pause(1)
end
drawnow


results=[];
for i=1:size(shapes,2)
   for ii=1:size(shapes,2)
       a=cell2mat(shapes{i});
       b=cell2mat(shapes{ii});
       [xa, ya] = polybool('intersection', a(:,1), a(:,2), b(:,1), b(:,2));
       [xb, yb] = polybool('union', a(:,1), a(:,2), b(:,1), b(:,2));
       
       areainter=polyarea(xa, ya);
       areaunion=polyarea(xb,yb);
    
       results(i,ii)=areainter/areaunion;
       
   end
end

% warning('on','all')


summed=min(results,[],1);
% sorted=sort(summed);
% sorted=sorted(1:5);

[sorted_x, index] = sort(summed,'ascend');

% for i=1:5
%    subplot(5,9,index(i)); title('Unique') 
% end
% for i=size(index,2)-4:size(index,2)
%    subplot(5,9,index(i)); title('Typical') 
% end



%Find most unusual shapes
unusual=1;
subplot(5,9,unusual); title('Unique') 
for i=1:7
    diffs=max(results(unusual,:),[],1);
%     small=find(diffs==min(diffs));
    [sorted_x, index] = sort(diffs,'ascend');
    for ii=1:length(index)
        if ~ismember(index(ii),unusual)
            unusual=[unusual index(ii)];
            break;
        end
    end
    subplot(5,9,unusual(end)); title('Unique') 
end

figure;
for i=1:size(unusual,2)
    subplot(2,4,i); hold on; axis off; axis equal; xlim([-1.5 1.5]); ylim([-1.5 1.5])
    this=cell2mat(shapes{unusual(i)});
    
    
    patch(this(:,1), this(:,2), 1, 'FaceColor', 'r','LineStyle','none')
    
end





figure; imagesc(results)

% patch('Faces', f, 'Vertices', v, 'FaceColor', 'r', 'EdgeColor', 'none')
% axis equal, axis off, hold on
% plot(x1, y1, x2, y2, 'Color', 'k')
% title('Exclusive Or')

