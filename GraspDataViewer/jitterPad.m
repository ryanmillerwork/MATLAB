function filtered = jitterPad(filtered,angle,xshift,yshift)

% angle=10;
% xshift=50;
% yshift=50;

cutoutsize=7;

bm = filtered > 0; % find indices of edge
[rows, cols] = ndgrid(1:size(filtered, 1), 1:size(filtered, 2));
rowcentre = round(sum(rows(bm) .* filtered(bm)) / sum(filtered(bm)));  % row of center of mass
colcentre = round(sum(cols(bm) .* filtered(bm)) / sum(filtered(bm)));  % column of center of mass
cutout=filtered(rowcentre-cutoutsize:rowcentre+cutoutsize,colcentre-cutoutsize:colcentre+cutoutsize); % Grab region around object

rowmin=rowcentre-cutoutsize+yshift;
rowmax=rowcentre+cutoutsize+yshift;
colmin=colcentre-cutoutsize+xshift;
colmax=colcentre+cutoutsize+xshift;

if angle ~= 0
    rot=imrotate(cutout,angle,'crop'); %Rotate
    filtered(rowmin:rowmax,colmin:colmax)=rot; %Paste in rotate version, shifted
else
    filtered(rowmin:rowmax,colmin:colmax)=cutout; %Paste in rotate version, shifted
end

% figure;
% imagesc(filtered)
% colormap(gray)
% axis equal