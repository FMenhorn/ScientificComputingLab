function [ y_res ] = adams_moulton( t_end,delta_t,y_0, diff_func, diff_diff_func, accuracy_limit,iteration_limit )
%ADAMS-MOULTON solves the ode using the implicit Adams-Moulton method
%(second order)
% INPUT:
%       t_end:  End time
%       delta_t: time step size delta_t
%       y_0:    Inital value at t=0
%       diff_func: differential of y: dy/dt = diff_func(y)
%       diff_diff_func: dy'/dy_(n+1), differential of the ODE expression
%       for y', used in the newton iteration
%       accuracy_limit: stopping criterion for newton solver
%       iteration_limit: number of maximal iterations in newton solve
% OUTPUT:
%       y_res: result vector for y values for each time step from 0:t_end

% variables for time discretization
time_steps = 0:delta_t:t_end;

% initialize result vector and starting value
y_res = nan(size(time_steps));
y_res(1) = y_0;

expression = @(y, y_next) ...
    (y_next - y - delta_t/2 * (diff_func(y)+ diff_func(y_next)));
diff_expression = @(y_next) ...
    (1 - delta_t/2 * diff_diff_func(y_next));

%implicit Euler
for i = 1:(length(time_steps)-1)
    expression_temp = @(y_next) expression(y_res(i), y_next);   
    [y_res(i+1),iteration_steps] = newton_solver(expression_temp,diff_expression,y_res(i),accuracy_limit,iteration_limit);
    if iteration_steps == iteration_limit
        disp(['In Adamas-Moulton, the newton solver took too long for delta_t: ' num2str(delta_t)]);
        disp(['At timestep: ' num2str(i)]);
        break;
    end
end

end

