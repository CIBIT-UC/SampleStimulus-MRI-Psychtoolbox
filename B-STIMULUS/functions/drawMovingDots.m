function [dots, changeDir] = drawMovingDots(windowID, S, dots, changeDir)
%DRAWMOVINGDOTS Function to move and draw the dots
% Usage: [dots, changeDir] = drawMovingDots(windowID, S, dots, changeDir);
%
% Inputs:
%   : windowID - phychtoolbox windows handle.
%   : S - struct containing very important info (screen, subject, colors,
%   trigger, response box, eyetracker, etc). Generated by 
%   initExperimentParameters().
%   : dots - struct to save data about the dots (position, aperure, size,
%   etc). Initially generated by buildDots().
%   : changeDir - boolean to change direction of each moving dot.
%
% Outputs:
%   : dots - updated struct with info about the dots (position, aperture,
%   size, etc).
%   : changeDir - updated boolean to change direction of each moving dot.
%

% Use the equation of an ellipse to determine which dots fall inside.
goodDots = ((dots.x-dots.center(1)).^2/(dots.apertureSize(1)/2)^2 + ...
    (dots.y-dots.center(2)).^2/(dots.apertureSize(2)/2)^2) < 1;

pixpos.x = angle2pix(S.width,S.screenX,S.dist,...
    dots.x)+ S.screenX/2;
pixpos.y = angle2pix(S.width,S.screenX,S.dist,...
    dots.y)+ S.screenY/2;

% Draw Dots
Screen('DrawDots',windowID,...
    [pixpos.x(goodDots);pixpos.y(goodDots)], dots.size, ...
    dots.color,[0,0],1);

if changeDir
    changeDir = false;
    
    % Movement
    dots.dx = cell(1,dots.nDir);
    dots.dy = cell(1,dots.nDir);
    
    for d = 1:dots.nDir
        dots.dx{d} = dots.speed*sin(dots.direction(d)*pi/180)/S.fps;
        dots.dy{d} = -dots.speed*cos(dots.direction(d)*pi/180)/S.fps;
    end
    
    dots.idx = randperm(dots.nDots);
end

% Update the dot position
for d = 1:dots.nDir
    dots.x(dots.idx(d:dots.nDir:end)) = dots.x(dots.idx(d:dots.nDir:end)) + dots.dx{d};
    dots.y(dots.idx(d:dots.nDir:end)) = dots.y(dots.idx(d:dots.nDir:end)) + dots.dy{d};
end

% Move the dots that are outside the aperture back one aperture width.
dots.x(dots.x<dots.l) = dots.x(dots.x<dots.l) + dots.apertureSize(1);
dots.x(dots.x>dots.r) = dots.x(dots.x>dots.r) - dots.apertureSize(1);
dots.y(dots.y<dots.b) = dots.y(dots.y<dots.b) + dots.apertureSize(2);
dots.y(dots.y>dots.t) = dots.y(dots.y>dots.t) - dots.apertureSize(2);

end
