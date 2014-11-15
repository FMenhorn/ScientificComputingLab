function [handle] = result_calc(  methodname ,func, diff_func, analytical_sol_func, delta_t, t_end, y_0)
%RESULT_CALC computes and plots the numerical ODE solution for different delta_t
% INPUT: 
%       methodname:   identifying name for plots and messages
%       func:         numerical solver function that returns a vector of function values for timesteps 0-t_end with spacing delta_t for the function dy/dt (y) = diff_func(y), starting at y=y_0 at t=0
%                     (input: t_end, delta_t, y_0, diff_func, output: vector of y-values with length t_end/delta_t)
%       diff_func:    function for evaluating the differential at y dy/dt (y) = diff_func(y)
%       analytical_sol_func: exact solution to the ODE, y(t) = analytical_sol_func(t)
%       delta_t:      array of timestep lengths used in the numerical integrations
%       t_end:        calculation end time
%       y_0:          initial value for y at t=0
% OUTPUT:
%       handle:       plot handle for modifying plot

% initialize variable and result
length_dt = length(delta_t);

% create figure
handle = figure;
% create colormap
cmap = lines(length_dt+1);
% plot analytic solution
xvals = linspace(0,t_end);
plot(xvals, analytical_sol_func(xvals),'Color',cmap(length_dt+1,:));
hold on;

% loop over delta_t values to calculate the results for each delta_t and 
% plot it
for i = 1:length_dt        
    result_tmp = func(t_end,delta_t(i),y_0, diff_func);
    plot(0:delta_t(i):t_end,result_tmp,'Color',cmap(i,:));
end

% create and set the string used in the legend and set its location in the 
% plot
delta_t_string = '';
for i = 1:length_dt
    delta_t_string = [delta_t_string ; strread(['dt=' num2str(delta_t(i))],'%s')];
end
legend_string = [ 'analytical' ; delta_t_string];
legend(legend_string,'Location','northeast');

% set label and title
xlabel('time t');
ylabel('population p');
xlim([0 5])
ylim([0 20]);
title([ 'Comparing solutions for different delta t for ' methodname]);

end

