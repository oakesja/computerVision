function [ pts1, pts2 ] = getCorrespondences( im1, im2 )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
points = 0;
nonmaxrad = 14;
noPoints = 0;
while points < 12
    [x1, x2] = matchbytemplatelight(im1, im2, 10, nonmaxrad);
    [x1, x2] = getRidofDuplicates(x1, x2);
    [temp points] = size(x1);
    if points == 0 
        noPoints = 1;
        break;
    elseif nonmaxrad > 11 
        nonmaxrad = nonmaxrad - 3;   
    elseif nonmaxrad == 9
            break;
    else
        nonmaxrad = nonmaxrad - 2;
    end
end
%{
[t, n] = size(x1);
labels = cellstr( num2str([1:n]') );
figure(1);
imshow(im1); hold on;
plot(x1(1,:),x1(2,:),'r*');
text(x1(1,:), x1(2,:), labels, 'VerticalAlignment','bottom', ...
                             'HorizontalAlignment','right')
hold off;

figure(2);
imshow(im2); hold on;
plot(x2(1,:),x2(2,:),'r*');
text(x2(1,:), x2(2,:), labels, 'VerticalAlignment','bottom', ...
                             'HorizontalAlignment','right')
hold off;
%}
% ransac params
feedback = 1;
t = .0001;
s = 8;
fittingfn = @fundmatrix;
distfn    = @funddist;
degenfn   = @isdegenerate;

[rows,npts] = size(x1);
x1t = [x1; ones(1,npts)];
x2t = [x2; ones(1,npts)];
[x1t, T1] = normalise2dpts(x1t);
[x2t, T2] = normalise2dpts(x2t);

[F, inliers] = ransac([x1t; x2t], fittingfn, distfn, degenfn, s, t, feedback);

pts1 = ones(2, length(inliers));
pts2 = ones(2, length(inliers));

index = 1;
for i=1:length(inliers)
    pts1(:, index) = x1(1:2, inliers(1,i));
    pts2(:, index) = x2(1:2, inliers(1,i));
    index = index + 1;
end

fprintf('Number of inliers was %d (%d%%) \n', ...
	length(inliers),round(100*length(inliers)/points));
fprintf('Number of putative matches was %d \n', points);


[pts1, pts2] = removeByDistance(pts1, pts2);

[t, n] = size(pts1);
fprintf('Total matches %d \n', n);
%{
labels = cellstr( num2str([1:n]') );
figure(3);
imshow(im1); hold on;
plot(pts1(1,:),pts1(2,:),'r*');
text(pts1(1,:), pts1(2,:), labels, 'VerticalAlignment','bottom', ...
                             'HorizontalAlignment','right')
hold off;

figure(4);
imshow(im2); hold on;
plot(pts2(1,:),pts2(2,:),'r*');
text(pts2(1,:), pts2(2,:), labels, 'VerticalAlignment','bottom', ...
                             'HorizontalAlignment','right')
hold off;
%}
end

function [bestInliers, bestF] = funddist(F, x, t);
    
    x1 = x(1:3,:);    % Extract x1 and x2 from x
    x2 = x(4:6,:);
    
    
    if iscell(F)  % We have several solutions each of which must be tested
		  
	nF = length(F);   % Number of solutions to test
	bestF = F{1};     % Initial allocation of best solution
	ninliers = 0;     % Number of inliers
	
	for k = 1:nF
	    x2tFx1 = zeros(1,length(x1));
	    for n = 1:length(x1)
		x2tFx1(n) = x2(:,n)'*F{k}*x1(:,n);
	    end
	    
	    Fx1 = F{k}*x1;
	    Ftx2 = F{k}'*x2;     

	    % Evaluate distances
	    d =  x2tFx1.^2 ./ ...
		 (Fx1(1,:).^2 + Fx1(2,:).^2 + Ftx2(1,:).^2 + Ftx2(2,:).^2);
	    
	    inliers = find(abs(d) < t);     % Indices of inlying points
	    
	    if length(inliers) > ninliers   % Record best solution
		ninliers = length(inliers);
		bestF = F{k};
		bestInliers = inliers;
	    end
	end
    
    else     % We just have one solution
	x2tFx1 = zeros(1,length(x1));
	for n = 1:length(x1)
	    x2tFx1(n) = x2(:,n)'*F*x1(:,n);
	end
	
	Fx1 = F*x1;
	Ftx2 = F'*x2;     
	
	% Evaluate distances
	d =  x2tFx1.^2 ./ ...
	     (Fx1(1,:).^2 + Fx1(2,:).^2 + Ftx2(1,:).^2 + Ftx2(2,:).^2);
	
	bestInliers = find(abs(d) < t);     % Indices of inlying points
	bestF = F;                          % Copy F directly to bestF
	
    end
end


%----------------------------------------------------------------------
% (Degenerate!) function to determine if a set of matched points will result
% in a degeneracy in the calculation of a fundamental matrix as needed by
% RANSAC.  This function assumes this cannot happen...
     
function r = isdegenerate(x)
    r = 0;    
end

