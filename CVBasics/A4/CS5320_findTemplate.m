% function T = CS5320_findTemplate(s1g)
% CS5320_findTemplate - finds the template 
% On input:
%       im(mxn array) input image
% On output:
%       T()
% Call:
%       T = CS5320_findTemplate(s1g);
%
clc
clear
close all;
s1g = imread('s4.jpg');
% s1g = imread('s2.jpg');
imshow(s1g);
impixelinfo;
s1gGray = rgb2gray(s1g);
load('UniversalTemplate.mat');
imshow(T);
[num_rows_T , num_cols_T] = size(T);
[num_rows_IM , num_cols_IM] = size(s1gGray);
figure;
imshow(T);
tic;
C =  CS5320_normcorr_withoutMean(T,s1gGray);
%C =  CS5320_normcorr(T,T);
for i = 1: num_rows_IM 
    for j = 1:num_cols_IM
        if C(i,j)>0.97
            s1g(i,j,1) = 256;
            s1g(i,j,2) = 0;
            s1g(i,j,3) = 0;
        end
    end
end
time1 = toc
figure;
imshow(s1g);
title({'Directly doing the normal correlation between the images', 'and the universal template using CS5320normcorrwithMean() function'})

