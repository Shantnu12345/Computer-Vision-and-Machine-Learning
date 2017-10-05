    function cube = CS5320_gen_cube(C,del_x,S) 
% generate 3D points on the edges of a cube
% On input:
% C (3x1 vector): center of sphere
% del_x (float): step size along edges to generate points
% S (float): length of side of cube
% On output:
% cube (4xk array): homogeneous coordinates for points on the cube
% row 1: X values
% row 2: Y values
% row 3: Z values
% row 4: 1’s (homogeneous coordinate)
% Call:
% cube = CS5320_gen_cube([0;0;0],0.01,1);
% Author:
% SHantnu Kakkar
% UU
% Spring 2016

i = 1;
y =  S/2;
z =  S/2;

for x = -S/2 : del_x : S/2
    cube(1:3,i) = C + [x ; y ; z];
    i = i + 1;
    cube(1:3,i) = C + [x ; y ; -z];
    i = i + 1;
    cube(1:3,i) = C + [x ; -y ; z];
    i = i + 1;
    cube(1:3,i) = C + [x ; -y ; -z];
    i = i + 1;
end

x =  S/2;
z =  S/2;

for y = -S/2 : del_x : S/2
    cube(1:3,i) = C + [x ; y ; z];
    i = i + 1;
    cube(1:3,i) = C + [x ; y ; -z];
    i = i + 1;
    cube(1:3,i) = C + [-x ; y ; z];
    i = i + 1;
    cube(1:3,i) = C + [-x ; y ; -z];
    i = i + 1;
end

x =  S/2;
y =  S/2;

for z = -S/2 : del_x : S/2
    cube(1:3,i) = C +[x ; y ; z];
    i = i + 1;
    cube(1:3,i) =C + [x ; -y ; z];
    i = i + 1;
    cube(1:3,i) =C + [-x ; y ; z];
    i = i + 1;
    cube(1:3,i) = C +[-x ; -y ; z];
    i = i + 1;
end

cube(4,:) = ones(1,size(cube,2));

%plot3(cube(1,:) , cube(2,:) , cube(3,:), 'k.');


