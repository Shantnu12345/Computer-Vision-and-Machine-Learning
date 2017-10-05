% Please run individual sections below using 
%ctrl+enter or pressing run section button in the 
%editor tab. Please comment if you do not like this
%way of organizing code.

%% Harris
clc;clear;
imoriginal = imread('square.jpg');
im = imread('square.jpg');
% imshow(im);
im = rgb2gray(im); 
imshow(im);
R = CS5320_Harris(im,1);
combo(double(imoriginal), R>max(max(R/25)));
title('result for Harris corner detection');

%% log interest
clc;clear;
im = imread('glass-box.jpg');
im = rgb2gray(im); 
 [A_IP,A_scale] = CS5320_LoG_interest(im,0.7);
 
%% Histogram
clc;clear;
im = imread('glass-box.jpg');
im = rgb2gray(im); 
H = CS5320_gradient_histogram(im,8,8,3,0,0.1);

%% corner patches
clc;clear;close all;
im = imread('glass-box.jpg');
im = rgb2gray(im); 

%  im = [im(:,101:size(im,2)),im(:,1:100)];
%  im = imrotate(im,45);
im = imresize(im,2);
p = CS5320_corner_patches(im,4,2);
imshow(im);
hold on;
quiver(p(:,2),p(:,1),-1*cosd(p(:,4)),-1*sind(p(:,4)));
% title('Results for algo 5.2 after scalling')
%% loG patches
clc;clear;close all;
im = imread('glass-box.jpg');
im = rgb2gray(im); 
% Uncomment as required
% im = [im(:,101:size(im,2)),im(:,1:100)];
%  im = imrotate(im,45);
im = imresize(im,2);
p = CS5320_LoG_patches(im,2,2);
imshow(im);
hold on;
quiver(p(:,2),p(:,1),-1*cosd(p(:,4)),-1*sind(p(:,4)));

% title('Results for algo 5.3 after scalling')