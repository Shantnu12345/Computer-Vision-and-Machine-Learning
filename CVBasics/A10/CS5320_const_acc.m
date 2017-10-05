function trace = CS5320_const_acc(x0,y0,vx0,vy0,ax0,ay0,del_t,max_t,R)
% CS5320_const_acc - constant acceleration forward simulation
% On input:
%       x0 (float): initial x location
%       y0 (float): initial y location
%       vx0 (float): initial x speed
%       vy0 (float): initial y speed
%       ax0 (float): x acceleration
%       ay0 (float): y acceleration
%       del_t (float): time step
%       max_t (float): maximum time for simulation
%       R (6x6 array): covariance of process
% On output:
%       trace (kx4 array): state trace
%       trace(i,:): state vector at step i
% Call:
%       tr =
%       CS5320_const_acc(0,0,0,0,0,-9.8,0.1,2,[0.1,0.1;0.1,0.1;0,0]);
%       where,
%           R = eye(6,6); R(5:6,5:6) = 0;R = 0.0001*R
% Author:
%       SHantnu Kakkar
%       UU
%       Spring 2016
%
trace = [x0,y0,vx0,vy0,ax0,ay0];
CurrentState = [x0,y0,vx0,vy0,ax0,ay0];

times = [0:del_t:max_t];
num_steps = length(times)-1;
num_locs = length(CurrentState);

D= [1,0,del_t,0,0,0;...
    0,1,0,del_t,0,0;
    0,0,1,0,del_t,0;
    0,0,0,1,0,del_t;
    0,0,0,0,1,0;
    0,0,0,0,0,1];

for i = 1:num_steps
    CurrentState = CS5320_process_step(CurrentState',D,R);
    CurrentState = CurrentState';
    trace = [trace;CurrentState]
end
