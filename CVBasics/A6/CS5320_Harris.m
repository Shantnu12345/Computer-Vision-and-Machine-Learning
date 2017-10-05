function R = CS5320_Harris(im,k)
% CS5320_Harris - corner detector
% On input:
%       im (mxn array): input gray level image
%       k (int): determines window side as 2*k+1
% On output:
%       R (mxn array): corner response
%       <=0: homogeneous
%       >0 and small: edge
%       large: corner
% Call:
%       R = Cs5320_Harris(im,1);
% Author:
%       T. Henderson
%       UU
%       Spring 2016
%
R = zeros(size(im,1),size(im,2));
[dx,dy] = gradient(double(im));
for r = 1+k:size(im,1)-k
    for c = 1+k:size(im,2)-k
        a = dx(r-k:r+k,c-k:c+k);
        b = dy(r-k:r+k,c-k:c+k);
        a = a(:);
        b = b(:);
        pts = [a,b];
        M = pts'*pts;
        R(r,c) = det(M) - 0.05*((trace(M)/2)^2);
    end
end
