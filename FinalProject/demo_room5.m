i1 = imread('test1_1.jpg');
i2 = imread('test1_2.jpg');
i3 = imread('test1_3.jpg');
i4 = imread('test1_4.jpg');
i5 = imread('test1_5.jpg');

images = {i1, i2, i3, i4, i5};

im = mosaic(images);
figure(1);
imshow(im);
