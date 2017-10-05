
hall4 = imread('hall4.jpg');
hall4g = rgb2gray(hall4);
[H4,H4pts] = CS5320_Hough(double(hall4g));

[M,I] = max(H4(:));
[I_row, I_col] = ind2sub(size(H4),I);

xpoints = H4pts(I_row,I_col).pts(:,1);
ypoints = H4pts(I_row,I_col).pts(:,2);
[p,s] = CV_total_LS(xpoints,ypoints)
p(1) = p(1) + randn(1);
p(2) = p(2) + randn(1);
p(3) = p(3) + randn(1);




% 
% 
% 
% im = zeros(50,50);
% for i = 1:50
%     im(i,i) = 1;
% end
% imshow(im);
% [H4,H4pts] = CS5320_Hough(double(im));
% 
% figure; imshow(im)
%  H4 = CS5320_local_max(H4,8);
% linesp = CS5320_Hough_draw_pts(im,H4,H4pts,5,1);
% combo(im,linesp);