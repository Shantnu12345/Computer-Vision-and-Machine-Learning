function segments = CS5320_line_segs(ime,Hpts,min_len)
% CS5320_line_segs - extract line segments from Hough info
% On input:
%       ime (mxn array): edge image (e.g., output of edge)
%       Hpts (txr array): Hough points array (see Cs5320_Hough)
%       min_len (int): minimum segment length
% On output:
%       segments (struct vector): segment info
%       (s).pts (kx2 array): row,col points in segment
%       (s).rho (int): rho parameter of line
%       (s).theta (float): theta parameter of line
%       (s).endpt1 (1x2 vector): one endpt of segment
%       (s).endpt2 (1x2 vector): other endpt of segment
% Call:
%       As = CS5320_line_segs(A,HApts,20);
% Author:
%       Shantnu Kakkar
%       UU
%       Spring 2016
%
[rSize,t] = size(Hpts);
mid = ceil((rSize-1)/2);
segments = [];
index = 0;
for rhoIndex = 1:rSize
    for thetaIndex = 1:t
        k = size(Hpts(rhoIndex,thetaIndex).pts,1);
        if k>min_len 
            index = index + 1;
            segments(index).rho = rhoIndex-mid-1;
            segments(index).theta = thetaIndex;
            
            distArray = [];
            for r = 1:k
               for c = 1:k
                   dist = norm(Hpts(rhoIndex,thetaIndex).pts(r,:) -...
                       Hpts(rhoIndex,thetaIndex).pts(c,:));
                   distArray(r,c) = dist;
               end
            end
            
            [M,I] = max(distArray(:));
            [I_row, I_col] = ind2sub(size(distArray),I);
            
            segments(index).endpt1 = Hpts(rhoIndex,thetaIndex).pts(I_row,:);
            segments(index).endpt2 = Hpts(rhoIndex,thetaIndex).pts(I_col,:);
            [rows,cols] = CS5320_line_between(segments(index).endpt1,...
                segments(index).endpt2);
            segments(index).pts =  [rows',cols'];
           
        end
    end
end