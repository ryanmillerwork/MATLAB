clc
clear

port=6;
baud=1000000;
o  = MX64(port,baud);

%motor ids
drumIDs=[1 2];
objectIDs=[10 99];

position(1)=1;
position(2)=512;
position(3)=1024;
position(4)=1536;
position(5)=2048;
position(6)=2560;
position(7)=3072;
position(8)=3584;

position=position+50;

P=32; I=0; D=0;
accel=5; %10-30 is okay
torqueEn=1; %Always on
speed=1023; %1023 is max
CW=4095; %Both at 4095 for multiTurn mode. Anything but 0,0 and 4095,4095 for joint mode
CCW=4095;

%Initialize values for drum motors
for i=1:length(drumIDs)
    o.setPID(drumIDs(i),P,I,D)
    o.accel(drumIDs(i),accel)
    o.setSpeed(drumIDs(i),speed)
    o.torqueEnable(drumIDs(i),torqueEn)
    o.setAngleLimit(drumIDs(i),CW,CCW)
end
%Initialize values for object motors
for i=1:length(objectIDs)
    o.setPID(objectIDs(i),P,I,D)
    o.accel(objectIDs(i),accel)
    o.setSpeed(objectIDs(i),speed)
    o.torqueEnable(objectIDs(i),torqueEn)
    o.setAngleLimit(objectIDs(i),1,1) %for joint mode
end

% o.position(drumIDs(1),position(2))          %Set new position
% o.position(drumIDs(2),-24504)          %Set new position
o.position(objectIDs(1),0)          %Set new position


% boolean = o.isMoving(ID)

current = o.getPresentPosition(drumIDs(1))
current = o.getPresentPosition(drumIDs(2))


