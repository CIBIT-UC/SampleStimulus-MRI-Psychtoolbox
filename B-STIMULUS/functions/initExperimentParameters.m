function [ S ] = initExperimentParameters( S , sNumber )
%INITEXPERIMENTPARAMETERS Initialise parameters for the protocol.
% Usage: [ S ] = initExperimentParameters( S , sNumber );
%
% Inputs:
%   : S - struct containing very important info (screen, subject, colors,
%   trigger, response box, eyetracker, etc)
%   : sNumber - screen number (if set to 50, the screen with the highest
%   index is selected)
% Outputs:
%   : S - same as input, a lot fatter :)
%

% --- Define screen number based on input
screens = Screen('Screens');
if sNumber == 50
    S.screenNumber = max(screens);
else
    S.screenNumber = sNumber;
end

% --- Settings
Screen('Preference', 'SkipSyncTests', 1);
KbName('UnifyKeyNames');

% --- Determine screen size and set colors
[S.screenX, S.screenY] = Screen('WindowSize', S.screenNumber);

S.white = WhiteIndex(S.screenNumber);
S.black = BlackIndex(S.screenNumber);
S.grey = S.white / 2;

S.screenBackground = 0;
S.textBackground = 50;
S.lines = 130;

% --- Stimulus/Experiment/Setup Settings
S.TR = 1; % Repetition time in seconds
S.fps = Screen('FrameRate',S.screenNumber); % Screen Frame Rate
S.dist = 156;  % Distance from eye to screen in cm
S.width = 70; % Width of the screen in cm

% --- Folders
S.input_path = fullfile(pwd,'input');
S.output_path = fullfile(pwd,'output');

if ~exist(S.input_path,'dir'); mkdir(S.input_path); end
if ~exist(S.output_path,'dir'); mkdir(S.output_path); end

% --- Open COM Ports for MRI Response box and Trigger
if S.RSPBOX
    S.response_box_handle = IOPort('OpenSerialPort','COM3');
    IOPort('Purge',S.response_box_handle); % Force clean data
end

if S.TRIGGER
    S.syncbox_handle = IOPort('OpenSerialPort', 'COM2', 'BaudRate=57600 DataBits=8 Parity=None StopBits=1 FlowControl=None');
    IOPort('Purge',S.syncbox_handle); % Force clean data
end

end % End function
