function [ y_res ] = heun( t_end,delta_t,y_0, diff_func )
%HEUN solves the ode using the method of HEUN
% INPUT:
%       t_end:  End time
%       delta_t: time step size delta_t
%       y_0:    Inital value at t=0
%       diff_func: differential of y: dy/dt = diff_func(y)
% OUTPUT:
%       y_res: result vector for y values for each time step from 0:t_end

% variables for time discretization
time_steps = 0:delta_t:t_end;

% initialize result vector and starting value
y_res = nan(size(time_steps));
y_res(1) = y_0;

% method of Heun
for i = 1:length(time_steps)-1
    y_res(i+1) = y_res(i) + ...
                 delta_t*(1/2)*(diff_func(y_res(i))+ ... 
                                diff_func(y_res(i)+ ...
                                          expl_euler_step(delta_t,diff_func(y_res(i)))));
end

end

