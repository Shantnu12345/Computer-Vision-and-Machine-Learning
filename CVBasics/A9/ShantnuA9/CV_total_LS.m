function [p,s] = CV_total_LS(x,y)
%
%CV_total_LS - total least squares method to fit best line to points
%         (Forsyth and Ponce page 335
%On input:
%       x (nx1 vector): x coordinates of points
%       y (nx1 vector): y coordinates of points
%On output:
%       p (1x3 vector): coefficients of best fit line ax + by + c = 0
%       s (float): error measure (sum of squares of distances
%         of points to line)
%Call:
%       [p1,s1] = CV_total_LS([1,2,3]',[1,2,3]');
%Author:
%       Shantnu Kakkar
%       UU
%       Fall 2016
%

p = [];
s = 0;
xMean = mean(x);
xSquareMean = mean(x.^2);
yMean = mean(y);
ySquareMean = mean(y.^2);
xyMean = mean(x.*y);

A = [xSquareMean - (xMean)^2, xyMean - xMean*yMean;
     xyMean - xMean*yMean, ySquareMean - (yMean)^2];
 
 [V,D] = eigs(A);
 [Vsorted,indexes] = sort(diag(D));
 index = indexes(1);
 sol = V(:,index);
 
 p(1) = sol(1);
 p(2) = sol(2);
 p(3) = -sol(1)*xMean - sol(2)*yMean;
 
 for i = 1:length(x)
    dist = (abs( p(1)*x(i) + p(2)*y(i) + p(3)))/(sqrt( p(1)^2 + p(2)^2));
    s = s + dist;
 end
 
 