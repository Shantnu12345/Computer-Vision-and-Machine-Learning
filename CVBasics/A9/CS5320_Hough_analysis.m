function [H,pts] = CS5320_Hough_analysis(imo)
% CS5320_Hough - Hough transform of image
% On input:
%       imo (mxn array): gray-level image
% On output:
%       H (rxt array): Hough accumulator array (r rho values; t theta
%           values)
%             r = [indexes to cover from [-ceil(image diagonal to
%                ceil(image diagonal)]; t = [1:180]
%       pts (rxt struct): contains points which contributed to line
%            pts(i,j).pts (kx2 array): k pixels (rows and cols)
% Call:
%       [H4,H4pts] = CS5320_Hough(double(hall4g));
% Author:
%       Shantnu Kakkar
%       UU
%       Spring 2016
%
im = edge(imo,'canny');
[nr,nc] = size(im);
rSize = ceil(sqrt(nr^2 + nc^2));
rArray = -rSize:rSize;
rSize = length(rArray);
mid = ceil((rSize-1)/2);

pts(rSize,180).pts = [];
H = zeros(rSize,180);

for r = 1:nr
    for c = 1:nc
        if im(r,c)==1
            x = c;
            y = nr-r+1;
            for t = 1:180
                rho = -x*cosd(t) - y*sind(t);
                rhoIndex = mid + ceil(rho) + 1;
                H(rhoIndex,t) = H(rhoIndex,t)+1;  
                pts(rhoIndex,t).pts = [pts(rhoIndex,t).pts ; [r,c]]; 
            end
        end
    end
end