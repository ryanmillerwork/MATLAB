% diffs=diff(pupils,1,2);
% diffs2=diff(diffs,1,2);
% % diffs2=diff(pupils(:,3:4:end),1,2);
% 
% 
% % a=smooth(pupils(1,:),4);
% % figure; hold on;
% % plot(diff(pupils(1,:)),'r')
% % plot(diff(a))
% % return
% % results=[];
% % for negThresh=-20:1:-5
% %     blinkOns=diffs<negThresh;
% %     for posThresh=5:1:20
% %         blinkOffs=diffs>posThresh;
% %         results=[results; negThresh posThresh sum(sum(blinkOns)) sum(sum(blinkOffs))];
% %     end
% % end
% 
% negThresh=-5;
% posThresh=5;
% % blinkOns=diffs<negThresh;
% % blinkOffs=diffs>posThresh;
% % blinkOns(:,end+1)=0;
% % blinkOffs(:,end+1)=1;
% 
% 
% blinkBounds=double(diffs<negThresh); %Assign 1 to times of blink onsets. Often gives several consecutive hits when there are several samples captured during blink onset.
% blinkBounds(diffs>posThresh)=2; %Assign 2 to times of blink offsets. Often gives several consecutive hits when there are several samples captured during blink offset.
% 
% bb2=diff(blinkBounds,1,2);
% 
% ons=bb2==1;
% offs=bb2==-2;
% % offs((offs==2)-10
% 
% % 22 has an incomplete blink
% % 28 has weird uptick at end
% 
% for i=2000:2010
% 
%     
%     figure; subplot(2,1,1); hold on;
%     plot(pupils(i,:))
%     plot(find(ons(i,:)==1),pupils(i,ons(i,:)==1),'*')
%     plot(find(offs(i,:)==1),pupils(i,offs(i,:)==1),'b*')
% 
%     theseOffs=find(offs(i,:)==1);
%     thisD2=diffs2(i,:);
% 
%     for ii=1:length(theseOffs)                                  %For each detected offset
%         thesed2s=thisD2(theseOffs(ii)-5:theseOffs(ii)+5);       %grab 2nd derivative values from surrouding 10 points
%         newOff=find(max(thesed2s))-5+theseOffs(ii)+6;             %find which has the minimum value
%         theseOffs(ii)=newOff;
%     end
%     
%     plot(theseOffs,pupils(i,theseOffs),'g*')
% 
% subplot(2,1,2); hold on;
% plot(thisD2)
% end
% 
% 
% 
% 




global eyePos pupil

figure; subplot(2,1,1); hold on;
plot(eyePos(:,1))
plot(eyePos(:,2),'r')
subplot(2,1,2); hold on
plot(pupil)
