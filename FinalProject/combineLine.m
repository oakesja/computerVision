function [ image ] = combineLine( images, Hcell )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

R = makeresampler({'linear','linear'},'bound');

[n, temp] = size(Hcell);
Tcell = cell(n+1,1);
xData = zeros(n+1, 2);
yData = zeros(n+1, 2);
reference = ceil(n/2);
ims = cell(n+1,1);

for i = 1:reference;
    H = eye(3);
    for j = i:reference-1;
        H = H * Hcell{j};
    end
    Tcell{i} =  maketform('projective', H);
end
Tcell{reference} = maketform('projective', eye(3));
for i = reference+1:n+1;
    H = eye(3);
    for j = reference:i-1;
        H = inv(Hcell{j}) * H;
    end
    Tcell{i} =  maketform('projective', H);
end

for i = 1:n+1
    [im x y] = imtransform(images{i}, Tcell{i});
    xData(i,:) = x;
    yData(i,:) = y;
end

xstuff = [min(xData(:,1)) max(xData(:,2))];
ystuff = [min(yData(:,1)) max(yData(:,2))];

for i = 1:n+1
    ims{i} = imtransform(images{i}, Tcell{i}, R, 'XData', xstuff, 'YData', ystuff);
end
image = combineImages(ims);

end