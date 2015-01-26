function [ image, H] = getH( p1, p2, i1, i2 )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

R = makeresampler({'linear','linear'},'bound');

H = cp2tform(p1,p2,'projective');
T2 = maketform('projective',eye(3));

[i1t, x1, y1] = imtransform(i1, H);
[i2t, x2, y2] = imtransform(i2, T2);

% Combine the x and y coordinates
x = [ x1; x2];
y = [ y1; y2];
% Find the max of the maxs and the min of the mins
xdata = [min(x(:,1)) max(x(:,2))];
ydata = [min(y(:,1)) max(y(:,2))];

% Transform both images specifying the x and y ranges
i1t = imtransform(i1, H, R, 'XData', xdata, 'YData', ydata);
i2t = imtransform(i2, T2, R, 'XData', xdata, 'YData', ydata);

% Combine the 2 images
image = combineImages({i1t, i2t});


end

