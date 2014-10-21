function [ y_res ] = runge_kutta( t_end,delta_t,y_0,diff_func )
%RUNGE_KUTTA solves the ode using the Runge Kutta method
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

% Runge Kutta method
% y_k describes the point y_k
% ydiff_k describes the derivative obtained from diff_func(y_k) 
for i = 1:length(time_steps)-1
    
    ydiff_1 = diff_func(y_res(i));
    y_2 = y_res(i) + expl_euler_step(delta_t/2,ydiff_1);
    ydiff_2 = diff_func(y_2);
    y_3 = y_res(i) + expl_euler_step(delta_t/2,ydiff_2);
    ydiff_3 = diff_func(y_3);
    y_4 = y_res(i) + expl_euler_step(delta_t,ydiff_3);
    ydiff_4 = diff_func(y_4);
    
    y_res(i+1) = y_res(i) + ...
                delta_t*(1/6)*(ydiff_1 + ... 
                               2*ydiff_2 + ...
                               2*ydiff_3 + ...
                               ydiff_4);
end

end

