function [ handle] = result_calc(  methodname ,func, diff_func, analytic_sol_func, delta_t, t_end, y_0 )
%RESULT_CALC computes an array containing the result for different delta_t
%  and plots it
% INPUT: 
%       func:         numerical solver function that returns a vector of function values for timesteps 0-t_end with spacing delta_t for the function dy/dt (y) = diff_func(y), starting at y=y_0 at t=0
%                     (input: t_end, delta_t, y_0, diff_func, output: vector of y-values with length t_end/delta_t)
%       diff_func:    function for evaluating the differential at y dy/dt (y) = diff_func(y)
%       analytical_sol_func: exact solution to the ODE, y(t) = analytic_sol_func(t)
%       delta_t:      array of timestep lengths used in the numerical integrations, for which different errors are calculated
%       t_end:        calculation end time
%       y_0:          initial value for y at t=0
% OUTPUT:
%       result_arr:   table with different error measurements, each column corresponding to the respective delta_t value
%                     result_arr(1,:): value of delta_t in that column
%                     result_arr(2,:): least-squares error compared with analytical soln
%                     result_arr(3,i): factor of error size reduction compared with last timestep [=result_arr(2,i-1)/result_arr(2,i)]
%                     result_arr(4,:): least-squares error compared with the solution using timestep size delta_t(1)
% 

% initialize variable and result
length_dt = length(delta_t);
result_arr = nan(4,length_dt);

% calculate reference function values 
time_steps = 0:delta_t(1):t_end;
result_analytic = analytic_sol_func(time_steps);
result_reference = func(t_end,delta_t(1),y_0,diff_func);

% create figure
handle = figure;
% create colormap
cmap = lines(length_dt+1);
% plot analytic solution
plot(0:0.001:t_end, analytic_sol_func(0:0.001:t_end),'Color',cmap(length_dt+1,:));
hold on;
% plot solution for smallest delta_t (which is stored in delta_t(1))
plot(time_steps,result_reference,'Color',cmap(1,:))

% loop over delta_t values to calculate the results for each delta_t and 
% plot it
for i = 2:length_dt        
    result_tmp = func(t_end,delta_t(i),y_0,diff_func);
    plot(0:delta_t(i):t_end,result_tmp,'Color',cmap(i,:));
end

% create and set the string used in the legend and set its location in the 
% plot
delta_t_string = '';
for i = 1:length_dt
    delta_t_string = [delta_t_string ; strread(['dt=' num2str(delta_t(i))],'%s')];
end
legend_string = [ 'analytical' ; delta_t_string];
legend(legend_string,'Location','northwest');

% set label and title
xlabel('time t in seconds');
ylabel('population p');
title([ 'Comparing solutions for different delta t for ' methodname]);

end

