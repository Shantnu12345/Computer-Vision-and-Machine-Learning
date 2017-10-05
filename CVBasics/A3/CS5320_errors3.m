function  results = CS5320_errors3(pts_im,pts_world, NumOfTrials)
% CS5320_errors3 - get statistics on intrinsic parameters
% On input:
%     pts_im (3xk array): image points (homogeneous coords)
%     pts_world (4xk array): world coordinates (homogeneous coords)
%     num_trials (int): number of trials to run
% On output:
%     results (5x4 array): means, variances, and confidence intervals
%       row 1: alpha
%       row 2: beta
%       row 3: theta
%       row 4: x0
%       row 5: y0
%       col 1: mean
%       col 2: variance
%       col 3: lower value of confidence interval
%       col 4: upper value of confidence interval
% Call:
%    results = CS5320_errors3(pts_im,pts_world, 100)
% Author:
%     Shantnu Kakkar
%     UU
%     Spring 2016
%

% calculate value with image coordinates without noise
[alpha,beta,theta,x0,y0,R,t] = CS5320_calibrate(pts_im , pts_world);
results = zeros(5,4);
error = zeros(NumOfTrials,5);
vs = [0.1:0.1:1];
num_vs = length(vs) ;
for v_index = 1:num_vs  % set variance
    v = vs(v_index);
    for n = 1:num_trials
        pts_im_Noisy(1,:) = pts_im(1,:) + sqrt(v) * randn(1 , size(pts_im, 2));
        pts_im_Noisy(2,:) = pts_im(2,:) + sqrt(v) * randn(1 , size(pts_im, 2));
        pts_im_Noisy(3,:) = pts_im(3,:);
        [alphaN,betaN,thetaN,x0N,y0N,RN,tN]...
            = CS5320_calibrate(pts_im_Noisy , pts_world);
        Error_alpha = [Error_alpha ; alpha-alphaN];
        Error_beta = [Error_beta ; beta-betaN];
        Error_theta = [Error_theta ; theta-thetaN];
        Error_x0 = [Error_x0 ; x0-x0N]; 
        Error_y0 = [Error_y0 ; y0-y0N];
    end
    MeanError_alpha(v_index) = mean(Error_alpha);
    MeanError_beta(v_index) = mean(Error_beta);
    MeanError_theta(v_index) = mean(Error_theta);
    MeanError_x0(v_index) = mean(Error_x0);
    MeanError_y0(v_index) = mean(Error_y0);
end

for r = 1:5
     results(r,1) = mean(error(:,r));
     results(r,2) = var(error(:,r));
     results(r,3) = results(r,1) - 1.66*sqrt(results(r,2)/num_trials);
     results(r,4) = results(r,1) + 1.66*sqrt(results(r,2)/num_trials);
end