function lines = CS5320_Hough_draw_pts(im,H,pts,n,dr)
% CS5320_Hough_draw_pts - draws points which contributed to line
% On input:
%       im (mxn array): original image (or edge image)
%       H (rxt array): Hough accumulator array (see CS5320_Hough)
%       pts (rxt struct): record of points in Hough accumulator
%       n (int): number of lines to show (sorted by most points)
%       dr (Boolean): 1 means draw, 0 don’t
% On output:
%       lines (mxn array): mask of n lines
% Call:
%       linesp = CS5320_Hough_draw_pts(hall4g,H4,H4pts,10,1);
% Author:
%       Shantnu Kakkar
%       UU
%       Spring 2016
%

[H4Temp,I] = sort(H(:), 'descend');
ptsTemp = pts(I);

[nr,nc] = size(im);
lines = zeros(nr,nc);

for i = 1:n
    A = ptsTemp(i).pts;
    [nrA,ncA] = size(A);
    for j = 1:nrA
        r = A(j,1);
        c = A(j,2);
        lines(r,c) = 1;
    end
end
if dr == 1
    combo(mat2gray(im),lines);
end