function createTables(conn, shapeTable, calTable)

createShapeTable = ['create table ' shapeTable ' (x NUMERIC, y NUMERIC, pad NUMERIC)'];
createCalTable = ['create table ' calTable ' (calNum NUMERIC, pad NUMERIC, channel NUMERIC, minVal NUMERIC, maxVal NUMERIC, notes TEXT)'];

exec(conn,createShapeTable)
exec(conn,createCalTable)