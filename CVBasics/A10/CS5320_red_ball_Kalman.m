function [ty,te] = CS5320_red_ball_Kalman(im_seq,ax,ay,del_t,R,Q)
% CS5320_red_ball_Kalman - track falling red ball. 
% Detect the ball in the image (that's the observation), 
% then use that in the Kalman filter (along with the constant 
% acceleration model)
% On input:
%       im_seg (struct vector): image sequence of falling ball (p
%           images)
%       ax (float): acceleration in x
%       ay (float): acceleration in y
%       del_t (float): time step
%       R (6x6 array): process covariance matrix
%       Q (2x2 array): observation covariance matrix
% On output:
%       ty (px6 array): observation values for p steps
%       te (px6 array): estimated state values for p steps
% Call:
%       R = 0.0001*eye(6,6);
%       R(5:6,5:6) = 0;
%       Q = eye(2,2);
%       [ty,te] = CS5320_red_ball_Kalman(Falling_Ball,0,-9.8,1/30,R,Q);
% Author:
%       SHantnu Kakkar
%       UU
%       Spring 2016
%
p = numel(im_seq);
max_t = (1/30)*p
[nr,nc,nd] = size(im_seq(1).cdata);
% Taking first observation
[rc,cc] = CS5320_detect_red_ball(im_seq(1).cdata,[230,30,30]);
x0 = cc; 
y0 = nr-rc+1;
vx0 = 0;
vy0 = 0;
[ta,ty,te] = CS5320_const_acc_Kalman(x0,y0,vx0,vy0,ax,ay,...
del_t,max_t,R,Q);



InitialStateEstimation = [x0,y0,0,0,ax,ay];
InitialSigmaEstimation = zeros(length(InitialStateEstimation));


