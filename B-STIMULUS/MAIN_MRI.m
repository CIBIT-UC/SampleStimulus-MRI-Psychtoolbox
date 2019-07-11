%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%--------------------------- SAMPLE EXPERIMENT ---------------------------%
%------------------------------- Stimulus --------------------------------%
%------------------------------ Version 1.0 ------------------------------%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  ______________________________________________________________________
% |                                                                      |%
% | Authors: John Doe                                                    |%
% |                                                                      |%
% |                                                                      |%
% |                        CIBIT ICNAS      2019                         |%
% |______________________________________________________________________|%
%
% This script will run the experiment. Execute section by section.
%
% Version 1.0
% - Creation
%

clear; clc;
Screen('CloseAll');
IOPort('CloseAll');

addpath('functions')
addpath('functions-mri')

S = struct();

Outputs = struct();

%% Input
% --- Subject Name
S.SUBJECT = 'TestSubject';
S.SUBJECT_ID = 'TS'; % 2 characters exactly, for the eyetracker files

% --- Eyetracker, Trigger, Response box
S.EYETRACKER = false;
S.TRIGGER = false;
S.RSPBOX = false;

% --- Screen number
% Set this to 50 to choose the screen with the highest index.
screenNumber = 0;

%% Initialize important parameters
[ S ] = initExperimentParameters( S , screenNumber );

%% Sample Task - Run 01
Outputs.Run01 = runSampleTask( 'Protocol-SampleTask-Run01' , S );

%% Sample Task - Run 02
Outputs.Run02 = runSampleTask( 'Protocol-SampleTask-Run02' , S );

%% Save Workspace
save(fullfile(S.output_path,...
    [ S.SUBJECT '_Workspace_' datestr(now,'HHMM_ddmmmmyyyy')]),...
    'S','Outputs');

%% Close COMs
% Just because you are cool.
IOPort('Close',S.response_box_handle);
IOPort('Close',S.syncbox_handle);
