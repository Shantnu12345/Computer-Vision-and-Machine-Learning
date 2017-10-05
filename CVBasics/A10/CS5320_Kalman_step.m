function [x_i_plus,Sigma_i_plus] = CS5320_Kalman_step(x_im1,Sigma_im1,...
D,R,M,Q,y)
% CS5320_Kalman_step - one step in Kalman filter update
% On input:
%       x_im1 (nx1 vector): state vector at step i-1
%       Sigma_im1 (nxn array): state covariance array
%       D (nxn array): linear process matrix
%       R (nxn array): process covariance matrix
%       M (kxn arraay): linear observation matrix
%       Q (kxk array): observation covariance array
%       y (kx1 vector): observation vector
% On output:
%       x_i_plus (nx1 vector): updated state vector
%       Sigma_i_plus (nxn array): state covariance matrix
% Call:
%       [x,Sigma] = CS5320_Kalman_step(x,Sigma,D,R,M,Q,y);
% Author:
% Shantnu Kakkar
% UU
% Spring 2016
%

x_i_minus = D*x_im1;
sigma_i_minus = R + D*Sigma_im1*D';

K = sigma_i_minus*(M')*inv(M*sigma_i_minus*(M') + Q);

x_i_plus = x_i_minus + K*(y - M*x_i_minus);
Sigma_i_plus = sigma_i_minus - K*M*sigma_i_minus;