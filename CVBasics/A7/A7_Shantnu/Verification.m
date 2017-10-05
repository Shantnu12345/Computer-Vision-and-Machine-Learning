clc
clear
close all;
load('A7_tex'); 
% Things to play around with:
% xmin,xmax,ymin, ymax inside CS5320_bar
% HGaussian = fspecial('gaussian',23,7) inside CS5320_texture_params
% k here
k = 20;
% im_tex = imread('ImTry.jpg');
% im_tex = rgb2gray(imread('TestImage.jpg'));
 p_im = CS5320_texture_params(im_tex);
% p_im = CS5320_texture_params(im_tex(1:128,1:128,:));
[cl,el] = CS5320_k_means_texture(p_im,k);


for i = 1:k
    figure;
    combo(im_tex,el~=i);
    title(['combo for k =',num2str(k),'and el~=',num2str(i)]);
end
% combo(im_tex(129:256,129:256,:),el~=4);
figure;
imagesc(el);
title(['pseudo-colored classification image for k = ',num2str(k)]);

%%
close all;
 imagesc(B45);
imagesc(B0);
title('imagesc of bar at 0 degree rotation');
figure; surf(B0);
title('imagesc of bar at 0 degree rotation');

%% 
close all
load trees;
mapt = map;
clear map
imshow(X,mapt);
trees_rgb = ind2rgb(X,mapt);
[nr,nc,nd] = size(trees_rgb);
[IDX,C] = kmeans(reshape(trees_rgb,[nr*nc,3]),4);
IDX_im = reshape(IDX,[nr,nc]);
figure;combo(trees_rgb,IDX_im ~=4);
%% Testing CS5320_texture_params. You need to use debugger
% to test this function out. STop the debugger in CS5320_texture_params at the place 
% where you want to see results. By default it is stopped at 90 degrees
close all;
imagesc(R1);colormap gray;
 title('Response of image with spot 2 to find spots');
 figure; imagesc(map1); colormap gray;
 title('Positive rectification of the response of the image with the spot2 ');
 figure; imagesc(map2); colormap gray;
 title('Negative rectification of the response of the image with spot2');
 figure; imagesc(params(:,:,1)); colormap gray;
 title('Spot2 response summarized positive. We can see light spots in dark back ground.');
 figure; imagesc(params(:,:,2)); colormap gray;
 title('Spot2 response summarized negative. We can see dark spots in light back ground.');
 
 
 %%
 close all;
 colormap gray;
 figure; imagesc(params(:,:,1));colormap gray;
 title('spot1 summarized positive'); 
  figure; imagesc(params(:,:,2));colormap gray;
 title('spot1 summarized negative'); 
 
 figure; imagesc(params(:,:,3));colormap gray;
 title('spot2 summarized positive'); 
  figure; imagesc(params(:,:,4));colormap gray;
 title('spot2 summarized negative'); 
 
 
 
 figure; imagesc(params(:,:,5));colormap gray;
 title('bar 0 summarized positive'); 
  figure; imagesc(params(:,:,6));colormap gray;
 title('bar 0 summarized negative'); 
 
 
 figure; imagesc(params(:,:,7));colormap gray;
 title('bar 45 summarized positive'); 
  figure; imagesc(params(:,:,8));colormap gray;
 title('bar 45 summarized negative'); 
 
  figure; imagesc(params(:,:,9));colormap gray;
 title('bar 90 summarized positive'); 
  figure; imagesc(params(:,:,10));colormap gray;
 title('bar 90 summarized negative'); 
 
 
 figure; imagesc(params(:,:,11));colormap gray;
 title('bar 135 summarized positive'); 
  figure; imagesc(params(:,:,12));colormap gray;
 title('bar 135 summarized negative'); 
 
  figure; imagesc(params(:,:,13));colormap gray;
 title('mean summarized positive'); 
  figure; imagesc(params(:,:,14));colormap gray;
 title('mean summarized negative'); 
 
 
 figure; imagesc(params(:,:,15));colormap gray;
 title('variance summarized positive'); 
  figure; imagesc(params(:,:,16));colormap gray;
 title('variance summarized negative'); 
 