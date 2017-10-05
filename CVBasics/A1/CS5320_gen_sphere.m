

function sphere = CS5320_gen_sphere(C,radius,del_x,del_p) 
%generate 3D points on the surface of a sphere
% On input:
% C (3x1 vector): center of sphere
% radius (float): radius of sphere
% del_x (float): step size along major axis to generate points
% del_p (float): distance between points on the sphere
% On output:
% sphere (4xk array): homogeneous coordinates for points on the
% sphere
% row 1: X values
% row 2: Y values
% row 3: Z values
% row 4: 1’s (homogeneous coordinate)
% Call:
% sphere = CS5320_gen_sphere([0;0;0],2,0.1,0.1);
% Author:
% Shantnu Kakkar
% UU
% Spring 2016

sphere(1:3,1) = C + [-radius;0;0];
i = 2;
for distance = -radius+del_x : del_x : radius-del_x
    
    smallRadius = sqrt(      power(radius,2) - power(distance , 2)    );
    del_theta = asin(del_p/smallRadius);
    NumOfPoints = (2*pi)/del_theta;
    for x = 1: NumOfPoints
        xCoordinate = distance;
        yCoordinate = smallRadius*cos(x*del_theta);
        zCoordinate = smallRadius*sin(x*del_theta);
        sphere(1:3,i) = C + [xCoordinate ; yCoordinate ; zCoordinate];
        i = i + 1;
    end
end
sphere(1:3,i) =C+ [radius;0;0];
sphere(4,1:end) = ones(1,size(sphere,2));
%plot3(sphere(1,:) , sphere(2,:) ,  sphere(3,:), 'k.')
