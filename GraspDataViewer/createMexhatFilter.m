clear
conn = sqlite('L:\stimuli\grasp\objects.db');

objects=double(cell2mat(fetch(conn,'SELECT blobID FROM objectsTable')));

% return
%
% ID=17; %16 gave one bad trial, i think 18 also




%% Add to database
for ID = objects'
    tic
    for i=1:12
        %get pad data
        mat=fetch(conn,['SELECT * FROM shapeTable' num2str(ID) ' WHERE PAD IS ' num2str(i)]);
        mat=cell2mat(mat(:,1:2));
        mat=round(mat.*800)+500;

        %Put pad in matrix
        f=zeros(1000,1000);
        for ii=1:size(mat,1)
            f(mat(ii,1),mat(ii,2))=1;
        end
        
        %filter
        h=fspecial('log',100,15).*-1;
        filtered = filter2(h, f);
        
%         imagesc(filtered)
%         colormap(gray);
%         axis equal
        
        
        %Add to database
        %Create table if it doesnt exist
%         tableid=num2str(ID);
%         createTable = ['create table IF NOT EXISTS padFilter' tableid ' (pad NUMERIC, x NUMERIC, y NUMERIC, val NUMERIC)'];
%         exec(conn,createTable)
%         
%         [y, x]=find(filtered);
%         nums=filtered(find(filtered));
%         pads=repmat(i,size(x,1),1);
%         
%         colnames = {'pad', 'x', 'y','val'};
%         values=[pads x y nums];        
%         insert(conn,['padFilter' tableid],colnames, values)
%         
    end
    toc
end

close(conn)
return

%% plot

clear
table=17;
pad=2;
angle=10;
xshift=50;
yshift=50;


tableid=num2str(table);

conn = sqlite('L:\stimuli\grasp\objects.db');

mat=fetch(conn,['SELECT x,y,val FROM padFilter' tableid ' WHERE Pad = "' num2str(pad) '"']);


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
rot=imrotate(cutout,10,'crop');
% 
% figure;
% imagesc(rot)
% colormap(gray)
% axis equal

filtered(rowcentre-200+xshift:rowcentre+200+xshift,colcentre-200+yshift:colcentre+200+yshift)=rot;

figure;
imagesc(filtered)
colormap(gray)
axis equal




