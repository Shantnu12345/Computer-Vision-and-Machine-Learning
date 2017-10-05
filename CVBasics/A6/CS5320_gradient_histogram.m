function H = CS5320_gradient_histogram(im,r,c,radius,w,thresh)
% CS5320_gradient_histogram - get histogram of gradient orientations
% On input:
%       im (mxn array): image
%       r (int): row of center of patch
%       c (int): col of center of patch
%       radius (float): radius of pixels to consider
%       w (Boolean): use magnitude of gradient as weight in histogram
%       thresh (float): minimum gradient magnitude to consider
% On output:
%        H (9x1 vector): orientation counts in 20-degree bins
% Call:
%       H = CS5320_gradient_histogram(A,8,8,3,0,0.1);
% Author:
%       T. Henderson
%       UU
%       Spring 2016
%
H = [0;0;0;0;0;0;0;0;0];
if((r - ceil(radius) <= 0) || (r + ceil(radius) > size(im,1)) || (c - ceil(radius) <= 0) || (c + ceil(radius )> size(im,2)))
    return;
else
    patch = im(r-ceil(radius):r+ceil(radius),c-ceil(radius):c+ceil(radius));
end
[dx,dy] = gradient(double(patch));
for r = 1:size(patch,1)
    for c = 1:size(patch,2)
        orientation = 0;
        magnitude = sqrt( dx(r,c)^2 + dy(r,c)^2);
        if magnitude  > thresh
            orientation = (atan2d(dy(r,c),dx(r,c)));
            if orientation <0
                orientation = orientation + 180;
            end
        end
        
        if orientation == 0
                 bin = 1;
        else 
            bin = ceil(orientation/20);
        end
        
        if bin >= 0
            if w==0
                H(bin) = H(bin) + 1;
            else
                H(bin) = H(bin) + magnitude;
            end
        end
    end
end




