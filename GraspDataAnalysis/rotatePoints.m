function [x_rotated, y_rotated]=rotatePoints(x,y,theta,x_center,y_center)
v = [x';y'];
center = repmat([x_center; y_center], 1, length(x)); %Matrix for centering
R = [cos(theta) -sin(theta); sin(theta) cos(theta)]; % define a counter-clockwise rotation matrix
s = v - center;     % shift points in the plane so that the center of rotation is at the origin
so = R*s;           % apply the rotation about the origin
vo = so + center;   % shift again so the origin goes back to the desired center of rotation

x_rotated = vo(1,:)';
y_rotated = vo(2,:)';