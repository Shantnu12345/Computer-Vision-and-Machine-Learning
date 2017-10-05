function t_im = CS5320_background_sub_tracking(im)
% CS5320_background_sub_tracking - track by background difference
% On input:
%       im (struct array): image sequence (p images)
%       im(k).im (mxnxd array): k_th image
% On output:
%       t_im (mxnxp array): subtracted images (image from average)
% Call:
%       t_im = CS5320_background_sub_tracking(ims);
% Author:
%       Shantnu Kakkar
%       UU
%       Spring 2016
%
[nr,nc,nd] = size(im(1).im);
NumOfImages = numel(im);
t_im = zeros(nr,nc,nd);
sum_im = zeros(nr,nc,nd);
mean_im = zeros(nr,nc,nd);
for i = 1:NumOfImages
    sum_im = double(im(i).im) + sum_im;
end
mean_im = sum_im/NumOfImages;
for  p = 1:NumOfImages
    RedDifference = double(im(p).im(:,:,1)) - mean_im(:,:,1);
    GreenDifference = double(im(p).im(:,:,2)) - mean_im(:,:,2);
    BlueDifference = double(im(p).im(:,:,3)) - mean_im(:,:,3);
    for r = 1:nr
        for c = 1:nc
            t_im(r,c,p) = norm([RedDifference(r,c),GreenDifference(r,c),BlueDifference(r,c)]);
        end
    end
%     t_im(:,:,i) = norm 
end