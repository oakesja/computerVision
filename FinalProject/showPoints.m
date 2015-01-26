function showPoints(i, ip);
%
% Function: displays image points ip overlaid on image i.
%
% Usage:  showPoints(i, ip)
% 
% Arguments:
%            i - Image
%            ip - Array of points in perspective image
%			[x1 x2 ... xn
%                        y1 y2 ... yn]
%

% make sure the inputs are reasonable
[iprows, ipnpts] = size(ip);

if iprows ~= 2
  error('data points must be in the form of an 2xn array');
end

figure(1);
clf;
imshow(i);
hold on;
zoom off;

h = plot(ip(1,:), ip(2,:), 'ro');
set(h, 'MarkerSize', 5);
set(h, 'Color', [0 1 1]);
H = text(ip(1,:)+4, ip(2,:)+4, int2str([1:size(ip, 2)]'));
set(H, 'Color', [0 1 1]);
set(H, 'FontSize', 10);