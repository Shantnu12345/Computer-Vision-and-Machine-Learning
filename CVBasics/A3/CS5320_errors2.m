function  CS5320_errors2(pts_im, pts_world, NumOfTrials)
%
% Call:
% CS5320_errors2(pts_im, pts_world, NumOfTrials)
[alpha,beta,theta,x0,y0,R,t] = CS5320_calibrate(pts_im , pts_world);
error = [];
m_error = [];
numOfPoints = size(pts_im,2);
for sigma2 = 0:0.1:0.9
    x = [];
    for tr = 1:NumOfTrials
        pts = pts_im;
        for p = 1:numOfPoints
            pts(1,p) = pts(1,p) + sqrt(sigma2)*randn;
            x = [x;pts(1,p)];
            pts(2,p) = pts(2,p) + sqrt(sigma2)*randn;
        end
        [alphaN,betaN,thetaN,x0N,y0N,RN,tN]...
           = CS5320_calibrate(pts, pts_world);
       error = [error;alpha-alphaN];
       tch=0;
    end
    m_error = [m_error;mean(error)];
end
plot(0:0.1:0.9,m_error);

%%

% clear
% load('A36Kakkar.mat')
%  [alpha,beta,theta,x0,y0,R,t] = CS5320_calibrate(pts_im,pts_world);
%  im = CS5320_camera(pts_world,alpha,beta,theta,x0,y0,R,t);
% plot(im(1,:),im(2,:),'k.');
% title('Image formed by passing calculated parameters into CS5320_camera function of A1')
% figure;
% plot(im(1,:),im(2,:),'k.');
% title('Image formed from given image values')

