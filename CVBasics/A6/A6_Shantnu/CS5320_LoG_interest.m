function [interest_pts,scale] = CS5320_LoG_interest(im,p)
% CS5320_LoG_interest - interest points from LoG scale-position maxima
% On input:
%       im (mxn array) gray level input image
%       p (float): percentage of max response to return
% On output:
%       interest_pts (mxn array): interest point response
%       scale (mxn array): max sigma scale at location
% Call:
%       [A_IP,A_scale] = CS5320_LoG_interest(A,0.9);
% Author:
%       T. Hendersonma
%       UU
%       Spring 2016
%
[nr,nc] = size(im);
sigma = 0.3:0.01:6;
num_sigmas = length(sigma);

scale = zeros(nr,nc);
C = zeros(nr,nc,num_sigmas);
interest_pts = zeros(nr,nc);
maxResponses = zeros(nr,nc);
temp1_scale = zeros(nr,nc);
temp2_scale = zeros(nr,nc);

for s_index  = 1:num_sigmas
    T = fspecial('log', 21, sigma(s_index));
    C(:,:,s_index) = abs(filter2(T,im));
end

for r = 1:nr
    for c = 1:nc
        temp1 = C(r,c,:);
        temp1 = temp1(:);
        [temp2(r,c),idx] = max(temp1);
        if idx ~=1 && idx ~= num_sigmas
            temp1_scale(r,c) = sigma(idx);
            maxResponses(r,c) = temp2(r,c);
        end
    end
end

maxvalues = p*max(max(maxResponses));
for r = 1:nr
    for c = 1:nc
        if maxResponses(r,c)<maxvalues
            maxResponses(r,c) = 0;
        end
    end
end 

interest_pts = imregionalmax(maxResponses);
scale = interest_pts.* temp1_scale;



% for all maxResponse(i,j)>maxvalues
%     save scale(i,j) = tempscle(i,j)
% scale
% logicalmaxResponses = maxResponses >...
%     p*max(max(maxResponses));
%      
% 
