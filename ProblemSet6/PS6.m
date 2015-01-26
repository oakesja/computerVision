load('segments');
im = imread('myers1.ppm');
im = im(:,:,1);
figure(1); clf; imshow(im); hold on; zoom off;
drawseg(seg1);
figure(2); clf; imshow(im); hold on; zoom off;
drawseg(seg2);
figure(3); clf; imshow(im); hold on; zoom off;
drawseg(seg3);

A1 = [ cross([seg1(1,[1,2]) 1],  [seg1(1,[3,4])'; 1]);
       cross([seg1(2,[1,2]) 1],  [seg1(2,[3,4])'; 1]);
       cross([seg1(3,[1,2]) 1],  [seg1(3,[3,4])'; 1])];
A2 = [ cross([seg2(1,[1,2]) 1],  [seg2(1,[3,4])'; 1]);
       cross([seg2(2,[1,2]) 1],  [seg2(2,[3,4])'; 1]);
       cross([seg2(3,[1,2]) 1],  [seg2(3,[3,4])'; 1])
% this line was missing
       cross([seg2(4,[1,2]) 1],  [seg2(4,[3,4])'; 1])];
A3 = [ cross([seg3(1,[1,2]) 1],  [seg3(1,[3,4])'; 1]);
       cross([seg3(2,[1,2]) 1],  [seg3(2,[3,4])'; 1]);
       cross([seg3(3,[1,2]) 1],  [seg3(3,[3,4])'; 1])];

[u d v] = svd(A1);
vp1 = v(:,3);
vp1 = vp1/vp1(3)

[u d v] = svd(A2);
vp2 = v(:,3);
vp2 = vp2/vp2(3)


[u d v] = svd(A3);
vp3 = v(:,3);
vp3 = vp3/vp3(3)


A4 = [vp1(1)*vp2(1)+vp1(2)*vp2(2) vp1(1)*vp2(3)+vp1(3)*vp2(1) vp1(2)*vp2(3)+vp1(3)*vp2(2) vp1(3)*vp2(3);
    vp1(1)*vp3(1)+vp1(2)*vp3(2) vp1(1)*vp3(3)+vp1(3)*vp3(1) vp1(2)*vp3(3)+vp1(3)*vp3(2) vp1(3)*vp3(3);
    vp3(1)*vp2(1)+vp3(2)*vp2(2) vp3(1)*vp2(3)+vp3(3)*vp2(1) vp3(2)*vp2(3)+vp3(3)*vp2(2) vp3(3)*vp2(3)];

[u d v] = svd(A4);
ws = v(:,4);
w = [ws(1) 0 ws(2);
    0 ws(1) ws(3);
    ws(2) ws(3) ws(4)]
k = inv(chol(w))

save FoundW w
save FoundK k
    