%Worksheet 2
% In this first worksheet, the ode 
%                   dp/dt = 7*(1-p/10) * p (1) 
% is examined. It describes the dynamics of the population of a 
% certain species. The initial condition is given as 
%                   p(0) = 20 (2)
% and the analytical solution is
%                   p(t) = 200/(20-10*exp(-7t)) (3)
% The purpose of this worksheet is to examine properties of different...
format long

%% function for calculating the differential 
diff_func = @(p) 7*(1-p./10).*p;
%%

%% a) Plot of Analytical Solution
figure;
analytic_time = 0:0.001:t_end;
plot(analytic_time,analytical_sol(analytic_time),'black');

%%

%% b)
% variables for time discretization
t_end = 5; %t_end stays the same
delta_t = [1/32 1/16 1/8 1/4 1/2 1]; %delta_t is now an array
delta_t = sort(delta_t); %to make sure that smallest delta_t is last
length_dt = length(delta_t);

% ODE settings (stay the same as before)
% initial value
y_0 = 20;

analytic_func = @analytical_sol;
    
% Explicit Euler
func = @expl_euler;
result_calc('Euler', func,diff_func,analytic_func,delta_t,t_end,y_0);

% Heun
func = @heun;
result_calc('Heun', func,diff_func,analytic_func,delta_t,t_end,y_0);

return

% 1) Explicit Euler
euler_res = expl_euler(t_end,delta_t,y_0,diff_func);
plot(time_steps,euler_res,'g');

% 2) Method of Heun
heun_res = heun(t_end,delta_t,y_0,diff_func);
plot(time_steps,heun_res,'b');

% some plot properties
legend('AnSol', 'ExplEul','Heun','RungeKutta','Location','northwest');
title(['Comparison of ode solution methods for dt = ' num2str(delta_t)]);
xlabel('time t in seconds');
ylabel('population p');   
hold off;
return
%%

%% c)
% variables for time discretization
t_end = 5; %t_end stays the same
delta_t = [1/8 1/4 1/2 1]; %delta_t is now an array
delta_t = sort(delta_t); %to make sure that smallest delta_t is last
length_dt = length(delta_t);

% ODE settings (stay the same as before)
% initial value
y_0 = 1;

analytic_func = @analytical_sol;
    
% Explicit Euler
func = @expl_euler;
result_calc('Euler', func,diff_func,analytic_func,delta_t,t_end,y_0);

% Heun
func = @heun;
result_calc('Heun', func,diff_func,analytic_func,delta_t,t_end,y_0);

% Runge-Kutta
func = @runge_kutta;
result_calc('Runge-Kutta', func,diff_func,analytic_func,delta_t,t_end,y_0);
%%

%% d) and e)
% initiate arrays with similar structure to worksheet table
% first row: different delta_t
% second row: error (see (4))
% third row: error reduced factor (see (5))
% fourth row: error_approximated (see (6))
% example:
% euler_arr = nan(4,length_dt);
% heun_arr = nan(4,length_dt);
% runge_kutta_arr = nan(4,length_dt);

% Explicit Euler
func = @expl_euler;
euler_arr = error_summation(func,diff_func, analytic_func, delta_t,t_end,y_0);

% Heun
func = @heun;
heun_arr = error_summation(func, diff_func, analytic_func, delta_t,t_end,y_0);

% Runge-Kutta
func = @runge_kutta;
runge_kutta_arr = error_summation(func, diff_func, analytic_func, delta_t, t_end, y_0);
%%

%% Output

% needed for output. Length of delta_t can be variable
column_arr = [];
for i = 1:length_dt
    column_arr =[column_arr '_ '];
end

if (exist('printmat') == 2)
    row_names = 'delta_t (c)abs_error (d)error_factor (e)appr_error';
    printmat(euler_arr, 'Results of Euler-Method', row_names , column_arr)
    printmat(heun_arr, 'Results of Heun-Method', row_names, column_arr)
    printmat(runge_kutta_arr, 'Results of Runge-Kutta-Method', row_names, column_arr)
else
    disp('Here follows the result of the calculations for each method.')
    disp('Row 1 of each table contains delta-t - values,')
    disp('row 2 contains the calculated error vs analytical solution,')
    disp('row 3 contains the factor by which the error is reduced compared')
    disp('with the delta-t - value in the column to the left,')
    disp('and row 4 contains the error vs. the leftmost delta-t - value.')
    euler_arr
    heun_arr
    runge_kutta_arr
end
%%
    