function [dots, idx, dx, dy, changeDir] = drawMovingDots(windowID, S, dots, idx, dx, dy, changeDir)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

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
    dx = cell(1,dots.nDir);
    dy = cell(1,dots.nDir);
    
    for d = 1:dots.nDir
        dx{d} = dots.speed*sin(dots.direction(d)*pi/180)/S.fps;
        dy{d} = -dots.speed*cos(dots.direction(d)*pi/180)/S.fps;
    end
    
    idx = randperm(dots.nDots);
end

% Update the dot position
for d = 1:dots.nDir
    dots.x(idx(d:dots.nDir:end)) = dots.x(idx(d:dots.nDir:end)) + dx{d};
    dots.y(idx(d:dots.nDir:end)) = dots.y(idx(d:dots.nDir:end)) + dy{d};
end

% Move the dots that are outside the aperture back one aperture width.
dots.x(dots.x<dots.l) = dots.x(dots.x<dots.l) + dots.apertureSize(1);
dots.x(dots.x>dots.r) = dots.x(dots.x>dots.r) - dots.apertureSize(1);
dots.y(dots.y<dots.b) = dots.y(dots.y<dots.b) + dots.apertureSize(2);
dots.y(dots.y>dots.t) = dots.y(dots.y>dots.t) - dots.apertureSize(2);

end
