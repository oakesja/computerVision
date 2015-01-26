% Load and display the converging images
L = imread('left_converge.ppm');
figure, imshow(L)
R = imread('right_converge.ppm');
figure, imshow(R)

% Load camera calibration
KL = [1024 0 127.5; 0 1024 127.5; 0 0 1];
RL = [2/sqrt(5) 0 1/sqrt(5); 0 1 0; 1/sqrt(5) 0 -2/sqrt(5)];
CL = [-50; 0; 100];

KR = [1024 0 127.5; 0 1024 127.5; 0 0 1];
RR = [2/sqrt(5) 0 -1/sqrt(5); 0 1 0; -1/sqrt(5) 0 -2/sqrt(5)];
CR = [50; 0; 100];

% get x vector
vx = (CL-CR);
vx= vx/norm(vx);

% get y and z vector for the left image
vy1 = cross(RL(3,:)',vx);
vy1 = vy1/norm(vy1);
vz1 = cross(vx,vy1);

% get y and z vector for the right image
vy2 = cross(RR(3,:)',vx);
vy2 = vy2/norm(vy2);
vz2 = cross(vx,vy2);

% create rotations matrix
RectL = [vx';vy1';vz1'];
RectR = [vx';vy2';vz2'];

% find the homography to do the rectification
HL = KL*RectL*inv(RL)*inv(KL);
HR = KL*RectR*inv(RR)*inv(KR);

tl = maketform('projective',HL');
t2 = maketform('projective',HR');
LIR = imtransform(L, tl);
RIR = imtransform(R, t2);

figure, imshow(LIR);
figure, imshow(RIR);