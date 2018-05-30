function putCustomShapesInDB(points, id)

%Divy 'points' up into pad numbers
pad=0;
for i=1:size(points,1)
    if points(i,3)==0
        pad=pad+1;
    end
    pads(1,i)=pad;
end

%Connect
conn = sqlite('L:\stimuli\grasp\objects.db');

%create other tables for this object
createShapeTable = ['create table shapeTable' id ' (x NUMERIC, y NUMERIC, pad NUMERIC)'];
exec(conn,createShapeTable)

%Populate shapeTable
colnames={'x','y','pad'};
values={points(:,1) points(:,2) pads};
insert(conn,['shapeTable' id], colnames, values);

close(conn); %close the connection to the database





