clear all

DataDB = sqlite('C:\Users\Ryan\Documents\Data\graspHuman.db');

targets=double(cell2mat(fetch(DataDB, 'Select Target FROM trialsTable')));
targets=unique(targets);

close(DataDB)



thisShapeJittered=[];

for targ=1:size(targets,1)
    
    ID=targets(targ); %16 gave one bad trial, i think 18 also
    
    
    
    conn = sqlite('L:\stimuli\grasp\objects.db');
    
    whole=cell2mat(fetch(conn,['SELECT x,y FROM shapeTable' num2str(ID)]));
    
    xmidwhole=mean(whole(:,1));
    ymidwhole=mean(whole(:,2));
    
    % plot(xmidwhole,ymidwhole,'o')
    
    % dist=whole(:,2)./whole(:,1);
    % dist=
    % angle = atan(dist);
    
    
    % figure; hold on; axis equal
    mids=[];
    
    for i=1:12
        mat=fetch(conn,['SELECT * FROM shapeTable' num2str(ID) ' WHERE PAD IS ' num2str(i)]);
        mat=cell2mat(mat(:,1:2));
        
        
        xmid=mean(mat(:,1));
        ymid=mean(mat(:,2));
        
        mids=[mids; xmid ymid];
        
        
        
        %     if i==1
        %         plot(mat(:,1),mat(:,2),'g')
        %     elseif i==12
        %         plot(mat(:,1),mat(:,2),'r')
        %     else
        %         plot(mat(:,1),mat(:,2))
        %     end
    end
    close(conn)
    
    
    
    [rad,dist] = cart2pol(mids(:,1),mids(:,2));
    
    % whole=[whole rad dist];
    % figure;
    % polarplot(rad,dist,'.')
    
    first=find(rad>0,1);
    dist=dist([first:end 1:first-1]);
    rad=rad([first:end 1:first-1]);
    
    
    
    samples=100;
    radsd=.02;
    distsd=.02;
    
    
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


% for targ=1:size(targets,1)
%     ID=targets(targ); %16 gave one bad trial, i think 18 also
%     these=thisShapeJittered(thisShapeJittered(:,1)==ID, 2:end);
%     figure;
%     for i=1:size(these,1)
%         polarplot(these(i,1:12),these(i,13:24))
%         hold on;
%     end
% end


X=thisShapeJittered(:,2:end);
Y=thisShapeJittered(:,1);

Mdl = fitcnb(X,Y);
yhat = predict(Mdl,X);
C = confusionmat(Y,yhat);

figure;
imagesc(C)

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


