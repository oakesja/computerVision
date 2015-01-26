i1 = imread('test2_1.jpg');
i2 = imread('test2_2.jpg');
i3 = imread('test2_3.jpg');
i4 = imread('test2_4.jpg');
i5 = imread('test2_5.jpg');
i6 = imread('test2_6.jpg');
i7 = imread('test2_7.jpg');
i8 = imread('test2_8.jpg');
i9 = imread('test2_9.jpg');
i10 = imread('test2_10.jpg');
i11= imread('test2_11.jpg');
i12 = imread('test2_12.jpg');
i13 = imread('test2_13.jpg');
i14 = imread('test2_14.jpg');


images = {i2, i3, i4, i5, i6, i7, i8, i9, i10, i11, i12, i13};

im = mosaic(images);
figure(1);
imshow(im);
