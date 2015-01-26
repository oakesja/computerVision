% Load an image of a tile floor with perspective distortion
%i = imread('tile_floor.ppm');
i = imread('moench_tile_small.ppm');

% Display the image
figure(1);
imshow(i);
% Select the 4 corners of an actual square (either clockwise or
% counterclockwise
%p1 = ginput(4);

recitify_direct_and_affine_points = [299 370; 56 175; 301 101; 546 193];

% Map the points to a 200 pixel square
p2 = [ 0 0; 0 200; 200 200; 200 0];

% Remove the perspective distortion by mapping the 4 image points
% to a square
%
% You must write this function
H1 = rectify_direct_metric(p2', recitify_direct_and_affine_points');

% Create a matlab Tform
T1 = maketform('projective', H1');

% Apply the Tform to the image
it1 = imtransform(i, T1, 'XYScale', .25);

% Display the transformed image
figure(2);
imshow(it1);

% Restore parallel lines by moving the image of the line at
% infinity back to infinity.
%
% You must write this function
H2 = rectify_affine_square(recitify_direct_and_affine_points');

% Create a matlab Tform
T2 = maketform('projective', H2');

% Apply the Tform to the image
it2 = imtransform(i, T2);

% Display the transformed image
figure(3);
imshow(it2);

%Cross ratio
cross_ratio_points1 = [298 370; 147 248; 56 175];
cross_ratio_points2 = [298 370; 453 260; 546 193];

v1 = cross_ratio(cross_ratio_points1);
v2 = cross_ratio(cross_ratio_points2);
display(v1);
display(v2);

