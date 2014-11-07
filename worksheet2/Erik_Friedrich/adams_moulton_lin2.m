function [ y_res ] = adams_moulton_lin2( t_end,delta_t,y_0, diff_func, diff_diff_func, accuracy_limit,iteration_limit )
%ADAMS-MOULTON-Lin2 solves the ode using the implicit Adams-Moulton method
% using the linearisation 2 as described in the worksheet.
%(second order)
% INPUT:
%       t_end:  End time
%       delta_t: time step size delta_t
%       y_0:    Inital value at t=0
%       diff_func: differential as function of y: dy/dt = diff_func(y)
%       diff_diff_func: (dummy) dy'/dy_(n+1), differential of the ODE expression
%       for y', not used here (instead hardcoded for specific linearisation) but
%       kept for interface consistency
%       accuracy_limit: stopping criterion for newton solver
%       iteration_limit: number of maximal iterations in newton solve
% OUTPUT:
%       y_res: result vector for y values for each time step from 0:t_end

% variables for time discretization
time_steps = 0:delta_t:t_end;

% initialize result vector and starting value
y_res = nan(size(time_steps));
y_res(1) = y_0;

% expression whose root is found at next y-value
expression = @(y, y_next) ...
    (y_next - y - delta_t/2 * (diff_func(y)+ 7*(1-y/10)*y_next));
% derivative to be used in newton-raphson root finding
diff_expression = @(y,y_next) ...
    (1 - delta_t/2 * 7*(1-y/10));

%Adams-Moulton-lin2 integration
for i = 1:(length(time_steps)-1)
    
    %find location of next y-value using newton-raphson root finding
    expression_temp = @(y_next) expression(y_res(i), y_next); %using current value of y
    diff_expr_temp = @(y_next) diff_expression(y_res(i),y_next);
    
    [y_res(i+1),iteration_steps] = newton_solver(expression_temp,diff_expr_temp,y_res(i),accuracy_limit,iteration_limit);
    
    % display warning and break for undetermined cases    
    if iteration_steps == iteration_limit
        disp(['In Adamas-Moulton-Lin2, the newton solver took too long for delta_t: ' num2str(delta_t)]);
        disp(['At timestep: ' num2str(i)]);
        break;
    end
    
end

end

