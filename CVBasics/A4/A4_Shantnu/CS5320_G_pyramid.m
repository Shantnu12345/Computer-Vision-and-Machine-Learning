function G_pyramid = CS5320_G_pyramid(I, k, sigma)
% CS5320_G_pyramid - Gaussian pyramid image
% On input:
%       I (mxn array): input image
%       k (int): size of smoothing window (2k+1 by 2k+1 window)
%       sigma (float): sigma for Gaussian function (scale parameter)
% On output:
%       G_pyramid (mxnx5 array): 5 images (stored in upper left corner)
%       comprising Gaussian pyramid
% Call:
%       pyr = CS5320_G_pyramid(I,4,2); % 9x9 window with variance 2
% Method:
%       See Forsyth and Ponce, Chapter 5
% Author:
%       Randy Hamburger Modified: Shantnu Kakkar; Spring 2016
%       UU - CS5320
%       Spring 2007
%
% Algorithm 4.1: Subsampling and Image by a factor of Two
% Apply a low-pass filter to the original image
% Create new image with dimensions half those of the old image
% Set the value of the i, jth pixel of the new image to the value
% of the 2i,2jth pixel of the filtered image
%
G_pyramid = [];
I = double(I);
[num_rows_IM , num_cols_IM] = size(I);
H = fspecial('gaussian',2*k+1,sigma);
G_pyramid(:,:,1) = filter2(H, I);

IM_downsample_1st = zeros(num_rows_IM,num_cols_IM);
IM_downsample_2nd = zeros(num_rows_IM,num_cols_IM);
IM_downsample_3rd = zeros(num_rows_IM,num_cols_IM);
IM_downsample_4th = zeros(num_rows_IM,num_cols_IM);

for i = 1:num_rows_IM/2
    for j = 1:num_cols_IM/2
        IM_downsample_1st(i,j) = G_pyramid(2*i,2*j,1);
    end
end
G_pyramid(:,:,2)= filter2(H, IM_downsample_1st);

for i = 1:num_rows_IM/4
    for j = 1:num_cols_IM/4
        IM_downsample_2nd(i,j) = G_pyramid(2*i,2*j,2);
    end
end
G_pyramid(:,:,3)= filter2(H, IM_downsample_2nd);

for i = 1:num_rows_IM/8
    for j = 1:num_cols_IM/8
        IM_downsample_3rd(i,j) = G_pyramid(2*i,2*j,3);
    end
end
G_pyramid(:,:,4)= filter2(H, IM_downsample_3rd);


for i = 1:num_rows_IM/16
    for j = 1:num_cols_IM/16
        IM_downsample_4th(i,j) = G_pyramid(2*i,2*j,4);
    end
end
G_pyramid(:,:,5)= filter2(H, IM_downsample_4th);

% Uncomment the following to draw the pyramid images
% figure;
% imagesc(I);colormap gray;
% title('Original image')
% 
% figure;
% imagesc(G_pyramid(:,:,1));colormap gray;
% title('level1 / Original image after filtering')
% 
% figure;
% imagesc(IM_downsample_1st);colormap gray;
% title('1st downsampled image');
% 
% figure;
% imagesc(G_pyramid(:,:,2));colormap gray;
% title('level2 / 1st downsampled image after filtering')
% 
% figure;
% imagesc(IM_downsample_2nd);colormap gray;
% title('2nd downsampled image');
% 
% figure;
% imagesc(G_pyramid(:,:,3));colormap gray;
% title('level 3 / 2nd downsampled image after filtering')
% 
% figure;
% imagesc(IM_downsample_3rd);colormap gray;
% title('3rd downsampled image');
% 
% figure;
% imagesc(G_pyramid(:,:,4));colormap gray;
% title('level 4 / 3rd downsampled image after filtering')
% 
% figure;
% imagesc(IM_downsample_4th);colormap gray;
% title('4th downsampled image');
% 
% figure;
% imagesc(G_pyramid(:,:,5));colormap gray;
% title('Level 5/ 4th downsampled image after filtering')
