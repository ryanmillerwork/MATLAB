clear all
a=csvread('rect_star.csv',2); %start with second row because first is just column labels




cPt = a(1,1:2); %current point

new=[];
dists=[];

figure; hold on;

for i=1:size(a,1)
    
    
    
    cInd=dsearchn(a,cPt); %find index of closest
    if size(a,1) > 10
        dists=[dists; pdist([cPt;a(cInd,:)])];
    else
        med=median(dists);
        dist=pdist([cPt;a(cInd,:)]);
        if dist>(med*3)
            a(cInd,:)=[];%remove from current list
            continue;
        end
        
    end
    cPt=a(cInd,:); %grab that point
    new=[new; cPt]; %add that to new list
    a(cInd,:)=[];%remove from current list
    
    plot(new(end,1),new(end,2),'.')
    pause(0.001)
    
end





xs=new(:,1);
ys=new(:,2);


plot(xs,ys)