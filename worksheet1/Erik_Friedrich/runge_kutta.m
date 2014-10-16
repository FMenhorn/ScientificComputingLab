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

% initialize result vector
y_res = nan(size(time_steps));
y_res(1) = y_0;

% Runge Kutta method
for i = 1:length(time_steps)-1
    
    y_1 = diff_func(y_res(i));
    p_2 = y_res(i) + expl_euler_step(delta_t/2,y_1);
    y_2 = diff_func(p_2);
    p_3 = y_res(i) + expl_euler_step(delta_t/2,y_2);
    y_3 = diff_func(p_3);
    p_4 = y_res(i) + expl_euler_step(delta_t,y_3);
    y_4 = diff_func(p_4);
    %y_2 = diff_func(y_res(i)+expl_euler_step(y_res(i)+delta_t/2 * y_1,delta_t/2,diff_func));
    %y_3 = diff_func(y_res(i)+expl_euler_step(y_res(i)+delta_t/2 * y_2,delta_t/2,diff_func));
    %y_4 = diff_func(y_res(i)+expl_euler_step(y_res(i)+delta_t * y_3,delta_t,diff_func));
%     y_2 = diff_func(y_res(i)+expl_euler_step(y_1,delta_t/2,diff_func));
%     y_3 = diff_func(y_res(i)+expl_euler_step(y_2,delta_t/2,diff_func));
%     y_4 = diff_func(y_res(i)+expl_euler_step(y_3,delta_t,diff_func));
    
   y_res(i+1) = y_res(i) + ...
                delta_t*(1/6)*(y_1 + ... 
                               2*y_2 + ...
                               2*y_3 + ...
                               y_4);
end

end

