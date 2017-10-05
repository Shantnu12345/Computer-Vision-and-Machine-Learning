function C = CS5320_normcorr_withoutMean(T,IM)
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
norm_T = norm(T(:)) ;
C = zeros(num_rows_IM , num_cols_IM);
for r = 1: num_rows_IM - num_rows_T+1
    for c = 1:num_cols_IM - num_cols_T+1
        W = IM(r:r+num_rows_T-1,c:c+num_cols_T-1);
        W = double(W);
        norm_W = norm( W(:) );
        if norm_W ~=0
            C( ( r+ceil(num_rows_T/2)), ( c + ceil(num_cols_T/2)) )...
                = dot(T(:), W(:) )/(norm_T*norm_W);
        end
     end
end
