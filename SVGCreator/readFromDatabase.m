ID=50; %16 gave one bad trial, i think 18 also

figure; hold on; axis equal

conn = sqlite('L:\stimuli\grasp\objects.db');

for i=1:12
    mat=fetch(conn,['SELECT * FROM shapeTable' num2str(ID) ' WHERE PAD IS ' num2str(i)]);
    mat=cell2mat(mat(:,1:2));
    
    
    xmid=mean(mat(:,1));
    ymid=mean(mat(:,2));
    
    plot(xmid,ymid,'.')
    
    
    
    if i==1
        plot(mat(:,1),mat(:,2),'g')
    elseif i==12
        plot(mat(:,1),mat(:,2),'r')
    else
        plot(mat(:,1),mat(:,2))
    end
end
close(conn)



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


