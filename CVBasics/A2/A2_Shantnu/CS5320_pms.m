function [rho,N,g,f] = CS5320_pms(I,S)
% CS5320_pms - recover surface properties using photometric stereo
% On input:
% I (nxnxk array): k nxn images of surface
% S (nx3 array): light source vectors
% On output:
% rho (nxn array): albedo values of surface
% N (nxnx3 array): surface normals
% g (nxnx3 array): surface description (= rho*N)
% f (xnx array): height map
% Call:
% Q = CS5320_ps_sphere(60);
% S1 = [0,0,1];
% I1 = CS5320_ps_render(Q,S1);
% S2 = [0.7,0.7,1];
% S2 = S2/norm(S2);
% I2 = CS5320_ps_render(Q,S2);
% S3 = [-0.7,-0.7,1];
% S3 = S3/norm(S3);
% I3 = CS5320_ps_render(Q,S3);
% S4 = [0.7,-0.7,1];
% S4 = S4/norm(S4);
% I4 = CS5320_ps_render(Q,S4);
% S5 = [-0.7,0.7,1];
% S5 = S5/norm(S5);
% I5 = CS5320_ps_render(Q,S5);
% S = [S1;S2;S3;S4;S5];
% I(:,:,1) = I1;
% I(:,:,2) = I2;
% I(:,:,3) = I3;
% I(:,:,4) = I4;
% I(:,:,5) = I5;
% [rho,N,G,f] = CS5320_pms(I,S);
% Author:
% Shantnu Kakkar
% UU
% Spring 2016
%

rows = size(I,1);
columns = size(I,2);
NumOfSources = size(S,1);
N = zeros(rows, columns, NumOfSources) ;
p = zeros(rows, columns);
q = zeros(rows,columns);
g = zeros(rows,columns);
rho = zeros(rows, columns);
for i = 1:rows 
    for j = 1:columns
        GivenIntensities(1:NumOfSources ,1) = I(i,j,1:NumOfSources);
                ReconstructedIntensities = [];
        ReconstructedS = [];
        for k=1:NumOfSources
            if GivenIntensities(k,1) > 0.01
                ReconstructedIntensities = [ReconstructedIntensities ; GivenIntensities(k ,1)];
                ReconstructedS = [ReconstructedS ; S(k,1:3)];
            end
        end
        if size(ReconstructedS,1) >= 3
            g(i,j,1:3) =  ReconstructedS\ReconstructedIntensities;
            temp(1:3,1) = g(i,j,1:3);
            rho(i,j) = norm(temp);
            N(i,j,1) = g(i,j,1)/rho(i,j);
            N(i,j,2) = g(i,j,2)/rho(i,j);
            N(i,j,3) = g(i,j,3)/rho(i,j);
            p(i,j) = N(i,j,1)/N(i,j,3);
            q(i,j) = N(i,j,2)/N(i,j,3);
         end

    end
end

MiddleRow = rows/2;
MiddleColumn = columns/2;
f(MiddleRow , MiddleColumn) = (max(  max(p) ) + max(max(q)) )  / 2;
for i = MiddleRow+1:1:rows
    f(i,MiddleColumn) = f(i-1,MiddleColumn) + q(i,MiddleColumn);
end

for i = MiddleRow-1:-1:1
    f(i,MiddleColumn) = f(i+1,MiddleColumn) - q(i,MiddleColumn);
end

for i =1:rows
    for j = MiddleColumn+1:1:columns
        f(i,j) = f(i, j -1) - p(i,j); 
    end
    for j = MiddleColumn-1:-1:1
        f(i,j) = f(i, j +1) + p(i,j); 
    end
end
