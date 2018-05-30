% Clear the workspace
clearvars;
close all;
sca;


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
toneDur = 1;                                           % Length of the beep in seconds
interToneInterval = 2;                                  % Length of the pause between beeps

% Prep the sound and put it in the buffer
InitializePsychSound(1);                                % Initialize Sounddriver
pahandle = PsychPortAudio('Open', [], 1, 1, sampleRate, nrchannels);
PsychPortAudio('Volume', pahandle, 0.5);                % Set the volume to half for this demo
myBeep = MakeBeep(toneHz, toneDur, sampleRate);         % Make a beep which we will play back to the user
% myBeep = myBeep*toneScale + randn(size(myBeep));        %Add in noise
PsychPortAudio('FillBuffer', pahandle, [myBeep; myBeep]);% Fill the audio playback buffer with the audio data

%---------------
% Screen Setup
%---------------

%Prep the screen
PsychDefaultSetup(2); % Here we call some default settings for setting up Psychtoolbox
screens = Screen('Screens');    % Get the screen numbers
screenNumber = max(screens); % Select the external screen if it is present

% Define black, white and grey
black = BlackIndex(screenNumber);
white = WhiteIndex(screenNumber);
grey = white / 2;

% Prep the window
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, grey); % Open an on screen window and color it grey
Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA'); % Set the blend funciton for the screen
[screenXpixels, screenYpixels] = Screen('WindowSize', window); % Get the size of the on screen window in pixels
ifi = Screen('GetFlipInterval', window); % Query the frame duration
[xCenter, yCenter] = RectCenter(windowRect); % Get the centre coordinate of the window in pixels
Screen('TextSize', window, 70); % Set the text size

% Calculate how long the beep and pause are in units frames
beepLengthFrames = round(toneDur / ifi);
beepPauseLengthFrames = round(interToneInterval / ifi);


% Now we draw our sequence of silence and beeps. You could obviously put
% this in a loop, but we will just do everything sequentially code-wise to
% show what is going on

%% Silence 1
for i = 1:beepPauseLengthFrames
    DrawFormattedText(window, 'SILENCE #1', 'center', 'center', [0 0 1]);
    Screen('Flip', window);
end
%% Sound 1
PsychPortAudio('Start', pahandle, repetitions, startCue, waitForDeviceStart); % Start audio playback #1

for i = 1:beepLengthFrames
    DrawFormattedText(window, 'BEEP #1', 'center', 'center', [1 0 0]);
    Screen('Flip', window);
end

PsychPortAudio('Stop', pahandle); % Stop playback, regardless whether it has finished or not. 

%% Silence 2
for i = 1:beepPauseLengthFrames
    DrawFormattedText(window, 'SILENCE #2', 'center', 'center', [0 0 1]);
    Screen('Flip', window);
end

%% Sound 2
PsychPortAudio('Start', pahandle, repetitions, startCue, waitForDeviceStart);
for i = 1:beepLengthFrames
    DrawFormattedText(window, 'BEEP #2', 'center', 'center', [1 0 0]);
    Screen('Flip', window);
end

PsychPortAudio('Stop', pahandle);

%% Silence 3
% for i = 1:beepPauseLengthFrames
%     DrawFormattedText(window, 'SILENCE #3', 'center', 'center', [0 0 1]);
%     Screen('Flip', window);
% end

%% Clean up shop

PsychPortAudio('Close', pahandle); % Close the audio device
sca %Clear the screen
close all %Close the windows