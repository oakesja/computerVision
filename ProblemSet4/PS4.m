K1 = [1584 0 593; 0 1584 380; 0 0 1];
K2 = K1;
% read a pair of images
%i1 = imread('shed1.png');
i1 = imread('myers1.ppm');
figure(1); clf; imshow(i1); hold on; zoom off; axl = axis;
%i2 = imread('shed2.png');
i2 = imread('myers2.ppm');
figure(2); clf; imshow(i2); hold on; zoom off; axr = axis;

% load the corresponding points
load('correspondences');
%load('shed_correspondences');

showPoints(i1, i2, input_points', base_points');

% use the cpselect tool to check and adjust the correspondences
%[ipi, ipb] = cpselect(i1, i2, input_points, base_points, 'Wait', true);

% convert the 2-vectors to 3-vectors (i.e. points in P2)
ip1 = [input_points'; ones(1, size(input_points,1))];
ip2 = [base_points'; ones(1, size(base_points,1))];

% *** create a matlab function that will normalize the data ***

% calculate the transformation that will normalize the data
T1n = normalizePoints(ip1);
T2n = normalizePoints(ip2);

save T_matrices.mat T1n T2n;
% apply the normalization to the image points
ipn1 = T1n*ip1;
ipn2 = T2n*ip2;

% calculate the normalized F matrix using svd

[x, y] =  size(ipn1);
A = zeros(y, 9);
display(T1n);
display(ipn2);
for i = 1: y
    A(i, 1) = ipn2(1, i) * ipn1(1, i);
    A(i, 2) = ipn1(1, i) * ipn2(2, i);
    A(i, 3) = ipn1(1, i);
    A(i, 4) = ipn1(2, i) * ipn2(1, i);
    A(i, 5) = ipn1(2, i) * ipn2(2, i);
    A(i, 6) = ipn1(2, i);
    A(i, 7) = ipn2(1, i);
    A(i, 8) = ipn2(2, i);
    A(i, 9) = 1;
end
display(A);
[U, D, V] = svd(A);
f = V(:, 9);
Fn = (reshape(f, 3, 3)');
display(Fn);

for i = 1: y
    %ipn2(:,i)'*Fn*ipn1(:,i)
end

% enforce the constraint that F has 7 degrees of freedom
[U, D, V] = svd(Fn);
D(3,3) = 0;
display(D);
Fn = U*D*V';
display(Fn);

save Fnorm Fn;

% unnormalize F (i.e. convert F so that it works with actual image
% points not normalized data)

F = T1n'*Fn*T2n;

display(F);

save Fmatrix F;

% confirm that the epipolar geometry is consistent with the images
% by plotting points and corresponding epipolar lines.

% See Day13 for some helpful examples.

% *** Fill in your code ***
%{
ll = F*ip2(:,1);
lr = ((ip1(:,1))'* F)';
figure(2);
drawLine(lr, axr);
figure(1);
drawLine(ll, axl);
%}
figure(1);
pr = ginput(1);
plot([pr(1)], [pr(2)], 'ro', 'LineWidth', 2);
lr = ([pr(1); pr(2); 1]'* F)';
figure(2);
drawLine(lr, axr);

figure(1);
pr = ginput(1);
plot([pr(1)], [pr(2)], 'ro', 'LineWidth', 2);
lr = ([pr(1); pr(2); 1]'* F)';
figure(2);
drawLine(lr, axr);

figure(1);
pr = ginput(1);
plot([pr(1)], [pr(2)], 'ro', 'LineWidth', 2);
lr = ([pr(1); pr(2); 1]'* F)';
figure(2);
drawLine(lr, axr);

figure(2);
pr = ginput(1);
plot([pr(1)], [pr(2)], 'ro', 'LineWidth', 2);
ll = F*[pr(1); pr(2); 1];
figure(1);
drawLine(ll, axr);

figure(2);
pr = ginput(1);
plot([pr(1)], [pr(2)], 'ro', 'LineWidth', 2);
ll = F*[pr(1); pr(2); 1];
figure(1);
drawLine(ll, axr);

figure(2);
pr = ginput(1);
plot([pr(1)], [pr(2)], 'ro', 'LineWidth', 2);
ll = F*[pr(1); pr(2); 1];
figure(1);
drawLine(ll, axr);


% load the camera calibration matrices
% This is the wrong camera data
%load('K1_K2');
% Use this one
load('K');
K1 = K;
K2 = K;

% calculate E using F and K1, K2
E = K1'*F*K2;

% enforce the constraint that E has only 5 degrees of freedom

[U, D, V] = svd(E);
temp = (D(1,1) + D(2,2))/ 2;
D(1,1) = temp;
D(2,2) = temp;
D(3,3) = 0;
E = U*D*V'

save EMatrix E;

% calculate the possible camera matrices

W = [0 -1 0; 1 0 0; 0 0 1];

Ra = U*W*V';
Rb = U*W'*V';
T = U(:,3);

save R-T-Matrices Ra Rb T;

P1a = K1*[Ra T];
P1b = K1*[Ra -T];
P1c = K1*[Rb T];
P1d = K1*[Rb -T];

P2a = K2*[Ra T];
P2b = K2*[Ra -T];
P2c = K2*[Rb T];
P2d = K2*[Rb -T];


