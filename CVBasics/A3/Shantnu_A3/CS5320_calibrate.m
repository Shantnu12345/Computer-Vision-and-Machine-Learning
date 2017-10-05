function [alpha,beta,theta,x0,y0,R,t] = CS5320_calibrate(im,P)
% CS5320_calibrate - determine camera parameters
% On input:
% im (3xk array): image points (homogeneous coords)
% im(1,:): x coords; im(2,:): y coords
% P (4xk array): world coordinates (homogeneous coords)
% P(1,:): x coords; P(2,:): y coords; P(3,:): z coords
% On output:
% alpha (float): scale parameter in x
% beta (float): scale parameter in y
% theta (float): camera skew angle
% x0 (float): x coord of optical center
% y0 (float): y coord of optical center
% R (3x3 array): rotation matrix
% t (3x1 vector): translation vector
% Call:
% [alpha,beta,theta,x0,y0,R,t] = CS5320_calibrate(pts_im,pts_world);
% Author:
% Shantnu Kakkar
% UU
% Spring 2016

NumOfPoints = size(im,2);
PMatrix = [];
for i = 1:NumOfPoints
    PMatrix =  [PMatrix;...
        P(:,i)' , 0 , 0 , 0 , 0 , - im(1,i)* P(:,i)';...
        0 , 0 , 0 , 0 , P(:,i)' , - im(2,i)*P(:,i)']; 
end
[V,D] = eigs(PMatrix'*PMatrix , 12);
[vOld,indexes] = sort(diag(D));
index = indexes(1); 
M=[V(1:4,index)';V(5:8,index)';V(9:12,index)']; 
M_hat=M/norm(M(3,1:3));
imp = M_hat*P;
if max(imp(3,:)) > 0
    M_hat = -M_hat;
    imp = M_hat*P;
end
A = M_hat(:,1:3);
b = M_hat(:,4);
a1Transpose = A(1,1:3);
a1 = a1Transpose';
a2Transpose = A(2,1:3);
a2 = a2Transpose';
a3Transpose = A(3,1:3);
a3 = a3Transpose';
rho = 1/norm(a3);
r3 = rho*a3;
r1 = cross(a2,a3)/norm(cross(a2,a3));
r2 = cross(r3,r1);
x0 = rho*rho*dot(a1,a3);
y0 = rho*rho*dot(a2,a3);
theta = acos((-dot(cross(a1,a3),cross(a2,a3)))...
    /(norm(cross(a1,a3))*norm(cross(a2,a3))));
alpha = rho*rho*norm(cross(a1,a3))*sin(theta);
beta =   rho*rho*norm(cross(a2,a3))*sin(theta);
K = [alpha,-alpha*cot(theta),x0; 0,beta/sin(theta),y0; 0,0,1];
t = rho*inv(K)*b;
R = [r1'; r2'; r3'];
TCameratoWorld = [R(1,:)   ,   t(1) ;...
                                   R(2,:)   ,   t(2) ;... 
                                   R(3,:)   ,   t(3) ;...
                                   0,0,0    ,     1 ];
                               
Ti = inv(TCameratoWorld);
R = Ti(1:3,1:3);
t = Ti(1:3,4);
