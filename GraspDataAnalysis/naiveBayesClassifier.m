clear all


%% Get shapes that've been used
DataDB = sqlite('C:\Users\Ryan\Documents\Data\graspHuman.db');

targets=double(cell2mat(fetch(DataDB, 'Select Target FROM trialsTable')));
targets=unique(targets);

close(DataDB)

%% create matrix of jittered midpoint values of each pad
conn = sqlite('L:\stimuli\grasp\objects.db');

thisShapeJittered=[];
for targ=1:size(targets,1)
    ID=targets(targ);  %This shape

    mids=[]; %Midpoints of each pad    
    for i=1:12
        mat=fetch(conn,['SELECT * FROM shapeTable' num2str(ID) ' WHERE PAD IS ' num2str(i)]);
        mat=cell2mat(mat(:,1:2));        
        
        xmid=mean(mat(:,1));
        ymid=mean(mat(:,2));
        
        mids=[mids; xmid ymid];
    end
    
    [rad,dist] = cart2pol(mids(:,1),mids(:,2)); %Convert to polar coordinates
   
    %Reorder matrix so that first angle > zero is first value
    first=find(rad>0,1);
    dist=dist([first:end 1:first-1]);
    rad=rad([first:end 1:first-1]);
    
    %Choose variables
    samples=100;
    radsd=.1;
    distsd=.1;

    for pad=1:12
        radjits=randn(samples,1)*radsd;
        distjits=randn(samples,1)*distsd;
        for i=1:size(radjits,1)
            rad(pad,i+1)=rad(pad,1)+radjits(i);
            dist(pad,i+1)=dist(pad,1)+distjits(i);
        end
    end
    thisShapeJittered=[thisShapeJittered; repmat(ID,100,1) rad(:,2:end)' dist(:,2:end)']; 
end
close(conn)


%% train naive bayes classifier

X=thisShapeJittered(:,2:end);
Y=thisShapeJittered(:,1);
Y(Y==2)=1;
Y(Y~=1)=-1;

tic
Mdl = fitcnb(X,Y);
toc
yhat = predict(Mdl,X);
C = confusionmat(Y,yhat);

figure;
imagesc(C)

%% Train SVM classifier
% tic
% X=repmat(X,1,1000);
% Y(:)=1;
% SVMModel = fitcsvm(X(1:300,:),Y(1:300),'KernelFunction','rbf');
% toc
% [Label,score] = predict(SVMModel,newX);


%% Train LIBSVM one-class classifier

% model = svmtrain(Y, X, ,[ 'libsvm_options']);

% [label, accuracy, p] = svmpredict(testing_label_vector, testing_instance_matrix, model [, 'libsvm_options']);

Y(Y==2)=1;
Y(Y~=1)=-1;
model_precomputed = svmtrain(Y, X, '-s 1 -t 2');
[predict_label_P, accuracy_P, dec_values_P] = svmpredict(Y, X, model_precomputed);

return
%% plot
figure;
ids=[2 3 4 6 7 8 14];

conn = sqlite('L:\stimuli\grasp\objects.db');
for i=1:size(ids,2)
    
    ID=ids(i); %16 gave one bad trial, i think 18 also
    subplot(size(ids,2),1,size(ids,2)+1-i); hold on; axis equal; xlim([-.5 0.5]); ylim([-.5 0.5]); axis off;
    xlabel(num2str(ids(i)))
    
    
    % for i=1:12
    border=fetch(conn,['SELECT x,y FROM shapeTable' num2str(ID)]);
    border=cell2mat(border(:,1:2));
    %     if i==1
    %         plot(mat(:,1),mat(:,2),'g')
    %     elseif i==12
    %         plot(mat(:,1),mat(:,2),'r')
    %     else
    %         plot(mat(:,1),mat(:,2))
    %     end
    
    plot(border(:,1),border(:,2),'k','LineWidth',5)
end
close(conn)


