% using this script to explore best options for speeding up database

%% test open and close speed. usually every here is under 10 ms except on first open its more like 500 ms
tic;
evalc('DataDB1 = mksqlite(0,''open'', ''C:\Users\Ryan\Documents\Data\graspMonkey.db'')');
open1=num2str(round(toc*1000));

tic;
evalc('DataDB2 = mksqlite(0,''open'', ''C:\Users\Ryan\Documents\Data\graspMonkey.db'')');
open2=num2str(round(toc*1000));

tic;
mksqlite(DataDB1,'close');
mksqlite(DataDB2,'close');
close=num2str(round(toc*1000));

disp(['Open first: ' open1 ' Open second: ' open2 ' Close: ' close])
clear all

%% test select distinct (3668, 2033, 2000, 2014, 2030 ms)
evalc('DataDB1 = mksqlite(0,''open'', ''C:\Users\Ryan\Documents\Data\graspMonkey.db'')');
tic
mksqlite(DataDB1,'SELECT DISTINCT Subject FROM trialsTable');
selectDistinct=num2str(round(toc*1000));

mksqlite(DataDB1,'close');

disp(['Select Distinct: ' selectDistinct])
clear all

%% test select (2013, 2005, 2020, 2048 ms)
evalc('DataDB1 = mksqlite(0,''open'', ''C:\Users\Ryan\Documents\Data\graspMonkeyMain.db'')');
tic
% mksqlite(DataDB1,'SELECT Subject FROM trialsTable WHERE Block LIKE "1"');
mksqlite(DataDB1,'SELECT Subject FROM trialsTable WHERE Block IN (Block)');
% mksqlite(DataDB1,'SELECT Subject FROM trialsTable WHERE Block LIKE ""');
toc
selectDistinct=num2str(round(toc*1000));

mksqlite(DataDB1,'close');

disp(['Select: ' selectDistinct])



%% test getting pragma setings
evalc('DataDB1 = mksqlite(0,''open'', ''C:\Users\Ryan\Documents\Data\graspMonkey.db'')');
% evalc('DataDB1 = mksqlite(0,''open'', ''L:\stimuli\grasp\objects.db'')');
tic;
synch=mksqlite('PRAGMA synchronous') % speed tweak, see sqlite doc
ps=mksqlite('PRAGMA page_size') % speed tweak, see sqlite doc
cs=mksqlite('PRAGMA main.cache_size') % speed tweak, see sqlite doc
lm=mksqlite('PRAGMA locking_mode') % speed tweak, see sqlite doc
ts=mksqlite('PRAGMA temp_store') % speed tweak, see sqlite doc

mksqlite('PRAGMA database_list')
 
toc
mksqlite(DataDB1,'close');
clear all

%% read all tables (2151 2136 2184 2187 2196 ms)
evalc('DataDB1 = mksqlite(0,''open'', ''C:\Users\Ryan\Documents\Data\graspMonkeyMain.db'')');
tic;
tables = mksqlite('show tables');
getTables=num2str(round(toc*1000));
mksqlite(DataDB1,'close');
disp(['Get all tables: ' getTables])
clear all

%% compare with matlab interface (2133 2135 2173 2090)

conn = sqlite('C:\Users\Ryan\Documents\Data\graspMonkeyMain.db','readonly');

tic
curs = fetch(conn,'SELECT Subject FROM trialsTable')
selectDistinct=num2str(round(toc*1000));

close(conn)
disp(['Select: ' selectDistinct])

%% practice attaching. basically no speed difference. attaching database takes a couple seconds just like the first select statement on a new connection takes a few seconds

%10.1 s
DataDB1 = mksqlite(0,'open', 'C:\Users\Ryan\Documents\Data\graspMonkeyMain.db');
graspDB = mksqlite(0,'open', 'C:\Users\Ryan\Documents\Data\graspMonkeyGrasp.db');
tables = mksqlite(graspDB,'SELECT * FROM graspTable1');
tic
for i=1:10000
tables = mksqlite(graspDB,'SELECT * FROM graspTable1');
end
toc
mksqlite('close')



%10.5 s
graspDB = mksqlite(0,'open', 'C:\Users\Ryan\Documents\Data\graspMonkeyGrasp.db');
tables = mksqlite(graspDB,'SELECT * FROM graspTable1');
tic
for i=1:10000
tables = mksqlite(graspDB,'SELECT * FROM graspTable1');
end
toc
mksqlite('close')



%8.8 s
DataDB1 = mksqlite(0,'open', 'C:\Users\Ryan\Documents\Data\graspMonkeyMain.db');
mksqlite(DataDB1,'ATTACH "C:\Users\Ryan\Documents\Data\graspMonkeyGrasp.db" as "Grasp"')

tables = mksqlite(DataDB1,'SELECT * FROM Grasp.graspTable1');
tic
for i=1:10000
tables = mksqlite(DataDB1,'SELECT * FROM Grasp.graspTable1');
end
toc
mksqlite('close')


