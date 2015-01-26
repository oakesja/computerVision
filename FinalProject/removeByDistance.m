function [ pts1, pts2 ] = removeByDistance( x1, x2 )

[temp n] = size(x1);
remove = zeros(1,1);
distances = zeros(n,1);
for i = 1:n
    distances(i, 1) = sqrt((x1(1,i) - x2(1,i))^2 + (x1(2,i) - x2(2,i))^2);
end
m = median(distances);
index = 1;
for i = 1:n
    if abs(distances(i, 1) - m) > m * .1
        remove(1,index) = i;
        index = index + 1;
    end
end

if remove(1,1) ~= 0
    pts1 = removerows(x1', remove');
    pts1 = pts1';
    pts2 = removerows(x2', remove');
    pts2 = pts2';
    fprintf('Removed %d points too far away\n', length(remove));
else 
    pts1 = x1;
    pts2 = x2;
end

end

