function [ H ] = rectify_affine_square( p )
%RECTIFY_AFFINE_SQUARE Summary of this function goes here
%   Detailed explanation goes here

p1 = [p(1, 1) p(2, 1) 1];
p2 = [p(1, 2) p(2, 2) 1];
p3 = [p(1, 3) p(2, 3) 1];
p4 = [p(1, 4) p(2, 4) 1];

l1 = cross(p1, p2);
l2 = cross(p3, p4);
v1 = cross(l1, l2);
v1 = v1/ v1(1,3);
display(v1);

l3 = cross(p2, p3);
l4 = cross(p1, p4);
v2 = cross(l3, l4);
v2 = v2/ v2(1,3);
display(v2);

li = cross(v1, v2);

H = [1 0 0; 0 1 0; li(1, 1)/li(1,3) li(1, 2)/li(1,3) 1];
end

