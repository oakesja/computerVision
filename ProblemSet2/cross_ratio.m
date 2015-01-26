function [ V ] = cross_ratio( p )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
cr = 1/2;

% find distances between points
d1 = pdist([p(1,1), p(1,2); p(2, 1), p(2, 2)], 'euclidean');
d2 = pdist([p(1,1), p(1,2); p(3, 1), p(3, 2)], 'euclidean');

% find distance to vanishing point
syms d;
x = vpa(solve((d1 * (d - d2)/(d2 * (d - d1))) == cr));

% find a distance unit vector from p1 to p3
p1 = [p(1,1) p(1, 2)];
p3 = [p(3,1) p(3,2)];
nd = (p3 - p1)./norm(p3 - p1);

% add on p1 since we chose it as the new origin here
V = vpa(x*nd) + p1;
end

