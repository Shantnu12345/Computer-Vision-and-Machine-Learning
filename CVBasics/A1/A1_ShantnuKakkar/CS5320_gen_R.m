function R = CS5320_gen_R(u,theta) 
% generate a rotation matrix about an arbitrary vector
% On input:
% u (3x1 vector): unit vector about which to rotate
% theta (float): amount to rotate (in radians)
% On output:
% R (3x3 matrix): rotation matrix
% Call:
% R = CS5320_gen_R([0;0;1],pi/2);
% Author:
% Shantnu Kakkar
% UU
% Spring 2016

C = cos(theta);
S = sin(theta);
t = 1 - cos(theta);

R = [ t * power(u(1),2) + C, t * u(1)*u(2) -  S*u(3), t * u(1) * u(3) + S*u(2);...
         t*u(1)*u(2) + S*u(3), t * power(u(2),2) + C, t * u(2) * u(3) - S*u(1);...
         t*u(1)*u(3) - S * u(2) , t * u(2) * u(3) + S * u(1) , t * power(u(3),2) + C];
