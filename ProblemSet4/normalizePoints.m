function [ N ] = normalizePoints( points )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
m = mean(points');
T = [1 0 -m(1,1);
    0 1 -m(1,2);
    0 0 1];
v = var(points', 1);
scale = sqrt(v(1,1) + v(1,2));
S = [1/scale* sqrt(2) 0 0;
    0 1/scale * sqrt(2) 0;
    0 0 1];
N = S*T;
%display(N);
%newPoints = N * points;
%display(newPoints);
%display(mean(newPoints'));
%display(var(newPoints', 1));
end

