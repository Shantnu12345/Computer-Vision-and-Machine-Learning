%% CV_total_LS(x,y)
% % load('A9_images.mat'); 
 [p,s] = CV_total_LS([100,200,300] + rand(1,3), [100,200,300]+ rand(1,3))
CS5320_plot_line(p,-5,5,-5,5);
axis([-10 10 -10 10]);
xlabel('x');
ylabel('y');
title('Line output by CVtotalLS() function plotted using CS5320plotline() function');
%% CS5320_Hough
clc;clear;
hall4 = imread('hall4.jpg');
hall4g = rgb2gray(hall4);
[H4,H4pts] = CS5320_Hough(double(hall4g));
%% CS5320_Hough result with CS5320_Hough_lines
clc;clear;
hall4 = imread('hall4.jpg');
hall4g = rgb2gray(hall4);
[H4,H4pts] = CS5320_Hough(double(hall4g)); 
H4 = CS5320_local_max(H4,2);
lines = CS5320_Hough_lines(hall4g,H4,82);
combo(mat2gray(hall4g),lines);
title('Result of hough function with houghlines function');
%% Test hough on square image 
clc;clear;close all
A = zeros(50,50);
A(11:40,11:40) = 1;
imshow(A);
title('Square image');
[HA,HApts] = CS5320_Hough(A);
figure; imagesc(HA);
lines = CS5320_Hough_lines(A,HA,7);
figure;combo(A,lines);
title('Results  for sqaure image before localmax function');
HA = CS5320_local_max(HA,10);
lines = CS5320_Hough_lines(A,HA,7);
figure;combo(A,lines);

title('Results  for sqaure image after localmax function');

%% Testing CS5320_Hough_draw_pts for square image
A = zeros(50,50);
A(11:40,11:40) = 1;
[HA,HApts] = CS5320_Hough(A);
HA = CS5320_local_max(HA,10);
linesp = CS5320_Hough_draw_pts(A,HA,HApts,3,1);
figure;combo(A,linesp);
title('Results  for sqaure image drawn using HoughDrawPoints function');
%% Testing CS5320_Hough and CS5320_Hough_draw_pts on T image 
T = zeros(30,20);
T(8:25,8:12) = 1;
T(5:8,5:15) = 1;
imshow(T);
[HT,HTpts] = CS5320_Hough(T);
 HT = CS5320_local_max(HT,2);
linesp = CS5320_Hough_draw_pts(T,HT,HTpts,5,1);
combo(T,linesp);
title('Results  for T- image drawn using HoughDrawPoints function');
%% CS5320_Hough result with CS5320_Hough_draw_pts
hall4 = imread('hall4.jpg');
hall4g = rgb2gray(hall4);
[H4,H4pts] = CS5320_Hough(double(hall4g));
 H4 = CS5320_local_max(H4,2);
% load('ResultHall4.mat');
linesp = CS5320_Hough_draw_pts(hall4,H4,H4pts,15,1);
%  combo(mat2gray(hall4g),linesp);
title('Result of hough function with drawpoints function');
%% CS5320_Hough result with CS5320_line_segs
clc;clear;close all;
hall4 = imread('hall4.jpg');
hall4g = rgb2gray(hall4);
hall4ge = edge(hall4g,'canny');



vs = [1:100:1000];
num_vs = length(vs);
for v_index = 1:num_vs  % set variance
        hall4 = imread('hall4.jpg');
        hall4gOriginal = rgb2gray(hall4);
        v = vs(v_index);
        hall4g(:,:) = double(hall4gOriginal) + sqrt(v)*randn(size(hall4gOriginal));
        [H4,H4pts] = CS5320_Hough(double(hall4g));
        As = CS5320_line_segs2(hall4g,H4pts,80);
        for i = 1:size(As,2)
            for k = 1:length(As(i).pts)
                 r = As(i).pts(k,1);
                 c = As(i).pts(k,2);
                 hall4(r,c,1) = 255;
                 hall4(r,c,2) = 0;
                 hall4(r,c,3) = 0;
            end
        end
        figure;imshow(hall4);
end
%% CS5320_line_segs using Square
% CS5320_line_segs should consider min_length as the 
%number of pts in an edge, and not the max distance 
%(otherwise, 2 distant edges would give rise to a segment).
clc;clear;close all;
A = zeros(50,50);
A(11:40,11:40) = 1;
[HA,HApts] = CS5320_Hough(A);

As = CS5320_line_segs(A,HApts,20);
ArgbImage = cat(3, A, A, A);
for i = 1:size(As,2)
    for k = 1:length(As(i).pts)
         r = As(i).pts(k,1);
         c = As(i).pts(k,2);
         ArgbImage(r,c,1) = 255;
         ArgbImage(r,c,2) = 0;
         ArgbImage(r,c,3) = 0;
    end
end
figure;imshow(ArgbImage);
title('Results  for sqaure image drawn using LineSegment function');
%% Testing CS5320_plot_line
CS5320_plot_line([0,1,-2],-7,7,0,0)
CS5320_plot_line([1,0,-2],7,7,-7,7)
axis([-10,10 -10 10])
xlabel('x');
ylabel('y');
title('Results for plot line');

%% Testing Addidtion of Gaussian noise
clc;clear;
hall4 = imread('hall4.jpg');
hall4gOriginal = rgb2gray(hall4);
[nr,nc] = size(hall4gOriginal);
vs = [1:100:1000];
num_vs = length(vs);
for v_index = 1:num_vs  % set variance
        v = vs(v_index);
        hall4gModified(:,:) = double(hall4gOriginal) + sqrt(v)*randn(size(hall4gOriginal));
        [H4,H4pts] = CS5320_Hough(double(hall4gModified)); 
        H4 = CS5320_local_max(H4,2);
%         linesp = CS5320_Hough_draw_pts(hall4gModified,H4,H4pts,16,0);
linesp = CS5320_Hough_lines(hall4gModified,H4,82);        
figure;combo(mat2gray(hall4gModified),linesp);
        title(['Result of hough function with HoughLines function for variance in noise= ', num2str(v)]);
                
end

     
