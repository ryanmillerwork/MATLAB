% function filtered = getPadJittered(table,pad,angle,xshift,yshift)


table=10;
pad=7;
angle=-10;
xshift=-13;
yshift=-27;

conn = sqlite('L:\stimuli\grasp\objects.db');
mat=fetch(conn,['SELECT x,y,val FROM padFilter' num2str(table) ' WHERE Pad = "' num2str(pad) '"']);
close(conn)


filtered=zeros(1000,1000);

xs=cell2mat(mat(:,1));
ys=cell2mat(mat(:,2));
vals=cell2mat(mat(:,3));
inds=sub2ind(size(filtered), ys, xs);

filtered(inds)=vals;

figure;
imagesc(filtered)
colormap(gray)
axis equal




%% test

originalmatrix = filtered;
% originalmatrix(4:7, 4:7) = 2         %semicolon missing for display
binarisedmatrix = originalmatrix > 0; %semicolon missing for display
[rows, cols] = ndgrid(1:size(originalmatrix, 1), 1:size(originalmatrix, 2));
rowcentre = round(sum(rows(binarisedmatrix) .* originalmatrix(binarisedmatrix)) / sum(originalmatrix(binarisedmatrix)));  %semicolon missing for display
colcentre = round(sum(cols(binarisedmatrix) .* originalmatrix(binarisedmatrix)) / sum(originalmatrix(binarisedmatrix)));  %semicolon missing for display

cutout=filtered(rowcentre-200:rowcentre+200,colcentre-200:colcentre+200);

% figure;
% imagesc(cutout)
% colormap(gray)
% axis equal
% 
% 
rot=imrotate(cutout,angle,'crop');
% 
% figure;
% imagesc(rot)
% colormap(gray)
% axis equal

filtered(rowcentre-200+yshift:rowcentre+200+yshift,colcentre-200+xshift:colcentre+200+xshift)=rot;

figure;
imagesc(filtered)
colormap(gray)
axis equal