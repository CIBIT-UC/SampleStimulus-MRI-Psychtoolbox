function pix = angle2pix(width,hres,dist,ang)
%pix = angle2pix(width,hres,dist,ang)
%
% Converts visual angles in degrees to pixels.
%
%Inputs:
% width (width of screen (cm))
% hres (number of pixels of display in horizontal direction)
% dist (distance from screen (cm))
% ang (visual angle (degrees))
%
% Warning: assumes isotropic (square) pixels

% Calculate screen pixel size
pixSize = width/hres;   %cm/px

% Calculate stimulus size (in cm)
sz = 2*dist*tan(pi*ang/(2*180));  %cm

% Convert cm to px and round
pix = round(sz/pixSize);   %px

end
