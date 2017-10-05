function [row,col] = CS5320_detect_red_ball(im,model)
% CS5320_detect_red_ball - find red ball in image
% On input:
%       im (mxnx3 array): rgb image
%       model (1x3 vector): rgb model
% On output:
%       row (int): row of red ball centroid
%       col (int): col of red ball centroid
% Call:
%       [rc,cc] = CS5320_detect_red_ball(Falling_ball(1).cdata,[230,30,30]);
% Author:
%       Shantnu Kakkar
%       UU
%       Spring 2016
%
[nr,nc,nd] = size(im);
temp_im = zeros(nr,nc);
for r = 1:nr
    for c = 1:nc
       if im(r,c,1) > model(1) & im(r,c,2) < model(2) & im(r,c,3) < model(3)
           temp_im(r,c) = 1;
       end
    end
end
[row,col] = find(temp_im==1);
row = floor(mean(row));
col = floor(mean(col));
