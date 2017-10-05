function [meanError_depth, meanError_rho, meanError_N] =  CS5320_ps_error(Q,rho,N,G,f)
%  CS5320_ps_error -  calculates errors in estimation of depth, rho and N
% On input:
% rho (nxn array): albedo values of surface
% N (nxnx3 array): surface normals
% g (nxnx3 array): surface description (= rho*N)
% f (xnx array): height map
%On output:
% meanError_Rho (1x1): mean error in row
% meanError_N (1x1): mean error in normal
% meanError_depth(1x1): mean error in f
% Call:
% [meanError_depth, meanError_rho, meanError_N] =  CS5320_ps_error(Q,rho,N,G,f)
% Author:
% Shantnu Kakkar
% UU
% Spring 2016
%

rows = size(f,1);
columns = size(f,2);
err = 0;
SumError = 0;
errorVector = [];
for i = 1:rows
    for j = 1:columns
        err = norm(Q(i,j,3) - f(i,j));
        errorVector = [errorVector ; err];
    end
end
meanError_depth = mean(errorVector);
varError_depth = var(errorVector);
ci_low_depth = meanError_depth - 1.645*sqrt(varError_depth/100);
ci_high_depth = meanError_depth + 1.645*sqrt(varError_depth/100);
 
err = 0;
SumError = 0;
errorVector = [];
for i = 1:rows
    for j = 1:columns
        err = norm(Q(i,j,7) - rho(i,j));
        errorVector = [errorVector ; err];
    end
end
meanError_rho = mean(errorVector);
varError_rho = var(errorVector);
ci_low_rho = meanError_rho - 1.645*sqrt(meanError_rho/100);
ci_high_rho = meanError_rho + 1.645*sqrt(meanError_rho/100);

err = 0;
SumError = 0;
errorVector = [];
for i = 1:rows
    for j = 1:columns
        err(1,1) = Q(i,j,4) - N(i,j,1);
        err(2,1) = Q(i,j,5) - N(i,j,2);
        err(3,1) = Q(i,j,6) - N(i,j,3);
        errMagnitude = norm(err);
        errorVector = [errorVector ; errMagnitude];
    end
end
meanError_N = mean(errorVector);
varError_N = var(errorVector);
ci_low_N = meanError_N - 1.645*sqrt(varError_N/100);
ci_high_N = meanError_N + 1.645*sqrt(varError_N/100);

