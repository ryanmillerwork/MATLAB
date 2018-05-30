%% Circles
xs=sin(0:0.01:2*pi)'/2;
ys=cos(0:0.01:2*pi)'/2;
pads=ones(size(xs));
padspace=ceil(length(pads)/12);
pads(1:padspace:end)=0;

xs=xs*(.225/.5);
ys=ys*(.225/.5);

chosen={'blobCir'};
unitsPerMM=0.01;
pointsPerRad=10;
nContacts=12;
slotDepth=0;
slotWidth=0;
maxWidth=46;
symmetric=1;
pair=1;
leftPair=0;

putCustomShapesInDB([xs ys pads], num2str(26))
putCustomShapesInDB([xs ys pads], num2str(27))


% addRowToTable([xs ys pads], chosen, unitsPerMM, pointsPerRad, nContacts, slotDepth, slotWidth, maxWidth, symmetric, pair, leftPair)
% addRowToTable([xs ys pads], chosen, unitsPerMM, pointsPerRad, nContacts, slotDepth, slotWidth, maxWidth, symmetric, pair, leftPair)


%% Diamonds
xs=[-.5:0.01:.5 .49:-.01:-.50]';
ys=[0:.01:.5 .499:-.01:-.5 -.499:.01:0]';
pads=ones(size(xs));
padspace=ceil(length(pads)/12);
pads(1:padspace:end)=0;

xs=xs*(.283/.5);
ys=ys*(.283/.5);

chosen={'blobDia'};
unitsPerMM=0.01;
pointsPerRad=10;
nContacts=12;
slotDepth=0;
slotWidth=0;
maxWidth=56;
symmetric=1;
pair=1;
leftPair=0;

putCustomShapesInDB([xs ys pads], num2str(30))
putCustomShapesInDB([xs ys pads], num2str(31))

% addRowToTable([xs ys pads], chosen, unitsPerMM, pointsPerRad, nContacts, slotDepth, slotWidth, maxWidth, symmetric, pair, leftPair)
% addRowToTable([xs ys pads], chosen, unitsPerMM, pointsPerRad, nContacts, slotDepth, slotWidth, maxWidth, symmetric, pair, leftPair)


%% Rectangle
xs=[-1:.01:1 ones(1,60) 1:-.01:-1 ones(1,60)*-1]';
ys=[ones(1,201)*.3 .3:-.01:-.29 ones(1,201)*-.3 -.29:.01:.3]';

xs=xs/(1/0.35);
ys=ys/3;

pads=ones(size(xs));
padspace=ceil(length(pads)/12);
pads([1 50 100 150 200 232 262 312 362 412 462 492])=0;

chosen={'blobRec'};
unitsPerMM=0.01;
pointsPerRad=10;
nContacts=12;
slotDepth=0;
slotWidth=0;
maxWidth=73;
symmetric=1;
pair=1;
leftPair=0;

putCustomShapesInDB([xs ys pads], num2str(34))
putCustomShapesInDB([xs ys pads], num2str(35))











%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% old version below


return












%% Circles
xs=sin(0:0.01:2*pi)'/2;
ys=cos(0:0.01:2*pi)'/2;
pads=ones(size(xs));
padspace=ceil(length(pads)/12);
pads(1:padspace:end)=0;

chosen={'blobCir'};
unitsPerMM=0.01;
pointsPerRad=10;
nContacts=12;
slotDepth=0;
slotWidth=0;
maxWidth=46;
symmetric=1;
pair=1;
leftPair=0;


% addRowToTable([xs ys pads], chosen, unitsPerMM, pointsPerRad, nContacts, slotDepth, slotWidth, maxWidth, symmetric, pair, leftPair)
% addRowToTable([xs ys pads], chosen, unitsPerMM, pointsPerRad, nContacts, slotDepth, slotWidth, maxWidth, symmetric, pair, leftPair)


%% Diamonds
xs=[-.5:0.01:.5 .49:-.01:-.50]';
ys=[0:.01:.5 .499:-.01:-.5 -.499:.01:0]';
pads=ones(size(xs));
padspace=ceil(length(pads)/12);
pads(1:padspace:end)=0;

chosen={'blobDia'};
unitsPerMM=0.01;
pointsPerRad=10;
nContacts=12;
slotDepth=0;
slotWidth=0;
maxWidth=56;
symmetric=1;
pair=1;
leftPair=0;


% addRowToTable([xs ys pads], chosen, unitsPerMM, pointsPerRad, nContacts, slotDepth, slotWidth, maxWidth, symmetric, pair, leftPair)
% addRowToTable([xs ys pads], chosen, unitsPerMM, pointsPerRad, nContacts, slotDepth, slotWidth, maxWidth, symmetric, pair, leftPair)


%% Rectangle
xs=[-1:.01:1 ones(1,60) 1:-.01:-1 ones(1,60)*-1]';
ys=[ones(1,201)*.3 .3:-.01:-.29 ones(1,201)*-.3 -.29:.01:.3]';

xs=xs/3;
ys=ys/3;

pads=ones(size(xs));
padspace=ceil(length(pads)/12);
pads([1 50 100 150 200 232 262 312 362 412 462 492])=0;

chosen={'blobRec'};
unitsPerMM=0.01;
pointsPerRad=10;
nContacts=12;
slotDepth=0;
slotWidth=0;
maxWidth=73;
symmetric=1;
pair=1;
leftPair=0;


addRowToTable([xs ys pads], chosen, unitsPerMM, pointsPerRad, nContacts, slotDepth, slotWidth, maxWidth, symmetric, pair, leftPair)
addRowToTable([xs ys pads], chosen, unitsPerMM, pointsPerRad, nContacts, slotDepth, slotWidth, maxWidth, symmetric, pair, leftPair)

