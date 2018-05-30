clear all

p=0.1;

mat=[];


for t=0:0.1:100
    for i=1:100
        mat(i,t*10+1)=rand<p;
        
        
    end
end
