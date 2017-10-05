function F = CS5320_myFilter(im)
% CS5320_myFilter - computes the variance 
% of an 11x11 window at each pixel.
% On input
%       im (mxn array): input image
% On output:
%       F(mxn array): variance of window at each pixel
% Call:
%       R1 = CS5320_myFilter(im_tex);
% Author:
%       Shantnu Kakkar
%       UU
%       Spring 2016
%
F = [];