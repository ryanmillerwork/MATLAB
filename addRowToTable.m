function addRowToTable(points, chosen, unitsPerMM, pointsPerRad, nContacts, slotDepth, slotWidth, maxWidth, symmetric, pair, leftPair)

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

%add row to objects table
colnames = {'blobName','unitsPerMM','pointsPerRad','nContacts','slotDepth','slotWidth','maxWidth','symmetric','pair','leftPair'};
values = {chosen{1}, unitsPerMM, pointsPerRad, nContacts, slotDepth, slotWidth, maxWidth, symmetric, pair, leftPair};
insert(conn,'objectsTable',colnames, values) %Add the row to the master table
newRow=fetch(conn,'SELECT last_insert_rowid()'); %Grab the unique id that was auto-incremented 
rowString=num2str(newRow{1}); % turn that number into a string

%create other tables for this object
createTables(conn, ['shapeTable' rowString], ['calTable' rowString]) %Send the names to createTables function

%Populate shapeTable
colnames={'x','y','pad'};
values={points(:,1) points(:,2) pads};
insert(conn,['shapeTable' rowString], colnames, values);

%add row to location table
colnames = {'ID','Room','Side','Port'};
values = {rowString, 'RyanDesktop', -1, -1};
insert(conn,'locationTable',colnames, values) %Add the row to the master table

close(conn); %close the connection to the database