K1 = [1584 0 593; 0 1584 380; 0 0 1];
K2 = K1;
%load('K1_K2');
% read a pair of images
%i1 = imread('shed1.png');
i1 = imread('myers1.ppm');
%figure(1); clf; imshow(i1); hold on; zoom off; axl = axis;
%i2 = imread('shed2.png');
i2 = imread('myers2.ppm');
%figure(2); clf; imshow(i2); hold on; zoom off; axr = axis;

% load the corresponding points
load('correspondences');
%load('shed_correspondences');

% use the cpselect tool to check and adjust the correspondences
[ipi, ipb] = cpselect(i1, i2, input_points, base_points, 'Wait', true);

input_points = ipi;
base_points = ipb;

%showPoints(i1, i2, input_points', base_points');


save correspondences input_points base_points

% convert the 2-vectors to 3-vectors (i.e. points in P2)
ip1 = [input_points'; ones(1, size(input_points,1))];
ip2 = [base_points'; ones(1, size(base_points,1))];

% calculate the transformation that will normalize the data
T1n = normalizePoints(ip1);
T2n = normalizePoints(ip2);

% apply the normalization to the image points
ipn1 = T1n*ip1;
ipn2 = T2n*ip2;

% calculate the normalized F matrix using svd

[x, y] =  size(ipn1);
A = zeros(y, 9);

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

% enforce the constraint that F has 7 degrees of freedom
[U, D, V] = svd(Fn);
D(3,3) = 0;
Fn = U*D*V';

% unnormalize F (i.e. convert F so that it works with actual image
% points not normalized data)

F = T1n'*Fn*T2n;

% confirm that the epipolar geometry is consistent with the images
% by plotting points and corresponding epipolar lines.

%{
ll = F*ip2(:,1);
lr = ((ip1(:,1))'* F)';
figure(2);
drawLine(lr, axr);
figure(1);
drawLine(ll, axl);

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
%}

% calculate E using F and K1, K2
E = K1'*F*K2;
display(E);

% enforce the constraint that E has only 5 degrees of freedom

[U, D, V] = svd(E);
temp = (D(1,1) + D(2,2))/ 2;
D(1,1) = temp;
D(2,2) = temp;
D(3,3) = 0;
display(D);
E = U*D*V';
display(E);

% calculate the possible camera matrices
[U, D, V] = svd(E);

W = [0 -1 0; 1 0 0; 0 0 1];

Ra = U*W*V';
display(Ra);
Rb = U*W'*V';
T = U(:,3);

P1a = K1*[Ra T];
P1b = K1*[Ra -T];
P1c = K1*[Rb T];
P1d = K1*[Rb -T];

P2 = K2 * [eye(3) zeros(3,1)];

X1 = pointsTo3D(P1a, P2, ip1, ip2);
X2 = pointsTo3D(P1b, P2, ip1, ip2);
X3 = pointsTo3D(P1c, P2, ip1, ip2);
X4 = pointsTo3D(P1d, P2, ip1, ip2);

save structure P1a P1b P1c P1d P2 X1 X2 X3 X4;
save rotations Ra Rb;

%correctXcheck = pointsTo3D(K2*[Ra -T], P2, ip1, ip2);
%display(correctXcheck);
plotPoints(X4);
polygons = {1, 5};
polygons{1,1} = [10 28 12 11];
polygons{1,2} = [1 12 15 2];
polygons{1,3} = [2 15 29 17];
polygons{1,4} = [17 23 24 25];
polygons{1,5} = [24 27 26 25];

save polygons polygons;

makeUntexturedModel('myers_wire.wrl', X4, polygons, [0 0 1 3.14], 1);

load texturePoints2;
tps = {1,5};
tps{1,1} = tchnew1;
tps{1,2} = tchnew2;
tps{1,3} = tchnew3;
tps{1,4} = tchnew4;
tps{1,5} = tchnew5;
txts = {1,5};
txts{1,1} = 'texture1.png';
txts{1,2} = 'texture2.png';
txts{1,3} = 'texture3.png';
txts{1,4} = 'texture4.png';
txts{1,5} = 'texture5.png';


makeTexturedModel('myers_texture.wrl', X4, polygons, txts, tps, [0 0 1 3.14], 1);

world = vrworld('myers_texture.wrl');
open(world);
view(world);
close(world);





