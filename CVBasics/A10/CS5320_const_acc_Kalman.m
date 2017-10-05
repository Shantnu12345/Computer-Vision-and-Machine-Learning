function [ta,ty,te] = CS5320_const_acc_Kalman(x0,y0,vx0,vy0,ax0,ay0,...
del_t,max_t,R,Q)
% CS5320_const_acc_Kalman - simulation of constant acceleration
% scenario to show that we can simulate using a Kalman filter to
% track accelerated motion. Run this function for some object released from
% some height and track it. Try interesting combinations of R 
% and Q to demonstrate what happens.
% On input:
%       x0 (float): initial x locaiton
%       y0 (float): initial y location
%       vx0 (float): initial x speed
%       vy0 (float): initial y speed
%       ax0 (float): x acceleration
%       ay0 (float): y acceleration
%       del_t (float): time step
%       m ax_t (float): max time for simulation
%       R (6x6 array): process covariance matrix
%       Q (2x2 array): observation covariance matrix
% On output:
%       ta (px6 array): actual state values for p steps
%       ty (px2 array): observation values for p steps
%       te (px6 array): estimated state values for p steps
% Call:
%       [ta,ty,te] = CS5320_const_acc_Kalman(0,0,0,0,0,-9.8,0.1,3,R,Q);
% Author:
%       Shantnu Kakkar
%       UU
%       Spring 2016
%
 % Find state trace
 ta = CS5320_const_acc(x0,y0,vx0,vy0,ax0,ay0,del_t,max_t,R);
 
 % Find trace for observation
 M = [1 0 0 0 0 0;...
     0 1 0 0 0 0];
 ty = [];
 for p = 1:length(ta)
     y = CS5320_observe(ta(p,:)',M,Q);
     ty = [ty;y'];
 end
  
D= [1,0,del_t,0,0,0;...
    0,1,0,del_t,0,0;
    0,0,1,0,del_t,0;
    0,0,0,1,0,del_t;
    0,0,0,0,1,0;
    0,0,0,0,0,1];
 
%  Find estimation using Kalman
%  [x_im1,Sigma_im1] = FindMeanCovariance(x0,y0,vx0,vy0,ax0,ay0);
%  x_im1 = x_im1';
% te = [x_im1'];
%%%%%%%%%%%
x_im1 = ta(1,:)'
te = [x_im1'];
Sigma_im1 = zeros(length(x_im1),length(x_im1));
 for p = 1:length(ta)
     [x_im1,Sigma_im1] = CS5320_Kalman_step(x_im1,Sigma_im1,...
D,R,M,Q,y)
te = [te;x_im1'];
 end