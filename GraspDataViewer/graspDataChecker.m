clear all
tic
DataDB = sqlite('C:\Users\Ryan\Documents\Data\graspHuman.db');
ids=double(cell2mat(fetch(DataDB, 'SELECT UniqueTrial FROM trialsTable')));

for i=24%:size(ids,1)
    trial=num2str(ids(i));
    
    try
        fetch(DataDB, ['Select TrialPeriod FROM graspTable' trial ' WHERE TrialPeriod IS NOT NULL']);
    catch
%         exec(DataDB, ['ALTER TABLE graspTable' trial ' ADD COLUMN TrialPeriod NUMERIC']);
    end
    
    rt=double(cell2mat(fetch(DataDB, ['SELECT ResponseTime FROM trialsTable WHERE UniqueTrial = ' trial])));
    try
        times=double(cell2mat(fetch(DataDB, ['SELECT Time_1 FROM graspTable' trial])));
        
        diffs=diff(times);
        tp=ones(size(times));
        tp(1:find(diffs<0))=0;
        tp(times>(rt-100))=2;
        for ii=1:length(times)
            exec(DataDB,['UPDATE graspTable' trial ' SET TrialPeriod = "' num2str(tp(ii)) '" WHERE Time_1 = ' num2str(times(ii))])
        end
    catch
        times=double(cell2mat(fetch(DataDB, ['SELECT Time_2 FROM graspTable' trial])));
        
        diffs=diff(times);
        tp=ones(size(times));
        tp(1:find(diffs<0))=0;
        tp(times>(rt-100))=2;
%         for ii=1:length(times)
%             exec(DataDB,['UPDATE graspTable' trial ' SET TrialPeriod = "' num2str(tp(ii)) '" WHERE Time_2 = ' num2str(times(ii))])
%         end
        
        oldData=cell2mat(fetch(DataDB, ['Select * FROM graspTable' trial]));
        exec(DataDB,['DROP TABLE graspTable' trial]);
        
        createGraspTable = ['create table graspTable' trial ' (TrialPeriod NUMERIC, stimTime NUMERIC, Time_2 NUMERIC, rawPad2_1 NUMERIC, rawPad2_2 NUMERIC, rawPad2_3 NUMERIC, rawPad2_4 NUMERIC, rawPad2_5 NUMERIC, rawPad2_6 NUMERIC, rawPad2_7 NUMERIC, rawPad2_8 NUMERIC, rawPad2_9 NUMERIC, rawPad2_10 NUMERIC, rawPad2_11 NUMERIC, rawPad2_12 NUMERIC, pctPad2_1 NUMERIC, pctPad2_2 NUMERIC, pctPad2_3 NUMERIC, pctPad2_4 NUMERIC, pctPad2_5 NUMERIC, pctPad2_6 NUMERIC, pctPad2_7 NUMERIC, pctPad2_8 NUMERIC, pctPad2_9 NUMERIC, pctPad2_10 NUMERIC, pctPad2_11 NUMERIC, pctPad2_12 NUMERIC)'];
        exec(DataDB,createGraspTable)
        
        
        newData=[tp oldData];
        
        colnames = {'TrialPeriod', 'stimTime', 'Time_2', 'rawPad2_1', 'rawPad2_2', 'rawPad2_3', 'rawPad2_4', 'rawPad2_5', 'rawPad2_6', 'rawPad2_7', 'rawPad2_8', 'rawPad2_9', 'rawPad2_10', 'rawPad2_11', 'rawPad2_12', 'pctPad2_1', 'pctPad2_2', 'pctPad2_3', 'pctPad2_4', 'pctPad2_5', 'pctPad2_6', 'pctPad2_7', 'pctPad2_8', 'pctPad2_9', 'pctPad2_10', 'pctPad2_11', 'pctPad2_12'};
        insert(DataDB,['graspTable' trial],colnames, newData)
    end
    
    
    
    
    
    
end

close(DataDB)
toc




