function params = CS5320_texture_params(im)
% CS5320_texture_params - compute texture parameters
% On input:
%       im (mxnx3 array): input image
% On output:
%       params (mxnx16 array): texture parameter image
%       channel 1: spot1 summarized positive
%       channel 2: spot1 summarized negative
%       channel 3: spot2 summarized positive
%       channel 4: spot2 summarized negative
%       channel 5: bar (0) summarized positive
%       channel 6: bar (0) summarized negative
%       channel 7: bar (45) summarized positive
%       channel 8: bar (45) summarized negative
%       channel 9: bar (90) summarized positive
%       channel 10: bar (90) summarized negative
%       channel 11: bar (135) summarized positive
%       channel 12: bar (135) summarized negative
%       channel 13: mean summarized positive
%       channel 14: mean summarized negative
%       channel 15: variance summarized positive
%       channel 16: variance summarized negative
% Call:
%       p_im = CS5320_texture_params(im_tex);
% Author:
%       Shantnu Kakkar
%       UU
%       Spring 2016
%
params = [];
HGaussian = fspecial('gaussian',22,7);
HMean = fspecial('average',11);

S1 = CS5320_spot1();
S2 = CS5320_spot2();

B0 = CS5320_bar(1,0,0,-1);
B0 = imresize(B0,[101,101]);
B45 = imrotate(B0,45,'crop');
B90 = imrotate(B0,90,'crop');
B135 = imrotate(B0,135,'crop');
B0 = imresize(B0,[11,11]);
B45 = imresize(B45,[11,11]);
B90 = imresize(B90,[11,11]);
B135 = imresize(B135,[11,11]);


R1 = filter2(S1,im);
map1 = max(0,R1);
map2 = max(0,-R1);
params(:,:,1) = filter2(HGaussian,map1);
params(:,:,2) = filter2(HGaussian,map2);

R1 = filter2(S2,im);
map1 = max(0,R1);
map2 = max(0,-R1);
params(:,:,3) = filter2(HGaussian,map1);
params(:,:,4) = filter2(HGaussian,map2);

R1 = filter2(B0,im);
map1 = max(0,R1);
map2 = max(0,-R1);
params(:,:,5) = filter2(HGaussian,map1);
params(:,:,6) = filter2(HGaussian,map2);

R1 = filter2(B45,im);
map1 = max(0,R1);
map2 = max(0,-R1);
params(:,:,7) = filter2(HGaussian,map1);
params(:,:,8) = filter2(HGaussian,map2);

R1 = filter2(B90,im);
map1 = max(0,R1);
map2 = max(0,-R1);
params(:,:,9) = filter2(HGaussian,map1);
params(:,:,10) = filter2(HGaussian,map2);

R1 = filter2(B135,im);
map1 = max(0,R1);
map2 = max(0,-R1);
params(:,:,11) = filter2(HGaussian,map1);
params(:,:,12) = filter2(HGaussian,map2);

R1 = filter2(HMean,im);
map1 = max(0,R1);
map2 = max(0,-R1);
params(:,:,13) = filter2(HGaussian,map1);
params(:,:,14) = filter2(HGaussian,map2);

R1 = stdfilt(im,ones(11));
R1 = R1.^2;
% R1 = CS5320_myFilter(im);
map1 = max(0,R1);
map2 = max(0,-R1);
params(:,:,15) = filter2(HGaussian,map1);
params(:,:,16) = filter2(HGaussian,map2);



