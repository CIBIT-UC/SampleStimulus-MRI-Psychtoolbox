function [dots] = buildDots()
%BUILDDOTS Function to initialize info abou the dots
% Usage: [dots] = buildDots()
%
% Outputs:
%   : dots - struct with info about the dots (position, aperture,
%   size, color, etc).
%

dots = struct();
dots.nDots = 350;                % number of dots
dots.color = [255,255,255];      % color of the dots
dots.size = 6;                   % size of dots (pixels)
dots.apertureSize = [9,9];       % size of rectangular aperture [w,h] in degrees.

dots.speed = 3;       %degrees/second

dots.direction = [ 0 45 90 120 180 225 270 315 ];  %degrees (clockwise from straight up)
dots.nDir = length(dots.direction);

% Start at the center of the screen
dots.center = [0,0];

% Calculate the left, right top and bottom of the aperture (in degrees)
dots.l = dots.center(1)-dots.apertureSize(1)/2;
dots.r = dots.center(1)+dots.apertureSize(1)/2;
dots.b = dots.center(2)-dots.apertureSize(2)/2;
dots.t = dots.center(2)+dots.apertureSize(2)/2;

% New random starting positions
dots.x = (rand(1,dots.nDots)-.5)*dots.apertureSize(1) + dots.center(1);
dots.y = (rand(1,dots.nDots)-.5)*dots.apertureSize(2) + dots.center(2);

dots.idx = [];
dots.dx = [];
dots.dy = [];

end
