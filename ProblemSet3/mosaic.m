% must load points

% load images
i1 = imread('root_quadrangle01.ppm');
i2 = imread('root_quadrangle02.ppm');
i3 = imread('root_quadrangle03.ppm');
i4 = imread('root_quadrangle04.ppm');
i5 = imread('root_quadrangle05.ppm');
i6 = imread('root_quadrangle06.ppm');
i7 = imread('root_quadrangle07.ppm');
i8 = imread('root_quadrangle08.ppm');
i9 = imread('root_quadrangle09.ppm');
i10 = imread('root_quadrangle10.ppm');
i11 = imread('root_quadrangle11.ppm');
i12 = imread('root_quadrangle12.ppm');
i13 = imread('root_quadrangle13.ppm');

iw1 = imread('wilson_mural_north01.ppm');
iw2 = imread('wilson_mural_north02.ppm');
iw3 = imread('wilson_mural_north03.ppm');
iw4 = imread('wilson_mural_north04.ppm');
iw5 = imread('wilson_mural_north05.ppm');
iw6 = imread('wilson_mural_north06.ppm');
iw7 = imread('wilson_mural_north07.ppm');
iw8 = imread('wilson_mural_north08.ppm');
iw9 = imread('wilson_mural_north09.ppm');
iw10 = imread('wilson_mural_north10.ppm');
iw11 = imread('wilson_mural_north11.ppm');
iw12 = imread('wilson_mural_north12.ppm');


images1 = {i1, i2, i3, i4, i5, i6, i7, i8, i9, i10, i11, i12, i13};
images2 = {iw1, iw2, iw3, iw4, iw5, iw6, iw7, iw8, iw9, iw10, iw11, iw12};

n = length(images1) - 1;

% choose matching points for quad
%{
for i = 1:n
    temp1 = points{i, 1};
    temp2 = points{i, 2};
    [temp1, temp2] = cpselect(images{i}, images{i+1}, temp1, temp2, 'Wait', true);
    points{i, 1} = temp1;
    points{i, 2} = temp2;
end
%}

% get homographies to go between each pair
Hcell = cell(n,1);
for i = 1:n
    temp1 = points{i, 1};
    temp2 = points{i, 2};
    [im, H] = getH(temp1, temp2, images1{i}, images1{i+1});
    Hcell{i} = H.tdata.T;
    %figure(i);
    %imshow(im);
end

% get the combined mosaic of the qud
img = combineQuad(images1, Hcell);
figure(1);
imshow(img);
imwrite(img, 'quad-mosaic.ppm');


% get necessary homographies for wilson mural
n = length(images2) -1;

%choose matching points for wilson north mural
%{
[temp1, temp2] = cpselect(images2{1}, images2{2}, points2{1, 1}, points2{1, 2}, 'Wait', true);
points2{1, 1} = temp1;
points2{1, 2} = temp2;
[temp1, temp2] = cpselect(images2{3}, images2{2}, points2{2, 1}, points2{2, 2}, 'Wait', true);
points2{2, 1} = temp1;
points2{2, 2} = temp2;
[temp1, temp2] = cpselect(images2{4}, images2{3}, points2{3, 1}, points2{3, 2}, 'Wait', true);
points2{3, 1} = temp1;
points2{3, 2} = temp2;
[temp1, temp2] = cpselect(images2{2}, images2{6}, points2{4, 1}, points2{4, 2}, 'Wait', true);
points2{4, 1} = temp1;
points2{4, 2} = temp2;
[temp1, temp2] = cpselect(images2{5}, images2{6}, points2{5, 1}, points2{5, 2}, 'Wait', true);
points2{5, 1} = temp1;
points2{5, 2} = temp2;
[temp1, temp2] = cpselect(images2{7}, images2{6}, points2{6, 1}, points2{6, 2}, 'Wait', true);
points2{6, 1} = temp1;
points2{6, 2} = temp2;
[temp1, temp2] = cpselect(images2{8}, images2{7}, points2{7, 1}, points2{7, 2}, 'Wait', true);
points2{7, 1} = temp1;
points2{7, 2} = temp2;
[temp1, temp2] = cpselect(images2{9}, images2{10}, points2{8, 1}, points2{8, 2}, 'Wait', true);
points2{8, 1} = temp1;
points2{8, 2} = temp2;
[temp1, temp2] = cpselect(images2{11}, images2{10}, points2{9, 1}, points2{9, 2}, 'Wait', true);
points2{9, 1} = temp1;
points2{9, 2} = temp2;
[temp1, temp2] = cpselect(images2{12}, images2{11}, points2{10, 1}, points2{10, 2}, 'Wait', true);
points2{10, 1} = temp1;
points2{10, 2} = temp2;
[temp1, temp2] = cpselect(images2{10}, images2{6}, points2{11, 1}, points2{11, 2}, 'Wait', true);
points2{11, 1} = temp1;
points2{11, 2} = temp2;
[temp1, temp2] = cpselect(images2{4}, images2{8}, points2{12, 1}, points2{12, 2}, 'Wait', true);
points2{12, 1} = temp1;
points2{12, 2} = temp2;
[temp1, temp2] = cpselect(images2{12}, images2{8}, points2{13, 1}, points2{13, 2}, 'Wait', true);
points2{13, 1} = temp1;
points2{13, 2} = temp2;
[temp1, temp2] = cpselect(images2{4}, images2{7}, points2{14, 1}, points2{14, 2}, 'Wait', true);
points2{14, 1} = temp1;
points2{14, 2} = temp2;
[temp1, temp2] = cpselect(images2{3}, images2{7}, points2{15, 1}, points2{15, 2}, 'Wait', true);
points2{15, 1} = temp1;
points2{15, 2} = temp2;
[temp1, temp2] = cpselect(images2{1}, images2{6}, points2{16, 1}, points2{16, 2}, 'Wait', true);
points2{16, 1} = temp1;
points2{16, 2} = temp2;
[temp1, temp2] = cpselect(images2{11}, images2{7}, points2{17, 1}, points2{17, 2}, 'Wait', true);
points2{17, 1} = temp1;
points2{17, 2} = temp2;
[temp1, temp2] = cpselect(images2{9}, images2{5}, points2{19, 1}, points2{19, 2}, 'Wait', true);
points2{19, 1} = temp1;
points2{19, 2} = temp2;
%}

% gets the homographie to go in between each pair of images
Hcell = cell(n,1);
[im, H] = getH(points2{1,1}, points2{1,2}, images2{1}, images2{2});
Hcell{1} = H.tdata.T;
[im, H] = getH(points2{2,1}, points2{2,2}, images2{3}, images2{2});
Hcell{2} = H.tdata.T;
[im, H] = getH(points2{3,1}, points2{3,2}, images2{4}, images2{3});
Hcell{3} = H.tdata.T;
[im, H] = getH(points2{4,1}, points2{4,2}, images2{2}, images2{6});
Hcell{4} = H.tdata.T;
[im, H] = getH(points2{5,1}, points2{5,2}, images2{5}, images2{6});
Hcell{5} = H.tdata.T;
[im, H] = getH(points2{6,1}, points2{6,2}, images2{7}, images2{6});
Hcell{6} = H.tdata.T;
[im, H] = getH(points2{7,1}, points2{7,2}, images2{8}, images2{7});
Hcell{7} = H.tdata.T;
[im, H] = getH(points2{8,1}, points2{8,2}, images2{9}, images2{10});
Hcell{8} = H.tdata.T;
[im, H] = getH(points2{9,1}, points2{9,2}, images2{11}, images2{10});
Hcell{9} = H.tdata.T;
[im, H] = getH(points2{10,1}, points2{10,2}, images2{12}, images2{11});
Hcell{10} = H.tdata.T;
[im, H] = getH(points2{11,1}, points2{11,2}, images2{10}, images2{6});
Hcell{11} = H.tdata.T;
[im, H] = getH(points2{12,1}, points2{12,2}, images2{4}, images2{8});
Hcell{12} = H.tdata.T;
[im, H] = getH(points2{13,1}, points2{13,2}, images2{12}, images2{8});
Hcell{13} = H.tdata.T;
[im, H] = getH(points2{14,1}, points2{14,2}, images2{4}, images2{7});
Hcell{14} = H.tdata.T;
[im, H] = getH(points2{15,1}, points2{15,2}, images2{3}, images2{7});
Hcell{15} = H.tdata.T;
[im, H] = getH(points2{16,1}, points2{16,2}, images2{1}, images2{6});
Hcell{16} = H.tdata.T;
[im, H] = getH(points2{17,1}, points2{17,2}, images2{11}, images2{7});
Hcell{17} = H.tdata.T;
[im, H] = getH(points2{18,1}, points2{18,2}, images2{11}, images2{6});
Hcell{18} = H.tdata.T;
[im, H] = getH(points2{19,1}, points2{19,2}, images2{9}, images2{5});
Hcell{19} = H.tdata.T;

image = combineWilsonNorth(images2, Hcell);
figure(2);
imshow(image);
imwrite(image, 'wilson-north-mosaic.ppm');



