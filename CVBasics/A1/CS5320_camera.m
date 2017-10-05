function im = CS5320_camera(scene,alpha,beta,theta,x0,y0,R,t) 
% produce camera model perspective projection. 
% The function checks if Z is positive or negative. 
% If Z is positive then image point is discarded
% The function limits range of x and y image coordinates between 
% -10 to 10
% On input:
% scene (4xk array): 3D homogeneous coordinate world points
% alpha (float): pixel scale parameter in x (intrinsic)
% beta (float): pixel scale parameter in y (intrinsic)
% theta (float): image frame skew angle (intrinsic)
% x0 (float): image plane center offset (intrinsic)
% y0 (float): image plane center offset (intrinsic)
% R (3x3 array): rotation array (extrinsic)
% t (3x1 vector): translation vector world origin to camera
% (extrinsic)
% On output:
% im (3xk array): homogeneous coordinates for points on image
% plane
% row 1: X values
% row 2: Y values 
% row 3: 1’s (homogeneous coordinate)

% Call:im = CS5320_camera(cube,1,1,pi/2,0,0,eye(3,3),[0;0;0]);
%
% Author:
% Shantnu Kakkar
% UU
% Spring 2016
im = [];
TCameratoWorld = [R(1,:)   ,   t(1) ;...
                                   R(2,:)   ,   t(2) ;... 
                                   R(3,:)   ,   t(3) ;...
                                   0,0,0    ,     1 ];
                               
Ti = inv(TCameratoWorld);

r1T = Ti(1,1:3);
r2T = Ti(2,1:3);
r3T = Ti(3,1:3);
ti= [];
ti(1) = Ti(1,4);
ti(2) = Ti(2,4);
ti(3) = Ti(3,4);

M = [alpha*r1T - alpha*cot(theta)*r2T + x0*r3T, alpha*ti(1) - alpha*cot(theta)*ti(2) + x0*ti(3);...
        (beta/sin(theta))*r2T + y0*r3T, (beta/sin(theta))*ti(2) + y0*ti(3);...
        r3T, ti(3)];
 imO =  M * scene; 
 k = 1;
 for i = 1: size(scene,2)
  %   if imO(3,i) < 0    %checking if Z is positive or negative. If Z is positive then image point is discarded
         im(1,k) = imO(1,i)/imO(3,i);
         im(2,k) = imO(2,i)/imO(3,i);
         im(3,k) = imO(3,i)/imO(3,i);
         k = k + 1;
     %end
 end
 %Limiting the range of x and y coordinates from -10 to 10
 im = min(im,10);
 im = max(im,-10);
 
 % plot([-10,im(1,:),10] ,[-10, im(2,:),10] , 'k.');