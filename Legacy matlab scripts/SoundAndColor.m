
oldVisualDebugLevel = Screen('Preference', 'VisualDebugLevel', 3);
oldSupressAllWarnings = Screen('Preference', 'SuppressAllWarnings', 1);
oldSkipSyncTests = Screen('Preference', 'SkipSyncTests', 2);



% Clear the workspace

try
    PsychPortAudio('Close', pahandle); % Close the audio device
catch
end
clc
close all;
clearvars;
sca;

% AssertOpenGL;

%---------------
% Sound Setup
%---------------

% Constants
nrchannels = 2;                 % Stereo
sampleRate = 48000;             % Sampling frequency
toneOptions=logspace(2,4.2);    % List of possible tone frequencies
repetitions = 1;                % How many times to we wish to play the sound (each time)
startCue = 0;                   % Start immediately (0 = immediately)
waitForDeviceStart = 1;         % Should we wait for the device to really start (1 = yes)

% Variables for each trial
toneHz=toneOptions(randperm(length(toneOptions),1));    % Choose one tone at random
toneScale=.4;%rand(1);                                  % Choose signal strength
toneDur = .1;                                           % Length of the beep in seconds
% interToneInterval = 2;                                  % Length of the pause between beeps

% Prep the sound and put it in the buffer
InitializePsychSound(1);                                % Initialize Sounddriver
pahandle = PsychPortAudio('Open', [], 1, 1, sampleRate, nrchannels);
PsychPortAudio('Volume', pahandle, 0.5);                % Set the volume to half for this demo
myBeep = MakeBeep(toneHz, toneDur, sampleRate);         % Make a beep which we will play back to the user
myBeep = myBeep*toneScale + randn(size(myBeep));        %Add in noise
PsychPortAudio('FillBuffer', pahandle, [myBeep; myBeep]);% Fill the audio playback buffer with the audio data






% Setup PTB with some default values
PsychDefaultSetup(2);

% Seed the random number generator. Here we use the an older way to be
% compatible with older systems. Newer syntax would be rng('shuffle'). Look
% at the help function of rand "help rand" for more information
% rand('seed', sum(100 * clock));

% Set the screen number to the external secondary monitor if there is one
% connected
screenNumber = max(Screen('Screens'));

% Define black, white and grey
white = WhiteIndex(screenNumber);
grey = white / 2;
black = BlackIndex(screenNumber);

% Open the screen
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, grey, [], 32, 2,...
    [], [],  kPsychNeed32BPCFloat);

% Flip to clear
Screen('Flip', window);

% Query the frame duration
ifi = Screen('GetFlipInterval', window);

% Set the text size
Screen('TextSize', window, 40);

% Query the maximum priority level
topPriorityLevel = MaxPriority(window);

% Get the centre coordinate of the window
[xCenter, yCenter] = RectCenter(windowRect);

%--------------------
% Gabor information
%--------------------

% Dimension of the region where will draw the Gabor in pixels
gaborDimPix = 400;

% Sigma of Gaussian
sigma = gaborDimPix / 8;

% Obvious Parameters
orientation = 90;
contrast = 1;
aspectRatio = 1.0;

% Spatial Frequency (Cycles Per Pixel)
% One Cycle = Grey-Black-Grey-White-Grey i.e. One Black and One White Lobe
numCycles = 8;
freq = numCycles / gaborDimPix;

% Build a procedural gabor texturez
gabortex = CreateProceduralGabor(window, gaborDimPix, gaborDimPix, [],...
    [0.5 0.5 0.5 0.0], 1, 0.5);

% We will be displaying our Gabors either above or below fixation by 250
% pixels. We therefore have to determine these two locations in screen
% coordianates.
% pixShift = 250;
% xPos = [xCenter xCenter];
% yPos = [yCenter - pixShift yCenter + pixShift];

% xPos = [xCenter xCenter xCenter+pixShift xCenter-pixShift];
% yPos = [yCenter - pixShift yCenter + pixShift yCenter yCenter];


%Total list of potential stim locations
xPotentials=0:10:windowRect(3)-gaborDimPix;
yPotentials=0:10:windowRect(4)-gaborDimPix;

%Pick random 10 from each of the lists
xPos=xPotentials(randperm(length(xPotentials),10));
yPos=yPotentials(randperm(length(yPotentials),10));


% Count how many Gabors there are (two for this demo)
nGabors = numel(xPos);

% Make the destination rectangles for  the Gabors in the array i.e.
% rectangles the size of our Gabors cenetred above an below fixation.
baseRect = [0 0 gaborDimPix gaborDimPix];
allRects = nan(4, nGabors);
for i = 1:nGabors
    allRects(:, i) = CenterRectOnPointd(baseRect, xPos(i), yPos(i));
end

% Randomise the phase of the Gabors and make a properties matrix.
phaseLine = rand(1, 2) .* 360;
propertiesMat = repmat([NaN, freq, sigma, contrast,...
    aspectRatio, 0, 0, 0], 2, 1);
propertiesMat(:, 1) = phaseLine';

% Set the orientations for the methods of constant stimuli. We will center
% the range around zero (vertical) and give it a range of 1.8 degress, this
% will mean we test between -(1.8 / 2) and +(1.8 / 2). Finally we will test
% seven points linearly spaced between these extremes.
baseOrientation = 0;
orRange = 80;
numSteps = 7;
stimValues = linspace(-orRange / 2, orRange / 2, numSteps) + baseOrientation;

% Now we set the number of times we want to do each condition, then make a
% full condition vector and then shuffle it. This will randomly order the
% orientation we present our Gabor with on each trial.
numRepeats = 150;
condVector = Shuffle(repmat(stimValues, 1, numRepeats));

% Calculate the number of trials
numTrials = numel(condVector);

% Make a vector to record the response for each trial
respVector = zeros(1, numSteps);

% Make a vector to count how many times we present each stimulus. This is a
% good check to make sure we have done things right and helps us when we
% input the data to plot anf fit our psychometric function
countVector = zeros(1, numSteps);




%----------------------------------------------------------------------
%                       Timing Information
%----------------------------------------------------------------------

% Presentation Time for the Gabor in seconds and frames
totalTimeSecs=1;
totalTimeFrames=round(totalTimeSecs / ifi);
presTimeSecs = 0.1;
presTimeFrames = round(presTimeSecs / ifi);

% Interstimulus interval time in seconds and frames
isiTimeSecs = 1;
isiTimeFrames = round(isiTimeSecs / ifi);

% Numer of frames to wait before re-drawing
waitframes = 1;


%----------------------------------------------------------------------
%                       Keyboard information
%----------------------------------------------------------------------

% Define the keyboard keys that are listened for. We will be using the left
% and right arrow keys as response keys for the task and the escape key as
% a exit/reset key
escapeKey = KbName('ESCAPE');
% leftKey = KbName('LeftArrow');
% rightKey = KbName('RightArrow');
zKey = KbName('z');
oneKey = KbName('1');


%----------------------------------------------------------------------
%                       Experimental loop
%----------------------------------------------------------------------

% Animation loop: we loop for the total number of trials
responseMat=[];
for trial = 1:500
    visYN=round(rand(1));
    audYN=round(rand(1));
    
    visOn=0.500;
    audOn=0.500;
    
%     presTimeSecs = 0.1;
    visOnFrames = round(visOn / ifi);
    visOffFrames = round((visOn+toneDur) / ifi);
    
    
    % Auditory Variables for each trial
    toneHz=toneOptions(randperm(length(toneOptions),1));    % Choose one tone at random
    if audYN
        toneScale=.6;%rand(1);                                  % Choose signal strength
    else
        toneScale=0;
    end
%     toneDur = .1;                                           % Length of the beep in seconds
%     interToneInterval = 2;                                  % Length of the pause between beeps
    
    PsychPortAudio('Volume', pahandle, 0.5);                % Set the volume to half for this demo
    preBeep = MakeBeep(0, audOn, sampleRate);
    myBeep = MakeBeep(toneHz, toneDur, sampleRate);         % Make a beep which we will play back to the user
    postBeep = MakeBeep(0, totalTimeSecs-audOn+toneDur, sampleRate);
    
    myBeep=[preBeep myBeep postBeep];
    
    myBeep = myBeep*toneScale + randn(size(myBeep));        %Add in noise
    PsychPortAudio('FillBuffer', pahandle, [myBeep; myBeep]);% Fill the audio playback buffer with the audio data

    
    
    % Get the Gabor angle for this trial (negative values are to the right
    % and positive to the left)
    theAngle = condVector(trial);

    % Randomise the side which the Gabor is displayed on
    side = round(rand*nGabors+.5);
    thisDstRect = allRects(:, side);
    xcenter=(thisDstRect(3)-thisDstRect(1))/2+thisDstRect(1);
    ycenter=(thisDstRect(4)-thisDstRect(2))/2+thisDstRect(2);

    % Change the blend function to draw an antialiased fixation point
    % in the centre of the screen
    Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');

    % If this is the first trial we present a start screen and wait for a
    % key-press
    if trial == 1
        DrawFormattedText(window, 'Press Any Key To Begin', 'center', 'center', black);
        Screen('Flip', window);
        KbStrokeWait;
    end

    % Flip again to sync us to the vertical retrace at the same time as
    % drawing our fixation point
    Screen('DrawDots', window, [xCenter; yCenter], 10, black, [], 2);
    vbl = Screen('Flip', window);

    % Now we present the isi interval with fixation point minus one frame
    % because we presented the fixation point once already when getting a
    % time stamp
    for frame = 1:isiTimeFrames - 1

        % Draw the fixation point
        Screen('DrawDots', window, [xCenter; yCenter], 10, black, [], 2);

        % Flip to the screen
        vbl = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);
    end
        %Create visual noise

            noiseimg=(50*randn(windowRect(4)/4, windowRect(3)/4) + 128);
%         noiseimg(:,:,2)=ones(size(noiseimg))*128;
        noiseimg(:,:,2)=ones(size(noiseimg,1),size(noiseimg,2))*128;
    
    % Now we draw the Gabor and the fixation point
    PsychPortAudio('Start', pahandle, repetitions, startCue, waitForDeviceStart); % Start audio playback #1
    t1=GetSecs;
    for frame = 1:totalTimeFrames
        
        noiseimg(:,:,1)=(0.1*randn(windowRect(4)/4, windowRect(3)/4) + 128);
%         noiseimg(:,:,2)=ones(size(noiseimg))*128;
%         noiseimg(:,:,2)=ones(size(noiseimg,1),size(noiseimg,2))*128;
        noisetex=Screen('MakeTexture', window, noiseimg);
        

        % Set the right blend function for drawing the gabors
%         Screen('BlendFunction', window, 'GL_ONE', 'GL_ZERO');
        Screen('BlendFunction', window, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

        % Draw the Gabor
             
%         Screen('DrawTextures', window, [gabortex ], [], [thisDstRect ], [theAngle ], [], [], [], [],...
%             kPsychDontDoRotation, propertiesMat');
        
        if visYN & frame > visOnFrames & frame < visOffFrames
            Screen('DrawTextures', window, [gabortex noisetex], [], [thisDstRect windowRect'], [theAngle theAngle], [], [], [], [],...
                kPsychDontDoRotation, propertiesMat(1,:)');
        else
            Screen('DrawTextures', window, [ noisetex], [], [ windowRect'], [ theAngle], [], [], [], [],...
                kPsychDontDoRotation, propertiesMat(1,:)');
        end
        
        
        
        
%         Screen('DrawTexture', window, noisetex, [], thisDstRect, [], 0, 0.1);

        % Change the blend function to draw an antialiased fixation point
        % in the centre of the array
%         Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');

        % Draw the fixation point
        Screen('DrawDots', window, [xCenter; yCenter], 10, black, [], 2);

        % Flip to the screen
        vbl = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);
    end
    PsychPortAudio('Stop', pahandle); % Stop playback, regardless whether it has finished or not. 

    % Change the blend function to draw an antialiased fixation point
    Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');
    

    % Draw the fixation point
    Screen('DrawDots', window, [xCenter; yCenter], 10, black, [], 2);

    % Flip to the screen
    vbl = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);
    
    % Prep the sound for the next trial and put it in the buffer
%     InitializePsychSound(1);                                % Initialize Sounddriver
%     pahandle = PsychPortAudio('Open', [], 1, 1, sampleRate, nrchannels);


    % Now we wait for a keyboard button signaling the observers response.
    % The left arrow key signals a "left" response and the right arrow key
    % a "right" response. You can also press escape if you want to exit the
    % program
    
    response=[];
    elapsed=GetSecs-t1;
    while elapsed<2
        [keyIsDown,secs, keyCode] = KbCheck;
        elapsed=GetSecs-t1;
        if keyCode(escapeKey)
            ShowCursor;
            sca;
            PsychPortAudio('Close', pahandle); % Close the audio device
            return
        end
%         if keyCode(leftKey)
%             response = [response; 0 etime(clock,t1)];
% %             respToBeMade = false;
%         end
%         if keyCode(rightKey)
%             response = [response; 1 etime(clock,t1)];
% %             respToBeMade = false;
%         end
        if keyCode(zKey)
            response = [response; trial 0 elapsed toneScale toneHz orientation contrast aspectRatio numCycles xcenter ycenter visYN audYN];
%             respToBeMade = false;
        end
        if keyCode(oneKey)
            response = [response; trial 1 elapsed toneScale toneHz orientation contrast aspectRatio numCycles xcenter ycenter visYN audYN];
%             respToBeMade = false;
        end
    end

    if ~isempty(response)
        [a, b]=unique(response(:,2));
%     responseMat=[responseMat; trial nan(1)];1
        responseMat=[responseMat; response(b,:)];
    else
        responseMat=[responseMat; trial nan nan toneScale toneHz orientation contrast aspectRatio numCycles xcenter ycenter visYN audYN];
    end
    

    % Record the response
%     respVector(stimValues == theAngle) = respVector(stimValues == theAngle).1..
%         + response;

    % Add one to the counter for that stimulus
    countVector(stimValues == theAngle) = countVector(stimValues == theAngle) + 1;

end

data = [stimValues; respVector; countVector]';

figure;
plot(data(:, 1), data(:, 2) ./ data(:, 3), 'ro-', 'MarkerFaceColor', 'r');
axis([min(data(:, 1)) max(data(:, 1)) 0 1]);
xlabel('Angle of Orientation (Degrees)');
ylabel('Performance');
title('Psychometric function');

% Clean up
PsychPortAudio('Close', pahandle); % Close the audio device
sca;  