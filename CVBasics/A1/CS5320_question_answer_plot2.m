function [means, vars, ci_dn, ci_up]  = CS5320_question_answer_plot2() 

% produce error
% On input:
% No input. All required parameters are specified within the function
% On output:
% means(1X10): mean error in the point locations in the image with variance
% in parameter ranging from 0.1 to 1

% variance (1X10) : variance in error in the point locations in the image with variance
% in parameter ranging from 0.1 to 1

%ci_dn (1X10): lower confidence interval in error in the point locations in the image with variance
% in parameter ranging from 0.1 to 1
%ci_up(1X10): upper confidence interval in error in the point locations in the image with variance
% in parameter ranging from 0.1 to 1
% Call: [means, vars, ci_dn, ci_up]  = CS5320_question_answer_plot2() 
% Author: Shantnu Kakkar
% UU
% Spring 2016

alpha = 1;
beta = 1; 
theta = pi/2;
x0 = 0;
y0 = 0;
R = eye(3,3);
t = [0;0;0];
cube = CS5320_gen_cube([0;0;0],0.01,1);
im = CS5320_camera(cube,alpha,beta,theta,x0,y0,R,t);

numOfTrials = 100;
vs = [0.1:0.1:1];
num_vs = length(vs);
for v_index = 1:num_vs  % set variance
     v = vs(v_index);
     for k = 1:numOfTrials
         y0n= y0 +  sqrt(v)*randn;   % randn samples the N(0,1) distribution
         im_a = CS5320_camera(cube,alpha,beta,theta,x0,y0n,R,t);
         x(1:3,:) =   im(1:3,:) - im_a(1:3,:);
         for j = 1:size(x,2)
             ErrorInOnePoint(j) = norm(x(1:3,j));
         end
         sum = 0;
         for i = 1:size(ErrorInOnePoint,2)
             sum = sum + ErrorInOnePoint(i);
        end
        errors(k) = sum/size(ErrorInOnePoint,2);
     end 
     means(v_index) = mean(errors);
     vars(v_index) = var(errors);      
     ci_dn(v_index) = means(v_index) - 1.66*sqrt(vars(v_index)/100);
     ci_up(v_index) = means(v_index) + 1.66*sqrt(vars(v_index)/100);
end


plot([0,vs, 1] , [0 , vars, 5]);
xlabel('variance');
ylabel('mean');
title('variance in the y0 v/s mean error in the point locations in the image ');