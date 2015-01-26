function [ X ] = pointsTo3D( P1, P2, ip1, ip2 )
[temp, n] = size(ip1);
X = zeros(4, n);
for i = 1: n
    A = [ip1(1,i) * P1(3,:) - P1(1,:);
        ip1(2,i) * P1(3,:) - P1(2,:);
        ip2(1,i) * P2(3,:) - P2(1,:);
        ip2(2,i) * P2(3,:) - P2(2,:)];

    [U, D ,V] = svd(A);
    newPoint = V(:,4);
    newPoint = newPoint/ newPoint(4,1);
    X(:,i) = newPoint;
end
end