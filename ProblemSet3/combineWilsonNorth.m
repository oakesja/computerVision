function [ image ] = combineWilsonNorth( images, Hcell )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
R = makeresampler({'linear','linear'},'bound');

% gets transformations for all the pictures

%T1 = maketform('projective', Hcell{1}*Hcell{4});
T1 = maketform('projective', Hcell{16});
T2 = maketform('projective', Hcell{4});
%T3 = maketform('projective', Hcell{2}*Hcell{4});
T3 = maketform('projective', Hcell{15}*Hcell{6});
%T4 = maketform('projective', Hcell{3}*Hcell{2}*Hcell{4});
%T4 = maketform('projective', Hcell{12}*Hcell{7}*Hcell{6});
T4 = maketform('projective', Hcell{14}*Hcell{6});
T5 = maketform('projective', Hcell{5});
T6 = maketform('projective', eye(3));
T7 = maketform('projective', Hcell{6});
T8 = maketform('projective', Hcell{7}*Hcell{6});
%T9 = maketform('projective', Hcell{8}*Hcell{11});
T9 = maketform('projective', Hcell{8}*inv(Hcell{9})*Hcell{17}*Hcell{6});
%T10 = maketform('projective', Hcell{11});
T10 = maketform('projective', inv(Hcell{9})*Hcell{17}*Hcell{6});
%T11 = maketform('projective', Hcell{9}*Hcell{11});
T11 = maketform('projective', Hcell{17}*Hcell{6});
%T11 = maketform('projective', Hcell{18});
%T12 = maketform('projective', Hcell{10}*Hcell{9}*Hcell{11});
T12 = maketform('projective', Hcell{13}*Hcell{7}*Hcell{6});

% gets the x's and y's to find the max and mins

[im, x1, y1] = imtransform(images{1}, T1);
[im, x2, y2] = imtransform(images{2}, T2);
[im, x3, y3] = imtransform(images{3}, T3);
[im, x4, y4] = imtransform(images{4}, T4);
[im, x5, y5] = imtransform(images{5}, T4);
[im, x6, y6] = imtransform(images{6}, T6);
[im, x7, y7] = imtransform(images{7}, T7);
[im, x8, y8] = imtransform(images{8}, T8);
[im, x9, y9] = imtransform(images{9}, T9);
[im, x10, y10] = imtransform(images{10}, T10);
[im, x11, y11] = imtransform(images{11}, T11);
[im, x12, y12] = imtransform(images{12}, T12);

x = [ x1; x2; x3; x4; x5; x6; x7; x8; x9; x10; x11; x12];
y = [ y1; y2; y3; y4; y5; y6; y7; y8; y9; y10; y11; y12];

% Find the max of the maxs and the min of the mins
xdata = [min(x(:,1)) max(x(:,2))];
ydata = [min(y(:,1)) max(y(:,2))];

% gets the images with enough room for all 

i1t = imtransform(images{1}, T1, R, 'XData', xdata, 'YData', ydata);
i2t = imtransform(images{2}, T2, R, 'XData', xdata, 'YData', ydata);
i3t = imtransform(images{3}, T3, R, 'XData', xdata, 'YData', ydata);
i4t = imtransform(images{4}, T4, R, 'XData', xdata, 'YData', ydata);
i5t = imtransform(images{5}, T5, R, 'XData', xdata, 'YData', ydata);
i6t = imtransform(images{6}, T6, R, 'XData', xdata, 'YData', ydata);
i7t = imtransform(images{7}, T7, R, 'XData', xdata, 'YData', ydata);
i8t = imtransform(images{8}, T8, R, 'XData', xdata, 'YData', ydata);
i9t = imtransform(images{9}, T9, R, 'XData', xdata, 'YData', ydata);
i10t = imtransform(images{10}, T10, R, 'XData', xdata, 'YData', ydata);
i11t = imtransform(images{11}, T11, R, 'XData', xdata, 'YData', ydata);
i12t = imtransform(images{12}, T12, R, 'XData', xdata, 'YData', ydata);

% gets the final image
image = combineImages({i1t, i2t, i3t, i4t, i5t, i6t, i7t, i8t, i9t, i10t, i11t, i12t});
end
