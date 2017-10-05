function [pts_im_part2, pts_world_part2] = CS5320_part2()
% CS5320_part2: Returns the image points by clicking them 
% in the image, and corresponding world points. 
% Just click six times in the image in the sequence given in A3 
% and you would get back the coordinates. Currently I have hardcoded 
%to get 6 points. Change parameter value in ginput to the number of points
% that you want to want to extract from image
% Output:
%  pts_im _part2(3x6 array): image points (homogeneous coords)
%  pts_world_part2 (4x6 array): world coordinates (homogeneous coords)
%Call:
% [pts_im_part2, pts_world_part2] = CS5320_part2()

pts_world_part2 = [0,0,7,7,0,0;...
    8,0,0,0,0,8;...
    0,0,0,12.5,12.5,12.5;...
    1,1,1,1,1,1];
    
pts_im_part2 = [];
image = imread('cal_im.jpg');
newimage = rgb2gray(image);
imshow(newimage<40)
[imX,imY]=ginput(6);
pts_im_part2(1,1:6) = imX;  
pts_im_part2(2,1:6) = imY;
pts_im_part2(3,1:6) = ones(1,6);