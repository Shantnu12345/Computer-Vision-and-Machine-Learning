function im_lm = CS5320_local_max(im,k)
% CS5320_local_max - local maxima of image
% On input:
%     im (mxn array): input image
% On output:
%     im_lm (mxn array): non-zero values at local maxima
% Call:
%     A_lm = CS5320_local_max(A);
% Author:
%     T. Henderson
%     UU
%     Spring 2016
%

[num_rows,num_cols] = size(im);
im_lm = im;

for r = 1:num_rows
    r_min = max(1,r-k);
    r_max = min(num_rows,r+k);
    for c = 1:num_cols
        c_min = max(1,c-k);
        c_max = min(num_cols,c+k);
        W = im(r_min:r_max,c_min:c_max);
        if max(W(:))>im(r,c)
            im_lm(r,c) = 0;
        end
    end
end
tch = 0;