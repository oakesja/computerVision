function [ pts1 pts2 ] = getRidofDuplicates( x1, x2 )
[temp n] = size(x1);
duplicates = zeros(1,1);
found = 0;
index = 1;
for i = 1:n
    point = x2(:,i);
    for j = i+1:n
        if and(point(1,1) == x2(1,j), point(2,1) == x2(2,j))
            duplicates(1,index) = j;
            index = index + 1;
            found = 1;
        end
    end
    if found
        duplicates(1,index) = i;
        index = index + 1;
        found = 0;
    end
end
if duplicates(1,1) ~= 0
    pts1 = removerows(x1', duplicates');
    pts1 = pts1';
    pts2 = removerows(x2', duplicates');
    pts2 = pts2';
    display('Removed Duplicates');
else 
    pts1 = x1;
    pts2 = x2;
end

end

