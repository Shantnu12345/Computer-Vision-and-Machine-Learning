function im = CS5320_ps_render(Q,S)
% CS5320_ps_render - render images from surface model
% On input:
% Q (nxnx7 array): photometric stereo data (from CS5320_ps_sphere)
% S (3x1 vector): light source direction
% On output:
% im (nxn array): gray level image of surface with light source S
% Call:
% Q = CS5320_ps_sphere(60);
% I2 = CS5320_ps_render(Q,[0.8,0.8,1])
% Author:
% Shantnu Kakkar
% UU
% Spring 2016

normal = [];
for i=1:size(Q,1)
    for j=1:size(Q,2)
        albedo = Q(i,j,7) ;
        normal(1) = Q(i,j,4);
        normal(2) = Q(i,j,5);
        normal(3) = Q(i,j,6);
        im(i,j) = albedo * normal * S';
        if im(i,j) < 0
            im(i,j) = 0;
        end
    end
end

