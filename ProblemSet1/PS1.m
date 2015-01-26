% loads images
left = imread('C:/Users/oakesja/Downloads/left.ppm');
right = imread('C:/Users/oakesja/Downloads/right.ppm');
mid = imread('C:/Users/oakesja/Downloads/mid.ppm');

% finds the focal length
[hm, wm, dm] = size(mid);
fov = 33.25;
width = wm / 2;
angleA = 90;
angleC = 33.25/2;
angleB = 180 - angleA - angleC;
focal = (width * sin(angleB * pi / 180)) / sin(angleC * pi / 180);

% shows images and gets the points clicked
imshow(left);
[x1, y1] = ginput(1);
imshow(mid);
[x2, y2] = ginput(1);
imshow(right);
[x3, y3] = ginput(1);

% finds alpha 1 using left image
b1 = width - x1;
a1 = sqrt(focal * focal + b1 * b1 - 2 * focal * b1 * cos(90 * pi / 180));
B1 = asin((sin(90 * pi / 180) * b1)/ a1) + pi/2;

% finds alpha 1 using mid image
b2 = width - x2;
a2 = sqrt(focal * focal + b2 * b2 - 2 * focal * b2 * cos(90 * pi / 180));
B2 = asin((sin(90 * pi / 180) * b2)/ a2) + pi/2;

% find alpha x using right image
b3 = width - x3;
a3 = sqrt(focal * focal + b3 * b3 - 2 * focal * b3 * cos(90 * pi / 180));
B3 = pi/2 - asin((sin(90 * pi / 180) * b3)/ a3);

% finds the hypotenuse of the large triage
h1 = ASA(B1, 2, B3);
h2 = ASA(B2, 1, B3);

% finds the depth Z
z1 = GetZ(h1, B3);
z2 = GetZ(h2, B3);

z = (z1 + z2) / 2;
display(z);



