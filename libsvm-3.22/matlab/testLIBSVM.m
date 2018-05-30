clear all

load twos
twos=vecMat;

load nottwos
nottwos=vecMat;

clear vecMat


train_data=[twos(1:30,:); nottwos(1:30,:)];
train_label=[ones(30,1); ones(30,1)*-1];

% train_data=[twos; nottwos];
% train_label=[ones(101,1); ones(67,1)*-1];

% test_data=[twos(51:end,:); nottwos(51:end,:)];
% test_label=[ones(size(twos,1)-50,1); ones(size(nottwos,1)-50,1)*-1];

test_data=[twos(52,:)].*100;
test_label=[1];



% train_data(train_data < 0) = 0;
% test_data(test_data < 0) = 0;



for i=1:size(train_data,1)
   this=train_data(i,:);
   this=this./max(this);
   train_data(i,:)=this;    
end

for i=1:size(test_data,1)
   this=test_data(i,:);
   this=this./max(this);
   test_data(i,:)=this;    
end

% creates two-class SVM

% [heart_scale_label, heart_scale_inst] = libsvmread('../heart_scale');

% Split Data
% train_data = full(heart_scale_inst(1:150,:));
% train_label = heart_scale_label(1:150,:);
% test_data = full(heart_scale_inst(151:270,:));
% test_label = heart_scale_label(151:270,:);

% test_label(:)=1;



% Linear Kernel

% model_linear = svmtrain(train_label, train_data, '-s 0 -t 3 -b 1 -q');
% [predict_label_L, accuracy_L, dec_values_L] = svmpredict(test_label, test_data, model_linear, '-b 1');

model_linear = svmtrain(train_label, train_data, '-s 0 -t 0 -b 1 -q');
[predict_label_L, accuracy_L, dec_values_L] = svmpredict(test_label, test_data, model_linear, '-b 1');


% Precomputed Kernel
% model_precomputed = svmtrain(train_label, [(1:150)', train_data*train_data'], '-t 4');
% [predict_label_P, accuracy_P, dec_values_P] = svmpredict(test_label, [(1:120)', test_data*train_data'], model_precomputed);


a=[test_label predict_label_L dec_values_L(:,1)];
figure; hist(a(:,end),0.025:.05:0.975)


% accuracy_L % Display the accuracy using linear kernel
% accuracy_P % Display the accuracy using precomputed kernel






imagesc(reshape(test_data(1,:),50,50))