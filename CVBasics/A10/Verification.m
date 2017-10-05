%% Background subtraction
clc;clear;
im= [];
im(1).im = imread('b5.jpg');
im(2).im = imread('b6.jpg');
im(3).im = imread('b7.jpg');
im(4).im = imread('b8.jpg');
im(5).im = imread('b9.jpg');
im(6).im = imread('b10.jpg');
im(7).im = imread('b11.jpg');
im(8).im = imread('b12.jpg');
im(9).im = imread('b13.jpg');
im(10).im = imread('b14.jpg');

 t_im = CS5320_background_sub_tracking(im);
 imshow(t_im(:,:,1)>60)  
%   surf(t_im(:,:,1));
 
  %%
  R = 0.0001*eye(6,6);
  R(5:6,5:6) = 0;
  Q = eye(2,2);
  p = CS5320_process_step(p,D,R);
  
  %% Detect ball
  [rc,cc] = CS5320_detect_red_ball(Falling_Ball(50).cdata,[230,30,30]);
  
  %% %       
  clc;clear;close all
  load('A10_data.mat');     
%   imshow(Falling_Ball(1).cdata);
%   hold on;
  R = 0.0001*eye(6,6);
  R(5:6,5:6) = 0;
  Q = eye(2,2);
  [ty,te] = CS5320_red_ball_Kalman(Falling_Ball,0,-9.8,1/30,R,Q);

  plot(ty(:,1),ty(:,2),'ro');
  hold on;
  plot(te(:,1),te(:,2),'b+');
   hold off;
   axis([120,180,280,340])
 legend('Observed estimate','Kalman estimate');
figure;
plot(ty(:,2),'r');
hold on 
plot(te(:,2),'b');  
legend('Observed estimate','Kalman estimate');
  %%
  clc;clear
  load('A10_data.mat');    
  im = Falling_Ball(1).cdata;
  [nr,nc,nd] = size(im);
temp_im = zeros(nr,nc);
model = [230,30,30];
for r = 1:nr
    for c = 1:nc
       if im(r,c,1) > model(1) & im(r,c,2) < model(2) & im(r,c,3) < model(3)
           temp_im(r,c) = 1;
       end
    end
end
[row,col] = find(temp_im==1);

MeanV = mean([row,col]);
Cov = cov([row,col]);
  
  
  