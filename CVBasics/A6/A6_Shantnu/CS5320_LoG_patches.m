function patches = CS5320_LoG_patches(im,k,p)
% CS5320_LoG_patches - produce patches (see Alg. 5.3 text)
% On input:
%       im (mxn array): input image
%       k (float): scale parameter in Alg. 5.2
%       p (float): p parameter from LoG interest function
% On output:
%       patches (px4 array): patch parameters
%       col 1: row center of patch (called x_c in text)
%       col 2: col center of patch (called y_c in text)
%       col 3: patch radius (called r in text)
%       col 4: orientation of patch (called theta in text)
% Call:
%       p = CS5320_LoG_patches(im,2,2);
% Author:
%       Shantnu Kakkar
%       Spring 2016
%
patches = [];
[x,A_scale] = CS5320_LoG_interest(im,0.7);
[nr,nc] = size(im);
for r = 1:nr
    for c = 1:nc
        if x(r,c) ==1
            Xc = r;
            Yc = c;
            radius = A_scale(r,c);
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