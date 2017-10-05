function  results = CS5320_errors(pts_im,pts_world, NumOfTrials)
% CS5320_errors - get statistics on intrinsic parameters
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

[alpha,beta,theta,x0,y0,R,t] = CS5320_calibrate(pts_im , pts_world);
vs = [0.1:0.1:1];
num_vs = length(vs) ;
for v_index = 1:num_vs  % set variance
    v = vs(v_index);
    Error_alpha = [];
    Error_beta = [];
    Error_theta = [];
    Error_x0 = [];
    Error_y0 = [];
    Error_t = [];
    Error_R = [];
    for i=1:NumOfTrials
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
        Error_R  = [ Error_R; norm(R-RN,'fro')];
        Error_t    =   [Error_t; norm(t-tN)];
    end
    MeanError(v_index,1) = mean(Error_alpha);
    MeanError(v_index,2) = mean(Error_beta);
    MeanError(v_index,3) = mean(Error_theta);
    MeanError(v_index,4) = mean(Error_x0);
    MeanError(v_index,5) = mean(Error_y0);
    MeanError(v_index,6) = mean(Error_R);
    MeanError(v_index,7) = mean(Error_t);
    
    VarError_alpha(v_index) = var(Error_alpha);
    VarError_beta(v_index) = var(Error_beta);
    VarError_theta(v_index) = var(Error_theta);
    VarError_x0(v_index) = var(Error_x0);
    VarError_y0(v_index) = var(Error_y0);
    VarError_R(v_index) = var(Error_R);
    VarError_t(v_index) = var(Error_t);
end

for r = 1:7
     results(r,1) = mean(MeanError(:,r));
     results(r,2) = var(MeanError(:,r));
     results(r,3) = results(r,1) - 1.66*sqrt(results(r,2)/NumOfTrials);
     results(r,4) = results(r,1) + 1.66*sqrt(results(r,2)/NumOfTrials);
     
end
% close all;
% plot(vs,MeanError(:,1),'k.-');
% title('Variance in image coordinates vs error in alpha ');
% xlabel('variance in image coordinates');
% ylabel('mean error');
% 
% figure;
% plot(vs,MeanError(:,2),'k.-');
% title('Variance in image coordinates vs error in beta ');
% xlabel('variance in image coordinates');
% ylabel('mean error');
% 
% figure;
% plot(vs,MeanError(:,3),'k.-');
% title('Variance in image coordinates vs error in theta ');
% xlabel('variance in image coordinates');
% ylabel('mean error');
% 
% figure;
% plot(vs,MeanError(:,4),'k.-');
% title('Variance in image coordinates vs error in x0 ');
% xlabel('variance in image coordinates');
% ylabel('mean error');
% 
% figure;
% plot(vs,MeanError(:,5),'k.-');
% title('Variance in image coordinates vs error in y0 ');
% xlabel('variance in image coordinates');
% ylabel('mean error');
% 
% figure;
% plot(vs,MeanError(:,6),'k.-');
% title('Variance in image coordinates vs error in R ');
% xlabel('variance in image coordinates');
% ylabel('mean error');
% 
% figure;
% % plot(vs,MeanError(:,7),'k.-');
% % title('Variance in image coordinates vs error in t ');
% % xlabel('variance in image coordinates');
% % ylabel('mean error');
% 
% close all;
% plot(vs,VarError_alpha,'k.-');
% title('Variance in image coordinates vs variance in error in alpha ');
% xlabel('variance in image coordinates');
% ylabel('varaince in error');
% 
% figure;
% 
% plot(vs,VarError_beta,'k.-');
% title('Variance in image coordinates vs variance in error in beta ');
% xlabel('variance in image coordinates');
% ylabel('varaince in error');
% 
% figure;
% 
% plot(vs,VarError_theta,'k.-');
% title('Variance in image coordinates vs variance in error in theta ');
% xlabel('variance in image coordinates');
% ylabel('varaince in error');
% 
% figure;
% 
% plot(vs,VarError_x0,'k.-');
% title('Variance in image coordinates vs variance in error in x0 ');
% xlabel('variance in image coordinates');
% ylabel('varaince in error');
% 
% figure;
% plot(vs,VarError_y0,'k.-');
% title('Variance in image coordinates vs variance in error in y0 ');
% xlabel('variance in image coordinates');
% ylabel('varaince in error');
% 
% figure;
% 
% plot(vs,VarError_R,'k.-');
% title('Variance in image coordinates vs variance in error in R ');
% xlabel('variance in image coordinates');
% ylabel('varaince in error');
% 
% figure;
% 
% plot(vs,VarError_t,'k.-');
% title('Variance in image coordinates vs variance in error in t ');
% xlabel('variance in image coordinates');
% ylabel('varaince in error');




