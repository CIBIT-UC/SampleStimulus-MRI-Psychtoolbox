function [  ] = eyeTrackerStop( aborted )
%EYETRACKERSTOP Stop Recording Eyetracker data and (maybe) save it
% Usage: [  ] = eyeTrackerStop( aborted )
%
% Inputs: 
%   : aborted - boolean to determine if eyetracker file is saved. 1 (Do not
%   save), 0 (Save)
%

% Stop recording eyetracker data

Eyelink('StopRecording'); % Stop the recording of eye-movements for the current trial
Eyelink('Message', 'TRIAL_RESULT 0') % Sending a 'TRIAL_RESULT' message to mark the end of a trial in Data Viewer.
Eyelink('CloseFile');

if ~aborted
    Eyelink('ReceiveFile');
end

end

