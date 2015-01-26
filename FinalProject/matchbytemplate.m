function [m1,m2] = matchbytemplate(im1, im2, boxr, nonmaxrad)

smooth = 2;
thresh = 1000 ;  % Harris corner threshold
[cim, r1, c1] = harris(rgb2gray(im1), smooth, thresh, nonmaxrad);
[cim, r2, c2] = harris(rgb2gray(im2), smooth, thresh, nonmaxrad);

bestMatches1 = [];
bestMatches2 = [];
[ss ss2]= size(r1);
for index = 1:ss
    
temp = getTemplate(rgb2gray(im1), c1(index), r1(index), boxr);
tempd = im2double(temp);

[s s2]= size(r2);
maxc = 1;
maxn = 0;
for n = 1:s
    match = getTemplate(rgb2gray(im2), c2(n), r2(n), boxr);
    matchd = im2double(match);
    dotted = sum(sum((tempd - matchd).*(tempd - matchd)));
    summ = sum(sum(matchd.*matchd));
    sumt = sum(sum(tempd.*tempd));
    sq = dotted/sqrt(sumt*summ);
    if sq < maxc
        maxc = sq;
        maxn = n;
    end
end
maxc;
match = getTemplate(rgb2gray(im2), c2(maxn), r2(maxn), boxr);
if maxc < .009
    bestMatches1  = [bestMatches1 [c1(index); r1(index)]];
    bestMatches2  = [bestMatches2 [c2(maxn); r2(maxn)]];
end
end
m1 = bestMatches1;
m2 = bestMatches2;