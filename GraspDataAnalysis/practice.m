% rates=[ones(1,15)*.10 ones(1,15)*.05];
rates=[ones(1,5)*-.25 ones(1,25)*.10];
princ=1000;

for i=1:30
    princ=[princ; princ(end)+princ(end)*rates(i)];
    
end
figure; hold on;
plot(princ)

rates=[ones(1,25)*.10 ones(1,5)*-.25];
% rates=[ones(1,15)*.05 ones(1,15)*.10];
princ=1000;

for i=1:30
    princ=[princ; princ(end)+princ(end)*rates(i)];
    
end


plot(princ,'r')