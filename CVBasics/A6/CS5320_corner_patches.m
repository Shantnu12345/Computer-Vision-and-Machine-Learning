function patches = CS5320_corner_patches(im,k,w)
% CS5320_corner_patches - produce patches (see Alg. 5.2 text)
% On input:
%       im (mxn array): input image
%       k (float): scale parameter in Alg. 5.2
%       w (int): window size parameter for Harris function (called k)
% On output:
%       patches (px4 array): patch parameters
%       col 1: row center of patch (called x_c in text)
%       col 2: col center of patch (called y_c in text)
%       col 3: patch radius (called r in text)
%       col 4: orientation of patch (called theta in text)
% Call:
%       p = CS5320_corner_patches(im,4,2);
% Author:
% Shantnu Kakkar
% UU
% Spring 2016
%
sigma = 0.3:0.01:6;
num_sigmas = length(sigma);
R = CS5320_Harris(im,w);
RregionalMax = imregionalmax(R);
R = RregionalMax.*R;
[nr,nc] = size(im);
threshold = max(max(R/2));
x = R > threshold;
patches = [];
for s_index  = 1:num_sigmas
    T = fspecial('log', 7, sigma(s_index));
    C(:,:,s_index) = abs(filter2(T,im));
end

for r = 1:nr
    for c = 1:nc
        if x(r,c) ==1
            Xc = r;
            Yc = c;
            temp1 = C(r,c,:);
            temp1 = temp1(:);
            [temp2(r,c),idx] = max(temp1);
            radius = sigma(idx);
            H = CS5320_gradient_histogram(im,Xc,Yc,radius*k,0,0);
            [thetaP,index] = max(H);
            allThetaP = find(H==thetaP);
            for i = 1:length(allThetaP)
                tp(1) = Xc;
                tp(2) = Yc;
                tp(3) = r;
                tp(4) = 20 * allThetaP(i);
                patches = [patches;tp];
            end
         end
    end
end
x = 5;
