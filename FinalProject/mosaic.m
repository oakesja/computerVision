function [ im ] = mosaic( images )

n = length(images) - 1;

% get homographies to go between each pair
Hcell = cell(n,1);
for i = 1:n   
    [pts1, pts2] = getCorrespondences( images{i}, images{i+1} );
    [im, H] = getH(pts1', pts2', images{i}, images{i+1});
    Hcell{i} = H.tdata.T;
    %figure(i);
    %imshow(im);
end
% comines all the eimages
im = combineLine(images, Hcell);




