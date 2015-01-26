load('structure');
load('polygons'); %has indices of the vertices used for the polygons
load('rotations'); %has rotation matrices
load('texturePoints');
load('texturePointsSelected');
load('selectedXYData');

K1 = [1584 0 593; 0 1584 380; 0 0 1];
K2 = K1;
image1 = imread('myers1.ppm');
image2 = imread('myers2.ppm');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% polygon 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

A = [X3(:,10)'; X3(:,28)'; X3(:,12)'; X3(:,11)';];

[U D V] = svd(A);
plane = V(:,4);

n = plane(1:3,:);
z = n/ norm(n);

x = cross([0 1 0], z);
x = x/norm(x);

y = cross(z,x);

S = [x; y; z'];

H = K1 * S * inv(K1);

% select vertices again to find XYData
%{
figure(1);
imshow(image2);
tch1 = ginput(4);
tch1(1:4, 3) = 1;
tch1 = H * tch1';
tch1(1:3,1) = tch1(1:3,1)/ tch1(3,1);
tch1(1:3,2) = tch1(1:3,2)/ tch1(3,2);
tch1(1:3,3) = tch1(1:3,3)/ tch1(3,3);
tch1(1:3,4) = tch1(1:3,4)/ tch1(3,4);
display(tch1);
save selectedXYData tch1
%}
tcmin = min(tch1');
tcmax = max(tch1');
display(tch1);
T1 = maketform('projective', H');
%[texture1, xd, yd] = imtransform(image2, T1);
texture1 = imtransform(image2, T1, 'XData', [tcmin(1,1) tcmax(1,1)], 'YData', [tcmin(1,2) tcmax(1,2)]);
figure(1);
imshow(texture1);
imwrite(texture1, 'texture1.png');

[height width depth] = size(texture1);

%select new texture points
%{
tchtemp1 = ginput(4);
save texturePointsSelected tchtemp1
%}
tchnew1 = tchtemp1';

% make them between 0 and 1
tchnew1(1,1) = tchnew1(1,1)/ width;
tchnew1(1,2) = tchnew1(1,2)/ width;
tchnew1(1,3) = tchnew1(1,3)/ width;
tchnew1(1,4) = tchnew1(1,4)/ width;
tchnew1(2,1) = (height - tchnew1(2,1))/ height;
tchnew1(2,2) = (height - tchnew1(2,2))/ height;
tchnew1(2,3) = (height - tchnew1(2,3))/ height;
tchnew1(2,4) = (height - tchnew1(2,4))/ height;
save texturePoints2 tchnew1;
display(tchnew1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% polygon 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

A = [X3(:,1)'; X3(:,12)'; X3(:,15)'; X3(:,2)';];

[U D V] = svd(A);
plane = V(:,4);

n = plane(1:3,:);
z = n/ norm(n);

x = -cross(Rb(:,2)', z);
x = x/norm(x);

y = -cross(z,x);

S = [x; y; z'];

H = K1 * S * inv(Rb) * inv(K1);

% select vertices again to find XYData

%{
figure(1);
imshow(image1);
tch2 = ginput(4);
tch2(1:4, 3) = 1;
tch2 = H * tch2';
tch2(1:3,1) = tch2(1:3,1)/ tch2(3,1);
tch2(1:3,2) = tch2(1:3,2)/ tch2(3,2);
tch2(1:3,3) = tch2(1:3,3)/ tch2(3,3);
tch2(1:3,4) = tch2(1:3,4)/ tch2(3,4);
display(tch2);
save selectedXYData tch1 tch2
%}

tcmin = min(tch2');
tcmax = max(tch2');

T1 = maketform('projective', H');
%[texture2, xd, yd] = imtransform(image2, T1);
texture2 = imtransform(image1, T1, 'XData', [tcmin(1,1) tcmax(1,1)], 'YData', [tcmin(1,2) tcmax(1,2)]);
figure(2);
imshow(texture2);
imwrite(texture2, 'texture2.png');

[height width depth] = size(texture2);

%select new texture points

%tchtemp2 = ginput(4);
%save texturePointsSelected tchtemp1 tchtemp2

tchnew2 = tchtemp2';

% make them between 0 and 1
tchnew2(1,1) = tchnew2(1,1)/ width;
tchnew2(1,2) = tchnew2(1,2)/ width;
tchnew2(1,3) = tchnew2(1,3)/ width;
tchnew2(1,4) = tchnew2(1,4)/ width;
tchnew2(2,1) = (height - tchnew2(2,1))/ height;
tchnew2(2,2) = (height - tchnew2(2,2))/ height;
tchnew2(2,3) = (height - tchnew2(2,3))/ height;
tchnew2(2,4) = (height - tchnew2(2,4))/ height;
save texturePoints2 tchnew1 tchnew2;
display(tchnew2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% polygon 3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


A = [X3(:,2)'; X3(:,15)'; X3(:,29)'; X3(:,17)';];

[U D V] = svd(A);
plane = V(:,4);

n = plane(1:3,:);
z = n/ norm(n);

x = cross([0 1 0], z);
x = x/norm(x);

y = -cross(z,x);

S = [x; y; z'];

H = K1 * S * inv(K1);

% select vertices again to find XYData

%{
figure(1);
imshow(image2);
tch3 = ginput(4);
tch3(1:4, 3) = 1;
tch3 = H * tch3';
tch3(1:3,1) = tch3(1:3,1)/ tch3(3,1);
tch3(1:3,2) = tch3(1:3,2)/ tch3(3,2);
tch3(1:3,3) = tch3(1:3,3)/ tch3(3,3);
tch3(1:3,4) = tch3(1:3,4)/ tch3(3,4);
display(tch3);
save selectedXYData tch1 tch2 tch3
%}
tcmin = min(tch3');
tcmax = max(tch3');

T1 = maketform('projective', H');
%[texture3, xd, yd] = imtransform(image2, T1);
texture3 = imtransform(image2, T1, 'XData', [tcmin(1,1) tcmax(1,1)], 'YData', [tcmin(1,2) tcmax(1,2)]);
figure(3);
imshow(texture3);
imwrite(texture3, 'texture3.png');

[height width depth] = size(texture3);

%select new texture points

%tchtemp3 = ginput(4);
%save texturePointsSelected tchtemp1 tchtemp2 tchtemp3

tchnew3 = tchtemp3';

% make them between 0 and 1
tchnew3(1,1) = tchnew3(1,1)/ width;
tchnew3(1,2) = tchnew3(1,2)/ width;
tchnew3(1,3) = tchnew3(1,3)/ width;
tchnew3(1,4) = tchnew3(1,4)/ width;
tchnew3(2,1) = (height - tchnew3(2,1))/ height;
tchnew3(2,2) = (height - tchnew3(2,2))/ height;
tchnew3(2,3) = (height - tchnew3(2,3))/ height;
tchnew3(2,4) = (height - tchnew3(2,4))/ height;
save texturePoints2 tchnew1 tchnew2 tchnew3;
display(tchnew3);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% polygon 4
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

A = [X3(:,1)'; X3(:,12)'; X3(:,15)'; X3(:,2)';];

[U D V] = svd(A);
plane = V(:,4);

n = plane(1:3,:);
z = n/ norm(n);

x = -cross(Rb(:,2)', z);
x = x/norm(x);

y = -cross(z,x);

S = [x; y; z'];

H = K1 * S * inv(Rb) * inv(K1);

% select vertices again to find XYData

%{
figure(1);
imshow(image1);
tch4 = ginput(4);
tch4(1:4, 3) = 1;
tch4 = H * tch4';
tch4(1:3,1) = tch4(1:3,1)/ tch4(3,1);
tch4(1:3,2) = tch4(1:3,2)/ tch4(3,2);
tch4(1:3,3) = tch4(1:3,3)/ tch4(3,3);
tch4(1:3,4) = tch4(1:3,4)/ tch4(3,4);
save selectedXYData tch1 tch2 tch3 tch4
%} 
tcmin = min(tch4');
tcmax = max(tch4');

T1 = maketform('projective', H');
%[texture4, xd, yd] = imtransform(image2, T1);
texture4 = imtransform(image1, T1, 'XData', [tcmin(1,1) tcmax(1,1)], 'YData', [tcmin(1,2) tcmax(1,2)]);
figure(4);
imshow(texture4);
imwrite(texture4, 'texture4.png');

[height width depth] = size(texture4);

%select new texture points

%tchtemp4 = ginput(4);
%save texturePointsSelected tchtemp1 tchtemp2 tchtemp3 tchtemp4

tchnew4 = tchtemp4';

% make them between 0 and 1
tchnew4(1,1) = tchnew4(1,1)/ width;
tchnew4(1,2) = tchnew4(1,2)/ width;
tchnew4(1,3) = tchnew4(1,3)/ width;
tchnew4(1,4) = tchnew4(1,4)/ width;
tchnew4(2,1) = (height - tchnew4(2,1))/ height;
tchnew4(2,2) = (height - tchnew4(2,2))/ height;
tchnew4(2,3) = (height - tchnew4(2,3))/ height;
tchnew4(2,4) = (height - tchnew4(2,4))/ height;
save texturePoints2 tchnew1 tchnew2 tchnew3 tchnew4;
display(tchnew4);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% polygon 5
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
A = [X3(:,25)'; X3(:,24)'; X3(:,27)'; X3(:,26)';];

[U D V] = svd(A);
plane = V(:,4);

n = plane(1:3,:);
z = n/ norm(n);

x = cross([0 1 0], z);
x = x/norm(x);

y = cross(z,x);

S = [x; y; z'];

H = K1 * S * inv(K1);

% select vertices again to find XYData

%{
figure(1);
imshow(image2);
tch5 = ginput(4);
tch5(1:4, 3) = 1;
tch5 = H * tch5';
tch5(1:3,1) = tch5(1:3,1)/ tch5(3,1);
tch5(1:3,2) = tch5(1:3,2)/ tch5(3,2);
tch5(1:3,3) = tch5(1:3,3)/ tch5(3,3);
tch5(1:3,4) = tch5(1:3,4)/ tch5(3,4);
save selectedXYData tch1 tch2 tch3 tch4 tch5
%}
tcmin = min(tch5');
tcmax = max(tch5');

T1 = maketform('projective', H');
%[texture5, xd, yd] = imtransform(image2, T1);
texture5 = imtransform(image2, T1, 'XData', [tcmin(1,1) tcmax(1,1)], 'YData', [tcmin(1,2) tcmax(1,2)]);
figure(5);
imshow(texture5);
imwrite(texture5, 'texture5.png');

[height width depth] = size(texture5);

%select new texture points

%tchtemp5 = ginput(4);
%save texturePointsSelected tchtemp1 tchtemp2 tchtemp3 tchtemp4 tchtemp5

tchnew5 = tchtemp5';

% make them between 0 and 1
tchnew5(1,1) = tchnew5(1,1)/ width;
tchnew5(1,2) = tchnew5(1,2)/ width;
tchnew5(1,3) = tchnew5(1,3)/ width;
tchnew5(1,4) = tchnew5(1,4)/ width;
tchnew5(2,1) = (height - tchnew5(2,1))/ height;
tchnew5(2,2) = (height - tchnew5(2,2))/ height;
tchnew5(2,3) = (height - tchnew5(2,3))/ height;
tchnew5(2,4) = (height - tchnew5(2,4))/ height;
save texturePoints2 tchnew1 tchnew2 tchnew3 tchnew4 tchnew5;
display(tchnew4);
