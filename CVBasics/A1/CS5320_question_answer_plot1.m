function [error, m_err, v_err, ci_low, ci_high]  = CS5320_question_answer_plot1() 

% produce camera model perspective projection
% On input:
% No input required. All required parameters are specified within the
% function. Add noise to the parameter that you want to vary. By default, 
% noise is being added on alpha

% On output:
% Error vector for 100 trials
% m_err - mean of errors
% v_err - varaince of errors
% ci_low = lower confodence interval
% ci_high = higher confidence interval

% Call:  [error, m_err, v_err, ci_low, ci_high]  = CS5320_question_answer_plot1() 
% Author: Shantnu Kakkar
% UU
% Spring 2016

alpha = 1;
beta = 1; 
theta = pi/2;
x0 = 0;
y0 = 0;
R = eye(3,3);
t = [0;0;1];
cube = CS5320_gen_cube([0;0;0],0.01,1);
im = CS5320_camera(cube,alpha,beta,theta,x0,y0,R,t);

numOfTrials = 100;
 for k = 1:numOfTrials
     y0n = y0 + randn;   % randn samples the N(0,1) distribution
     im_a = CS5320_camera(cube,alpha,beta,theta,x0,y0n,R,t);
     x(1:3,:) =   im(1:3,:) - im_a(1:3,:);
     for j = 1:size(x,2)
         ErrorInOnePoint(j) = norm(x(1:3,j));
     end
     sum = 0;
     for i = 1:size(ErrorInOnePoint,2)
         sum = sum + ErrorInOnePoint(i);
    end
    error(k) = sum/size(ErrorInOnePoint,2);
     
 end 
 
 m_err = mean(error);
  v_err = var(error);
 ci_low = m_err - 1.66*sqrt(v_err/100);
 ci_high = m_err + 1.66*sqrt(v_err/100);
 

 plot([1 1:numOfTrials 100], [0,error,5]);
  xlabel('Trial Number');
 ylabel('Error Value');
 title(' Plot of trial number vs error for that trial number with change in y0');
 
 
 
 