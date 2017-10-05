function C = CS5320_normcorr_withMean(T,IM)
% CS5320_normcorr - normalized correlation
% On input:
%       T (pxq array): template kernel
%       im (nxm array): image
% On output:
%       C (nxm array): correlation coefficients in [-1,1]
% Call:
%       C = CS5320_normcorr(T,s1g);
% Author:
%       Shantnu Kakkar
%       UU
%       Spring 2016
%

T = double(T);
[num_rows_T , num_cols_T] = size(T);
IM = double(IM);
[num_rows_IM , num_cols_IM] = size(IM);
meanT = mean(T(:));
meanT = ones(size(T(:))) * meanT;
norm_T = norm( (T(:) - meanT) );
C = zeros(num_rows_IM , num_cols_IM);
for r = 1: num_rows_IM - num_rows_T 
    for c = 1:num_cols_IM - num_cols_T 
        W = IM(r:r+num_rows_T-1,c:c+num_cols_T-1);
        W = double(W);
        meanW = mean(W(:));
        meanW = ones(size(W(:))) * meanW;
        norm_W = norm( (W(:) - meanW) );
        if norm_W ~=0
            C( (-1+ r+floor(num_rows_T/2)), (-1+ c + floor(num_cols_T/2)) )...
                = dot(T(:)-meanT , W(:) - meanW)/(norm_T*norm_W);
        end
     end
end
