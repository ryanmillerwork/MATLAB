clear

list={'responseMat6',...
    'responseMat7',...
    'responseMat8',...
    'responseMat9',...
    'responseMat10',...
    'responseMat11',...
    'responseMat12',...
    'responseMat13',...
    'responseMat14',...
    'responseMat15',...
    'responseMat16',...
    'responseMat17',...
    'responseMat18',...
    'responseMat19',...
    'responseMat20',...
    };

full=[];
for i=1:size(list,2)
    eval(['load ' list{i}])
    responseMat(:,1)=responseMat(:,1)+(i-1)*100;
    full=[full; responseMat];
end
tic

% full=full(:,1:5);


%Randomize
% full(:,1)=full(randperm(1785,1785),1); 

analyzeResponseMat(full)
toc