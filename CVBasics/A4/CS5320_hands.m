function hands = CS5320_hands(im)
% CS5320_hands - find hands of surrender in image
% On input:
%       im (mxn array): image
% On output:
%       hands (mxnx3 array): rgb image of original with hands outlined
%       in red
% Call:
%       hands = CS5320_hands(s1g);
% Author:
%       Shantnu Kakkar
%       UU
%       Spring 2016
% Set the level of the gaussian pyramid 
% that you wnat for your image and template
levelT = 2;
levelIM =2;
 
hands = cat(3, im, im, im);
pyrIM = CS5320_G_pyramid(im,4,2);

%Hard Coding Template 
T =[247,247,247,248,246,248,248,248,246,248,247,248,244,247,247,247,248,247,248;248,248,248,248,248,246,248,245,247,246,247,248,247,248,247,247,248,247,247;248,248,248,248,248,245,248,247,247,247,246,248,247,248,247,248,248,247,247;246,247,248,247,247,245,242,244,237,245,241,246,244,248,247,248,248,247,248;246,244,244,246,241,234,224,223,208,234,225,239,239,247,245,247,247,247,246;246,246,245,245,235,219,211,195,185,212,207,229,234,244,247,246,246,246,247;247,246,246,245,232,209,204,193,189,201,194,215,220,228,246,247,245,245,246;246,243,241,244,231,206,176,174,176,159,181,211,210,219,241,247,246,246,245;246,245,244,242,216,194,150,142,136,120,167,195,204,220,246,245,246,245,246;245,245,246,243,211,185,134,120,127,111,148,181,196,222,244,246,247,246,246;245,247,244,240,208,172,144,125,120,116,148,165,187,228,245,247,246,245,245;245,243,244,236,220,178,163,141,117,126,164,170,188,228,238,240,244,245,246;245,244,241,232,219,182,159,144,136,140,165,164,181,212,233,242,243,245,243;244,243,243,228,209,186,151,150,139,145,154,161,184,226,244,242,243,241,232;242,242,242,226,209,191,154,145,149,142,139,166,195,224,242,241,243,243,236;242,241,242,230,211,189,163,130,133,123,116,161,191,221,242,243,244,243,239;242,243,240,230,206,180,164,132,119,113,103,142,185,203,241,244,243,243,244;242,244,240,224,199,181,167,129,108,110,104,137,183,192,225,242,243,244,244;240,241,240,227,195,180,145,111,105,104,99,121,176,186,216,241,241,242,241;241,243,242,229,193,163,114,82,88,86,91,115,173,186,206,226,238,242,230;239,242,241,219,179,144,104,70,75,77,87,114,150,172,193,207,221,233,227;232,241,236,206,173,142,87,57,66,68,83,107,137,163,192,206,206,227,226;228,237,222,189,167,141,84,53,62,73,88,100,123,148,182,202,201,211,217;224,231,215,177,162,142,90,61,53,68,88,108,123,131,162,191,204,202,211;202,204,182,154,147,134,83,57,56,69,98,109,122,122,153,183,195,195,206];
% load('UniversalTemplate.mat');
pyrT = CS5320_G_pyramid(T,1,1);
[num_rows_T , num_cols_T] = size(T);
[num_rows_IM , num_cols_IM] = size(im);

NumRowsInReducedT =  floor(num_rows_T/(2^(levelT-1)));
NumColsInReducedT =  floor(num_cols_T/(2^(levelT-1)));
NumColsInReducedIM =  floor(num_cols_IM/(2^(levelIM-1)));
NumRowsInReducedIM =  floor(num_rows_IM/(2^(levelIM-1)));



C =  CS5320_normcorr_withMean(pyrT(1:NumRowsInReducedT,...
    1:NumColsInReducedT ,levelT),...
    pyrIM(1:NumRowsInReducedIM,...
    1:NumColsInReducedIM,levelIM));

for i = 1: NumRowsInReducedIM 
    for j = 1:NumColsInReducedIM 
         if C(i,j)>0.7
             hands( 10+  i*(2^(levelIM-1)   ),j*(2^(levelIM-1)) ,1) = 256;
             hands(10 + i*(2^(levelIM-1)  ),j*(2^(levelIM-1)) ,2) = 0;
             hands(10 + i*(2^(levelIM-1) ),j*(2^(levelIM-1)) ,3) = 0;
            end
    end
end
% 
% figure;imagesc(pyrT(1:NumRowsInReducedT,...
%     1:NumColsInReducedT ,levelT));
% colormap gray;
% figure;imagesc(pyrIM(1:NumRowsInReducedIM,...
%     1:NumColsInReducedIM,levelIM));
% colormap gray;
% 
% figure; imshow(hands); 
% colormap gray;
% title('Calling CS5320hands() function and finding the results for various images. ')
