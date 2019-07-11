function [  ] = drawFixationCross( window , S , colour )
%DRAWFIXATIONCROSS Build and Draw a fixation cross on the current window
% Usage:  [  ] = drawFixationCross( window , S , cond , event )
% 
% Inputs:
%   : window - ID of the current window as returned by
%   Screen('OpenWindow')
%   : S - struct containing very important info (screen, subject, colors,
%   trigger, response box, eyetracker, etc)
%   : cond - Determines the colour of the cross. 1 (Orange), 100 (Green),
%   101 (Red), else (Purple)
%   : event - Determines the size of the cross. 1 (Big), else (Normal)
%

% Here we set the size of the arms of our fixation cross (pixels)
fixCrossDimPix = 30;

switch colour  
    case 'orange'
        fixCrossColor = [220 160 25];
    case 'purple'
        fixCrossColor = [153 0 153];
    case 'red'
        fixCrossColor = [255 0 0];
    case 'green'
        fixCrossColor = [0 255 0];
    otherwise
        fixCrossColor = [255 255 255];
end

% Now we set the coordinates (these are all relative to zero we will let
% the drawing routine center the cross in the center of our monitor for us)
xCoords = [-fixCrossDimPix fixCrossDimPix 0 0];
yCoords = [0 0 -fixCrossDimPix fixCrossDimPix];
allCoords = [xCoords; yCoords];

% Set the line width for our fixation cross
lineWidthPix = 6;

% Draw the fixation cross
Screen('DrawLines', window, allCoords,lineWidthPix, fixCrossColor , [S.xCenter S.yCenter] );

end % End function
