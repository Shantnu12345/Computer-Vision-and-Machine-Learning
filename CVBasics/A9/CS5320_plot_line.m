function CS5320_plot_line(p,x1,x2,y1,y2)
% CS5320_plot_line - plots line given parameters
% On input:
%       p (1x3 vector): line parameters (p(1)x + p(2)y + p(3) = 0)
%       x1 (float): first x value
%       x2 (float): second x value
%           if x1 ~= x2, then plot line from x1 to x2 (calculate y1 and
%            y2)
%       y1 (float): first y value
%       y2 (float): second y value
%           if x1==x2, then plot line from y1 to y2 (calculate x1 and x2)
% On output:
%       plot line
% Call:
%       Cs5320_plot_line(p,0,7,0,0);
% Author:
%       Shantnu Kakkar
%       UU
%       Spring 2016
%

if x1~=x2
    xVector = x1:0.1:x2;
    yVector = (-p(1)*xVector - p(3))/p(2);
    plot(xVector,yVector);
else
   yVector = y1:0.1:y2;
   xVector = (-p(2)*yVector - p(3))/p(1);
   plot(xVector,yVector);
end