% Clear the workspace
close all;
clearvars;
sca;

correctLength=25; %Number of columns we're expecting to get.

%% Initialize serial port
try
    fclose(s)
catch
end
s = serial('COM4', 'BaudRate', 250000);

fopen(s)

% First we have to clear out the initial crap. "Debug initialized" is the signal that the arduino is started
start=[];
while isempty(start)
    out = fscanf(s);
    start=strfind(out,'Debug Initialized');
    if ~isempty(start)
        out=out(start:end);
        disp(out)
    end
end

disp('Lets get this party started')

% Go through the debug messages
while out(1)=='D'
    out = fscanf(s);
    if out(1)=='D'
        disp(out)
    end
end
disp('Debug complete')

% Create a baseline for the measurements from the first 
data=str2num(out);
baselineMat=data;
for i=1:9
    out = fscanf(s);
    data=str2num(out);
    baselineMat(i,:)=data;
end
baseline=mean(baselineMat);
baseline(1)=baselineMat(end,1); %Time is last measurement








%% Set up screen

% Here we call some default settings for setting up Psychtoolbox
PsychDefaultSetup(2);

% Skip sync tests for this demo in case people are using a defective
% system. This is for demo purposes only.
Screen('Preference', 'SkipSyncTests', 2);

% Find the screen to use for display
screenid = max(Screen('Screens'));

% Initialise OpenGL
InitializeMatlabOpenGL;

% Open the main window with multi-sampling for anti-aliasing
[window, windowRect] = PsychImaging('OpenWindow', screenid, 0, [],...
    32, 2, [], 6,  []);

% Query the frame duration
ifi = Screen('GetFlipInterval', window);

% Start the OpenGL context (you have to do this before you issue OpenGL
% commands such as we are using here)
Screen('BeginOpenGL', window);

% For this demo we will assume our screen is 30cm in height. The units are
% essentially arbitary with OpenGL as it is all about ratios. But it is
% nice to define things in normal scale numbers
ar = windowRect(3) / windowRect(4);
screenHeight = 30;
screenWidth = screenHeight * ar;

% Enable lighting
glEnable(GL.LIGHTING);

% Force there to be no ambient light (OpenGL default is for there to be
% some, however for this demo we want to fully demonstrate directional
% lighting)
glLightModelfv(GL.LIGHT_MODEL_AMBIENT, [0 0 0 1]);

% Define a local light source
glEnable(GL.LIGHT0);

% Enable proper occlusion handling via depth tests
glEnable(GL.DEPTH_TEST);

% Lets set up a projection matrix, the projection matrix defines how images
% in our 3D simulated scene are projected to the images on our 2D monitor
glMatrixMode(GL.PROJECTION);
glLoadIdentity;

% Calculate the field of view in the y direction assuming a distance to the
% objects of 100cm
dist = 100;
angle = 2 * atand(screenHeight / dist);

% Set up our perspective projection. This is defined by our field of view
% (here given by the variable "angle") and the aspect ratio of our frustum
% (our screen) and two clipping planes. These define the minimum and
% maximum distances allowable here 0.1cm and 200cm.
gluPerspective(angle, ar, 0.1, 200);

% Setup modelview matrix: This defines the position, orientation and
% looking direction of the virtual camera that will be look at our scene.
glMatrixMode(GL.MODELVIEW);
glLoadIdentity;

% Our point lightsource is at position (x,y,z) == (1,2,3)
% glLightfv(GL.LIGHT0, GL.POSITION, [0 0 -1 1]); 
glLightfv(GL.LIGHT0, GL.POSITION, [25 0 -dist-10 1]);
glLightfv(GL.LIGHT0, GL.AMBIENT, [0 0 0 0]);
glLightfv(GL.LIGHT0, GL.DIFFUSE, [1 1 1 1]);
glLightfv(GL.LIGHT0, GL.SPOT_DIRECTION, [0 0 -1]); %Points at right object
% glLightfv(GL.LIGHT0, GL.SPOT_DIRECTION, [-.2 0 -1]); %Points at left object
glLightfv(GL.LIGHT0, GL.SPOT_CUTOFF, 3);
glLightfv(GL.LIGHT0, GL.SPOT_EXPONENT, 128);


% Enable proper occlusion handling via depth tests
glEnable(GL.DEPTH_TEST);

% Location of the camera is at the origin
cam = [0 0 0];

% Set our camera to be looking directly down the Z axis (depth) of our
% coordinate system
fix = [0 0 -100];

% Define "up"
up = [0 1 0];

% Here we set up the attributes of our camera using the variables we have
% defined in the last three lines of code
gluLookAt(cam(1), cam(2), cam(3), fix(1), fix(2), fix(3), up(1), up(2), up(3));

% Set background color to 'black' (the 'clear' color)
glClearColor(0, 0, 0, 0);

% Clear out the backbuffer
glClear;

% Change the light reflection properties of the material to blue. We could
% force a color to the cubes or do this.
glMaterialfv(GL.FRONT_AND_BACK,GL.AMBIENT, [0.0 0.0 1.0 1]);
glMaterialfv(GL.FRONT_AND_BACK,GL.DIFFUSE, [0.0 0.0 1.0 1]);
glMaterialfv(GL.FRONT_AND_BACK,GL.EMISSION, [0.1 0.0 0 1]);

% End the OpenGL context now that we have finished setting things up
Screen('EndOpenGL', window);

% Setup the positions of the spheres using the meshgrid command
% [cubeX, cubeY] = meshgrid(linspace(-25, 25, 10), linspace(-20, 20, 8));
% [cubeX, cubeY] = meshgrid([-20 0 20], 0);


cubeX=[-20 -10 -10 0 0 0 0 0 0 10 10 20];
cubeY=[0 5 -5 25 15 5 -5 -15 -25 5 -5 0];

[s1, s2] = size(cubeX);
cubeX = reshape(cubeX, 1, s1 * s2);
cubeY = reshape(cubeY, 1, s1 * s2);

% Define the intial rotation angles of our cubes
rotaX = rand(1, length(cubeX)) .* 360;
rotaY = rand(1, length(cubeX)) .* 360;
rotaZ = rand(1, length(cubeX)) .* 360;

% Now we define how many degrees our cubes will rotated per second and per
% frame. Note we use Degrees here (not Radians)
degPerSec = 0;
degPerFrame = degPerSec * ifi;


% Make a display list with our backdrop. Its not changing at
% all, so compiling it in a display list helps with rendering speed. See
% Chapter 7 of the OpenGL "red book"

BDList = glGenLists(1);
glNewList(BDList, GL.COMPILE);

% Our ball will reflect only diffuse light as that is all that is coiming from
% our light source.


glMaterialfv(GL.FRONT_AND_BACK, GL.AMBIENT,  [1 1 1 1]);
glMaterialfv(GL.FRONT_AND_BACK, GL.DIFFUSE,  [1 1 1 1]);
glMaterialfv(GL.FRONT_AND_BACK, GL.EMISSION, [0 0 0 1]);
glMaterialfv(GL.FRONT_AND_BACK, GL.SPECULAR, [0 0 0 1]);
% glMaterialfv(GL.FRONT_AND_BACK, GL.SHININESS,0);

% Here we use the GLUT library to define a simple sphere
glutSolidSphere(dist, 1000, 1000);
% glutSolidCube(dist);


glEndList;





% Get a time stamp with a flip
vbl = Screen('Flip', window);

% Set the frames to wait to one
waitframes = 1;

for i=1:100
    fscanf(s);
end

while ~KbCheck
    %Get data from serial
    out = fscanf(s);
    data=str2num(out);
    
    if length(data)~=correctLength
        disp(data)
        continue;
    end
    data=data-baseline+250;
    data(2:end)=data(2:end)/255;

    % Begin the OpenGL context now we want to issue OpenGL commands again
    Screen('BeginOpenGL', window);

    % To start with we clear everything
    glClear;

    % Draw all the cubes
    for i = 1:1:length(cubeX)

        % Push the matrix stack
        glPushMatrix;

        % Translate the cube in xyz
        glTranslatef(cubeX(i), cubeY(i), -dist);

        % Rotate the cube randomly in xyz
%         glRotatef(rotaX(i), 1, 0, 0);
%         glRotatef(rotaY(i), 0, 1, 0);
%         glRotatef(rotaZ(i), 0, 0, 1);
        
        int=data(i+1);

        glMaterialfv(GL.FRONT_AND_BACK,GL.EMISSION, [int int int 1]);
        
%         if i==1
%             glMaterialfv(GL.FRONT_AND_BACK,GL.EMISSION, [rand 0.0 0 1]);
%         else
%             glMaterialfv(GL.FRONT_AND_BACK,GL.EMISSION, [0.5 0.5 0.5 1]);
%         end

        % Draw the solid cube
        glutSolidCube(5);

        % Pop the matrix stack for the next cube
        glPopMatrix;

    end
    
    if rand>0
    %Draw the backdrop
    glPushMatrix;
    glTranslatef(0, 0, -dist-150);
    glMaterialfv(GL.FRONT_AND_BACK,GL.EMISSION, [.1 0.0 0 1]);
    glCallList(BDList);
    
    glPopMatrix;
    end
    

    % End the OpenGL context now that we have finished doing OpenGL stuff.
    % This hands back control to PTB
    Screen('EndOpenGL', window);

    % Show rendered image at next vertical retrace
    vbl = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);

    % Rotate the cubes for the next drawing loop
    rotaX = rotaX + degPerFrame;
    rotaY = rotaY + degPerFrame;
    rotaZ = rotaZ + degPerFrame;

end

% Shut the screen down
sca;
fclose(s)
delete(s)
clear s