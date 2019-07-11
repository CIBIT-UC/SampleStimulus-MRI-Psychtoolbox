function [ success ] = eyeTrackerInit( windowID , S , runID )
%EYETRACKERINIT Initialise Eyetracker Parameters
% Usage: [ success ] = eyeTrackerInit( windowID , S , runID );
%
% Inputs:
%   : windowID - ID of the current window as returned by
%   Screen('OpenWindow')
%   : S - struct containing very important info (screen, subject, colors,
%   trigger, response box, eyetracker, etc)
%   : runID - Identifier for the run (2-character string)
%
% Output:
%   : success - Boolean
%

% Provide Eyelink with details about the graphics environment and perform some initializations
disp('[eyeTrackerInit] Start EyeLink procedures')

% Ensure Eyelink is not already open
Eyelink('Shutdown');

% Initiate Eyelink object
el = EyelinkInitDefaults(windowID);

disp('[eyeTrackerInit] EyeLink initialized with default parameters')

% Initialization of the connection with the Eyelink Gazetracker
% if we are NOT in dummy mode
if ~EyelinkInit(0, 1)
    fprintf('Eyelink Init aborted.\n');
    cleanup;  % cleanup function
    return
end

% Filename of eye tracker data !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
datastr = datestr(now, 'HHMM');
str_save = [S.SUBJECT_ID(1:2) , runID(1:2) , datastr];

edfFile = [str_save, '.edf'];

%--------------------------%
% Open file to record data %
%--------------------------%
openOK = Eyelink('Openfile', edfFile);
if openOK~=0
    fprintf('[eyeTrackerInit] Cannot create EDF file ''%s'' ', edfFile);
    cleanup;
    return;
end
disp('[eyeTrackerInit] File to record eyetracking data - OK')

% Grab the screen resolution from Psychtoolbox and write that to a DISPLAY_COORDS message
% [width, height] = Screen('WindowSize', screenNumber);
% This information is already in struct S (input).
Eyelink('message', 'DISPLAY_COORDS %ld %ld %ld %ld', 0, 0, S.screenX-1 , S.screenY-1);

% Also send a screen_pixel_coords command to the tracker with the same dimensions to ensure that both Data Viewer and the EyeLink use the same resolution
Eyelink('command','screen_pixel_coords = %ld %ld %ld %ld', 0, 0, S.screenX-1, S.screenY-1);

% Data Viewer will not scale the fixation locations when you change the Display Width and Display Height.
% Fixations will always be drawn at the pixel location of the fixation event in the .edf file.
% Of course, changing the Display Width and Display Height will cause the fixations to appear in a different place in the window due to the changed window size, but the pixel coordinates of the fixation will not change.

% Set calibration type.
Eyelink('command', 'calibration_type = HV9');

% Allow to use the big button on the eyelink gamepad to accept the
% calibration/drift correction target
Eyelink('command', 'button_function 5 "accept_target_fixation"');

% Make sure we're still connected.
if Eyelink('IsConnected')~=1 %&& dummymode == 0
    fprintf('[eyeTrackerInit] not connected, clean up\n');
    Eyelink( 'Shutdown');
    Screen('CloseAll');
    IOPort('CloseAll');
    pnet('closeall');
    ShowCursor;
    Priority(0);
    return
end

%-------------------------------------------------%
%   CALIBRATION, VALIDATION OR DRIFT CORRECTION   %
%-------------------------------------------------%
% Calibrate the eye tracker
% setup the proper calibration foreground and background colors
el.backgroundcolour = [128 128 128];
el.calibrationtargetcolour = [0 0 0];

% Parameters are in frequency, volume, and duration
% Set the second value in each line to 0 to turn off the sound
el.cal_target_beep = [600 0.5 0.05];
el.drift_correction_target_beep = [600 0.5 0.05];
el.calibration_failed_beep = [400 0.5 0.25];
el.calibration_success_beep = [800 0.5 0.25];
el.drift_correction_failed_beep = [400 0.5 0.25];
el.drift_correction_success_beep = [800 0.5 0.25];
% You must call this function to apply the changes from above
EyelinkUpdateDefaults(el);

% Do calibration, validation or drift correction
success = EyelinkDoTrackerSetup(el);

% Fill screen with black after calibration
Screen('FillRect', windowID, S.black, []);

end % End functions