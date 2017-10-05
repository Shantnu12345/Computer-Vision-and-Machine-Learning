function y = CS5320_observe(x,M,Q)
% CS5320_observe - linear observation (sensor)
% On input:
%       x (nx1 vector): state vector
%       M (kxn array): observation matrix
%       Q (kxk array): observation covariance
% On output:
%       y (kx1 vector): observation (sensor) vector
% Call:
%       y = CS5320_observe(x,M,Q);
% Author:
% Shantnu Kakkar
% UU
% spring 2016
%
y = M*x + mvnrnd([0;0],Q)';