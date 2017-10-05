clc;
clear;
close all;
%% Correlation function
T = [100,100,100;100,100,100;100,100,100;];
imshow(T);
s1g = imread('s5.jpg');
s1gGray = rgb2gray(s1g);
load('UniversalTemplate.mat');
C = CS5320_normcorr_withMean(T,s1gGray);

%%  Gaussian Pyramid
s1g = imread('s.jpg');
s1gGray = rgb2gray(s1g);
pyr = CS5320_G_pyramid(s1gGray,4,2);

%% Help_hands gaussian
clc;
clear;
close all;
s1g = imread('s5.jpg');
s1gGray = rgb2gray(s1g);
tic
hands = CS5320_hands(s1gGray);
time1 = toc
 figure; imshow(hands);
 title('Calling CS5320edgemethod() function and finding the results for various images');

%% Help_hands edge
clc;
clear;
close all;
s1g = imread('s5.jpg');
s1gGray = rgb2gray(s1g);
tic
hands = CS5320_edge_method(s1gGray);
time1 = toc
 figure; imshow(hands);
 title('Calling CS5320edgemethod() function and finding the results for various images');


