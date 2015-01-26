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

images = {i1, i2, i3, i4, i5, i6, i7, i8, i9, i10, i11, i12, i13};

im = mosaic(images);
figure(1);
imshow(im);
