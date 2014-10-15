function [ y_res ] = heun( t_end,delta_t,y_0, diff_func )
%HEUN Summary of this function goes here
%   Detailed explanation goes here

% variables for time discretization
time_steps = 0:delta_t:t_end;

y_res = nan(size(time_steps));
y_res(1) = y_0;

for i = 1:length(time_steps)-1
    y_res(i+1) = y_res(i) + ...
                 delta_t*(1/2)*(diff_func(y_res(i))+ ... 
                                diff_func(y_res(i)+ ...
                                          expl_euler_step(y_res(i),delta_t,diff_func)));
end

end

