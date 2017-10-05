function trace = CS5320_const_vel(x0,y0,vx0,vy0,del_t,max_t,R)
% CS5320_const_vel - constant velocity forward simulation
% On input:
%       x0 (float): initial x location
%       y0 (float): initial y location
%       vx0 (float): x speed
%       vy0 (float): y speed
%       del_t (float): time step
%       max_t (float): maximum time for simulation
%       R (4x4 array): covariance of process
% On output:
%       trace (kx4 array): state trace
%       trace(i,:): state vector at step i
% Call:
%       tr = CS5320_const_vel(0,0,1,0,0.1,2,R);
%       where,
%           R = 0.0001*eye(4,4); R(3:4,3:4) = 0;
% Author:
%       Shantnu Kakkar
%       UU
%       Spring 2016
%
trace = [x0,y0,vx0,vy0];
CurrentState = [x0,y0,vx0,vy0];

times = [0:del_t:max_t];
num_steps = length(times)-1;
num_locs = length(CurrentState);

Di = [1,0,del_t,0;...
    0,1,0,del_t;
    0,0,1,0;
    0,0,0,1];

for i = 1:num_steps
    CurrentState = CS5320_process_step(CurrentState',D,R);
    CurrentState = CurrentState';
    trace = [trace;CurrentState];
end

