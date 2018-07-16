%% Find difference in probability of correct answer when each pad is touched



clear all
%% Connect to DBs
db='C:\Users\Ryan\Documents\Data\graspMonkeyMain.db';
evalc('DataDB = mksqlite(0,''open'', db)'); %evalc to suppress annoying version info being printed
mksqlite(DataDB,'ATTACH "C:\Users\Ryan\Documents\Data\graspMonkeyGrasp.db" as "Grasp"');

evalc('ObjectsDB = mksqlite(0,''open'', ''L:\stimuli\grasp\objects.db'')'); %evalc to suppress annoying version info being printed

mksqlite( 'result_type', 2 );  % 0: array of structs, 1:struct of arrays, 2: (cell) matrix

%% Select trials to analyze
side=0; %0 for left, 1 for right

dates='6132018';
dates='6082018, 6072018';

% visID='SampleID';
visID='36';

visAngle='SampleRotation';

% leftID='Choice1ID';
leftID='36';

leftAngle='Choice1Rotation';
% leftAngle='40';

rightID='Choice2ID';
% rightID='37';

rightAngle='Choice2Rotation';


results=[];
for la=0:10:160
    leftAngle=num2str(la);
    trials=mksqlite(DataDB, ['SELECT UniqueTrial, Answer, Response FROM trialsTable WHERE Date IN (' dates ') AND SampleID IN (' visID ') AND SampleRotation IN (' visAngle ') AND Choice1ID IN (' leftID ') AND Choice1Rotation IN (' leftAngle ')  AND Choice2ID IN (' rightID ') AND Choice2Rotation IN (' rightAngle ')']);
    
    %% Grab grasp data and find which pads are touched for each trial
    tmat=nan(size(trials,1),12); %This matrix will hold list of pads which were touched for each trial
    
    for i=1:size(trials,1)
        if side==0
            pads=mksqlite(DataDB,['SELECT pctPad1_1,pctPad1_2,pctPad1_3,pctPad1_4,pctPad1_5,pctPad1_6,pctPad1_7,pctPad1_8,pctPad1_9,pctPad1_10,pctPad1_11,pctPad1_12 FROM Grasp.graspTable' num2str(trials(i,1)) ' WHERE TrialPeriod = 1']);
        else
            pads=mksqlite(DataDB,['SELECT pctPad2_1,pctPad2_2,pctPad2_3,pctPad2_4,pctPad2_5,pctPad2_6,pctPad2_7,pctPad2_8,pctPad2_9,pctPad2_10,pctPad2_11,pctPad2_12 FROM Grasp.graspTable' num2str(trials(i,1)) ' WHERE TrialPeriod = 1']);
        end
        
        tmat(i,:)=sum(pads>15)>0; 
    end
    
    %% Step through each pad, break it out into correct and incorrect trials, calculate % correct for each
    correct=trials(:,2)==trials(:,3);    
    for i=1:12
        touched=find(tmat(:,i));                            %trials when this pad was touched
        nottouched=find(~tmat(:,i));
        
        if length(touched) > 4 && length(nottouched) > 4    %make sure there are at least 5 instances of each            
            yes=correct(touched);                           %outcome on trials when this pad was touched
            no=correct(nottouched);
            
            touchedrate=sum(yes)/length(yes);               %p(correct) on trials when this pad was touched
            nottouchedrate=sum(no)/length(no);              %p(correct) on trials when this pad was not touched
            
            if side==0
                results(end+1,:)=[str2double(leftID) la i touchedrate nottouchedrate];
            else
                
            end            
        else
            if side==0
                results(end+1,:)=[str2double(leftID) la i nan nan];
            else
                
            end  
        end
    end
end

%% Get shape info
if side==0
    shape=mksqlite(ObjectsDB, ['SELECT x, y, pad FROM shapeTable' leftID]);
else
    shape=mksqlite(ObjectsDB, ['SELECT x, y, pad FROM shapeTable' rightID]);
end

% %% Plot
% figure; hold on; axis equal
% rectangle('Position',[-.5 -.5 1 1],'FaceColor',[0.5 0.5 0.5])
% for i=1:12
%     xs=shape(shape(:,3)==i,1);
%     ys=shape(shape(:,3)==i,2);
%     color=results(i)+0.5;
%     if color>1
%         color=1;
%     end
%     plot(xs,ys,'Color',[color color color],'LineWidth',8)
% end
%% Cleanup
mksqlite(ObjectsDB,'close')
mksqlite(DataDB,'close')





%% significance test
results=results(~isnan(results(:,4)),:);

figure; subplot(1,2,1); hold on;
plot(results(:,3),results(:,4)-results(:,5),'ko')

subplot(1,2,2); hold on; axis equal; axis square

for i=1:12
    vals=results(results(:,3)==i,4) - results(results(:,3)==i,5);
   [h, p] = ttest(vals);   
   disp([num2str(i) ' ' num2str(p)])    
   if p < 0.05/12
       if mean(vals)>0
           plot(shape(shape(:,3)==i,1),shape(shape(:,3)==i,2),'g')
       else
           plot(shape(shape(:,3)==i,1),shape(shape(:,3)==i,2),'r')
       end
           
   else
       plot(shape(shape(:,3)==i,1),shape(shape(:,3)==i,2),'k')
   end
end
