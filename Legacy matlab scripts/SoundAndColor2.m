
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

%---------------------
% Overall constants
%------------------

numTrials=200;
pretrialTimeSecs = 0.5; %Pretrial period
trialTimeSecs=1;
visDur = 0.1;
audDur = 0.1;
visOnCenter = 0.5;  %Average onset time of vis stim
audOnCenter = 0.5;  %Average onset time of aud stim
visOnSTD=0.03;        %STD of vis onset time
audOnSTD=0.03;        %STD of aud onset time
pVis=sqrt(0.5);      %Probability of vis stim on each trial
pAud=sqrt(0.5);     %Probability of vis stim on each trial

%--------------------
% Setup sound
%--------------------

% Constants
nrchannels = 2;                 % Stereo
audioSampleRate = 48000;        % Sampling frequency
toneOptions=logspace(log10(500),log10(10000));    % List of possible tone frequencies
repetitions = 1;                % How many times to we wish to play the sound (each time)
startCue = 0;                   % Start immediately (0 = immediately)
waitForDeviceStart = 1;         % Should we wait for the device to really start (1 = yes)
toneVol =  0.27;

% Prep sound card
InitializePsychSound(1);                                % Initialize Sounddriver
pahandle = PsychPortAudio('Open', [], 1, 1, audioSampleRate, nrchannels);
PsychPortAudio('Volume', pahandle, 0.5);                    % Set the volume to half for this demo
% PsychPortAudio('DirectInputMonitoring', pahandle, 1, [],[],[],0.);

%--------------------
% Setup screen
%--------------------

% Setup PTB with some default values
PsychDefaultSetup(2);
screenNumber = max(Screen('Screens'));

% Define black, white and grey
white = WhiteIndex(screenNumber);
grey = white / 2;
black = BlackIndex(screenNumber);

[window, windowRect] = PsychImaging('OpenWindow', screenNumber, grey, [], 32, 2, [], [],  kPsychNeed32BPCFloat); % Open the screen
Screen('Flip', window); % Flip to clear
ifi = Screen('GetFlipInterval', window); % Query the frame duration
Screen('TextSize', window, 40); % Set the text size
Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');
topPriorityLevel = MaxPriority(window);% Query the maximum priority level
[xCenter, yCenter] = RectCenter(windowRect); % Get the centre coordinate of the window

%--------------------
% Vis stim information
%--------------------

%Constants
nVisPos = 20; %Number of visual positions which will be randomly placed on screen
gaborDimPix = 400; % Dimension of the region where will draw the Gabor in pixels
sigma = gaborDimPix / 8; % Sigma of Gaussian
orientation = 90;
contrast = 0.64;
aspectRatio = 1.0;
numCycles = 8; % Spatial Frequency (Cycles Per Pixel)
freq = numCycles / gaborDimPix;
baseOrientation = 0;
orRange = 170;
numSteps = 7;
stimValues = linspace(-orRange / 2, orRange / 2, numSteps) + baseOrientation;
noiseAlpha = 128; %Alpha level of visual noise mask (0-255)

gabortex = CreateProceduralGabor(window, gaborDimPix, gaborDimPix, [],[0.5 0.5 0.5 0.0], 1, 0.5); % Build a procedural gabor texturez

%Pick random nVis locations from each of the lists
xPos=ceil(rand(nVisPos,1)*(windowRect(3)-gaborDimPix)+gaborDimPix/2);
yPos=ceil(rand(nVisPos,1)*(windowRect(4)-gaborDimPix)+gaborDimPix/2);

% Make the destination rectangles for  the Gabors in the array i.e.
% rectangles the size of our Gabors cenetred above and below fixation.
baseRect = [0 0 gaborDimPix gaborDimPix];
allRects = nan(4, nVisPos);
for i = 1:nVisPos
    allRects(:, i) = CenterRectOnPointd(baseRect, xPos(i), yPos(i));
end

% Randomise the phase of the Gabors and make a properties matrix.
phaseLine = rand(1, 2) .* 360;
propertiesMat = repmat([NaN, freq, sigma, contrast, aspectRatio, 0, 0, 0], 2, 1);
propertiesMat(:, 1) = phaseLine';


%----------------------------------------------------------------------
%                       Timing Information
%----------------------------------------------------------------------

totalTimeFrames=round(trialTimeSecs / ifi); % Total trial duration in frames
presTimeFrames = round(visDur / ifi); % Presentation Time for the vis stim in frames
pretrialTimeFrames = round(pretrialTimeSecs / ifi);   % Interstimulus interval time in seconds and frames
waitframes = 1;                             % Numer of frames to wait before re-drawing

%----------------------------------------------------------------------
%                       Keyboard information
%----------------------------------------------------------------------

% Define the keyboard keys that are listened for.
escapeKey = KbName('ESCAPE');
zKey = KbName('z');
oneKey = KbName('1');

%----------------------------------------------------------------------
%                       Experimental loop
%----------------------------------------------------------------------

% Animation loop: we loop for the total number of trials
responseMat=[];
for trial = 1:numTrials
    %Determine which stim will be presented on this trial
    visYN=rand<pVis;
    audYN=rand<pAud;
    
    %Determine onset times for each stim
    visOn=randn*visOnSTD+visOnCenter;
    audOn=randn*audOnSTD+audOnCenter;
   
    % Auditory Variables for each trial
    toneHz=toneOptions(randperm(length(toneOptions),1));        % Choose one tone at random
    toneScale=toneVol * audYN;                                      % Choose signal strength (zero if no aud this trial)
    
    %Create prebeep, beep, and postbeep signal and append together
    preBeep = MakeBeep(0, audOn, audioSampleRate);
    Beep = MakeBeep(toneHz, audDur, audioSampleRate);           % Make a beep which we will play back to the user
    postBeep = MakeBeep(0, trialTimeSecs-audOn+audDur, audioSampleRate);
    myBeep=[preBeep Beep postBeep];                             % Append
    myBeep = myBeep*toneScale + randn(size(myBeep));            % Add in noise
    
    PsychPortAudio('FillBuffer', pahandle, [myBeep; myBeep]);   % Fill the audio playback buffer with the audio data
    
    %Calculate time (in frames) of visual stimulus onset and offset
    visOnFrames = round(visOn / ifi);
    visOffFrames = round((visOn+visDur) / ifi);    
    
    theAngle = stimValues(randperm(length(stimValues),1)); %Choose an image angle for this trial
    
    % Randomise the side which the Gabor is displayed on
    visLoc = round(rand*nVisPos+.5);
    thisDstRect = allRects(:, visLoc);
    xcenter=(thisDstRect(3)-thisDstRect(1))/2+thisDstRect(1);
    ycenter=(thisDstRect(4)-thisDstRect(2))/2+thisDstRect(2);
       
    noiseimg=(50*randn(windowRect(4)/4, windowRect(3)/4) + 128);    %Create visual noise
    noiseimg(:,:,2)=ones(size(noiseimg,1),size(noiseimg,2))*noiseAlpha;    %Add in alpha value
    
    trialParams=[visYN audYN visOn audOn visDur audDur toneScale toneHz orientation contrast aspectRatio numCycles xcenter ycenter noiseAlpha theAngle];
    
    
    %%%%%%%%%%%%%%%%
    %Start drawing
    %%%%%%%%%%%%%%%%
    
    
    % If this is the first trial we present a start screen and wait for a key-press
    if trial == 1
        DrawFormattedText(window, 'Press Any Key To Begin', 'center', 'center', black);
        Screen('Flip', window);
        KbStrokeWait;
    end
    
    % Flip again to sync us to the vertical retrace at the same time as drawing our fixation point
    Screen('DrawDots', window, [xCenter; yCenter], 10, black, [], 2);
    vbl = Screen('Flip', window);
    
    %Show just fixation in pre-trial period
    for frame = 1:pretrialTimeFrames - 1
        Screen('DrawDots', window, [xCenter; yCenter], 10, black, [], 2); % Draw the fixation point
        vbl = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi); % Flip to the screen
    end
    
    % Now we draw the Gabor and the fixation point
    PsychPortAudio('Start', pahandle, repetitions, startCue, waitForDeviceStart); % Start audio playback #1
    t1=GetSecs;
    response=[];
    for frame = 1:totalTimeFrames
        %Update visual noise mask for this frame and make into texture
        noiseimg(:,:,1)=(0.1*randn(windowRect(4)/4, windowRect(3)/4) + 128);
        noisetex=Screen('MakeTexture', window, noiseimg);

        %If we're showing visual on this trial and we're in the window when the vis stim should be shown
        if visYN && frame > visOnFrames && frame < visOffFrames
            Screen('DrawTextures', window, [gabortex noisetex], [], [thisDstRect windowRect'], [theAngle theAngle], [], [], [], [], kPsychDontDoRotation, propertiesMat(1,:)');
        else
            Screen('DrawTextures', window, noisetex, [], windowRect', theAngle, [], [], [], [], kPsychDontDoRotation, propertiesMat(1,:)');
        end
        
        Screen('DrawDots', window, [xCenter; yCenter], 10, black, [], 2); % Draw the fixation point
        vbl = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi); % Flip to the screen
        
        %Check keyboard
        elapsed=GetSecs-t1;
        [keyIsDown,secs, keyCode] = KbCheck;
        if keyCode(escapeKey)
            ShowCursor;
            sca;
            PsychPortAudio('Close', pahandle); % Close the audio device
            return
        end
        if keyCode(zKey)
            response = [response; trial 0 elapsed];
        end
        if keyCode(oneKey)
            response = [response; trial 1 elapsed];
        end
    end
    PsychPortAudio('Stop', pahandle); % Stop audio playback, regardless whether it has finished or not.

    Screen('DrawDots', window, [xCenter; yCenter], 10, black, [], 2); % Draw the fixation point
    zvbl = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi); % Flip to the screen
    
   
    
    %Listen for keyboard response
    elapsed=GetSecs-t1;
    while elapsed<2
        [keyIsDown,secs, keyCode] = KbCheck;
        elapsed=GetSecs-t1;
        if keyCode(escapeKey)
            ShowCursor;
            sca;
            PsychPortAudio('Close', pahandle); % Close the audio device
            analyzeResponseMat(responseMat)
            return
        end
        if keyCode(zKey)
            response = [response; trial 0 elapsed];
        end
        if keyCode(oneKey)
            response = [response; trial 1 elapsed];
        end
    end
    
    %Add response(s), if any, to responseMatrix for this trial
    if ~isempty(response)
        [a, b]=unique(response(:,2));
        new=response(b,:);
        new=[new repmat(trialParams,size(new,1),1)];
        responseMat=[responseMat; new];    
        
        if size(new,1)==2
            respType=3;
        elseif new(2)==0
            respType=1;
        elseif new(2)==1
            respType=2;
        end
    else
        responseMat=[responseMat; trial nan nan trialParams];
        respType=0;
    end
    
    %Figure out if we got it right
    if ~visYN && ~audYN
        condType=0;
    elseif visYN && ~audYN
        condType=1;
    elseif ~visYN && audYN
        condType=2;
    elseif visYN && audYN
        condType=3;
    end
    
    
    %Tell user how he or she did

    %     DrawFormattedText(window, ['cond: ' num2str(condType) ' resp: ' num2str(respType)], 'center', 'center', black);
    
    if respType==condType    
        Screen('DrawDots', window, [xCenter; yCenter], 10, [0 1 0], [], 2); % Draw the fixation point
        zvbl = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi); % Flip to the scre
     else
        Screen('DrawDots', window, [xCenter; yCenter], 10, [1 0 0], [], 2); % Draw the fixation point
        zvbl = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi); % Flip to the scre
        pause(0.2)
     end
    
    
    %Pause randomly 0.5-1.5 seconds
    pause(0.5+rand)
end

% Clean up
PsychPortAudio('Close', pahandle); % Close the audio device
sca;

analyzeResponseMat(responseMat)