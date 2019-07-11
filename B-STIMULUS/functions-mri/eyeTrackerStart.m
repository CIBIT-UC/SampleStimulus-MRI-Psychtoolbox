function [  ] = eyeTrackerStart(  )
%EYETRACKERSTART Start Recording Eyetracker Data
% Requires the function eyeTrackerInit() to be run before.
%

% Number of trial
trial_numb = 1;

Eyelink('Message', 'TRIALID %d', trial_numb); % number of the trial. Sending a 'TRIALID' message to mark the start of a trial in Data Viewer.

% This supplies the title at the bottom of the eyetracker display
% Eyelink('command', 'record_status_message "TRIAL %s"', str_save(1:4));

Eyelink('StartRecording');
Eyelink('Message', 'SYNCTIME');  % Mark zero-plot time in data file

end %End function

