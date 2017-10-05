

%% Extracting from image 1
im = imread('s1.jpg');
im = rgb2gray(im);
imagesc(im);colormap gray
impixelinfo;
%  im = edge(im,'sobel');
T1 = im(43:67,95:113);
imagesc(T1);colormap gray

T2 = im(43:67,158:176);
figure;
imagesc(T2);colormap gray

T3 = im(47:71,174:192);
figure;
imagesc(T3);colormap gray

T4 = im(46:70,229:247);
figure;
imagesc(T4);colormap gray

T = (T1/4+T2/4+T3/4+T4/4);
imagesc(T);colormap gray

save ('UniversalTemplate','T');

%% Extracting from image 2
im = imread('s2.jpg');
im = rgb2gray(im);
imagesc(im);colormap gray
impixelinfo;
figure;
%  im = edge(im,'sobel');
T5 = im(65:89,57:75);
imagesc(T5);colormap gray

T6 = im(65:89,89:107);
figure;
imagesc(T6);colormap gray

T7 = im(70:94,191:209);
figure;
imagesc(T7);colormap gray

T8 = im(69:93,207:225);
figure;
imagesc(T8);colormap gray

T = (T5/4+T6/4+T7/4+T8/4);
figure;
imagesc(T);colormap gray

save ('UniversalTemplate','T');

%% Extracting from image 3
im = imread('s3.jpg');
im = rgb2gray(im);
imagesc(im);colormap gray
impixelinfo;
figure;
%  im = edge(im,'sobel');
T9 = im(49:73,185:203);
imagesc(T9);colormap gray

T10 = im(45:69,121:139);
figure;
imagesc(T10);colormap gray

T11 = im(55:79,70:88);
figure;
imagesc(T11);colormap gray


T12 = im(49:73,185:203);
figure;
imagesc(T12);colormap gray

T = (T9/4+T10/4+T11/4+T12/4);
figure;
imagesc(T);colormap gray

save ('UniversalTemplate','T');

%% Extracting from image 4
im = imread('s4.jpg');
im = rgb2gray(im);
imagesc(im);colormap gray
impixelinfo;
figure;
%  im = edge(im,'sobel');
T13 = im(31:55,135:153);
imagesc(T13);colormap gray

T14 = im(34:58,173:191);
figure;
imagesc(T14);colormap gray

T15 = im(28:52,44:62);
figure;
imagesc(T15);colormap gray


T16 = im(28:52,10:28);
figure;
imagesc(T16);colormap gray

T = (T13/4+T14/4+T15/4+T16/4);
figure;
imagesc(T);colormap gray

save ('UniversalTemplate','T');

%% Merge all templates

T = (T1/16+T2/16+T3/16+T4/16+T5/16+T6/16+T7/16+...
    T8/16+T9/16+T10/16+T11/16+T12/16 + T13/16+...
    T14/16+T15/16+T16/16);

save ('UniversalTemplate','T');
figure;
imagesc(T);colormap gray