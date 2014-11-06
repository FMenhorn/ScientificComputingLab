clear all
close all
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
analytical_func = @analytical_sol;

% initial value
y_0 = 20;

%%
% variables for time discretization
t_end = 5; %t_end stays the same
delta_t = [1/32 1/16 1/8 1/4 1/2 1]; %delta_t is now an array
%delta_t = [1/2 1]; %delta_t is now an array
delta_t = sort(delta_t); %to make sure that smallest delta_t is last
length_dt = length(delta_t);

%% a) Plot of Analytical Solution
figure;
analytic_time = 0:0.001:t_end;
plot(analytic_time,analytical_func(analytic_time),'black');
xlabel('time t');
ylabel('population p');
title('Analytic solution');

%%

%% c)

% ODE settings (stay the same as before)
% initial value
diff_diff_func = @(p) -7*p./5; % p''

%Solver settings
accuracy_limit = 0.0001;
iteration_limit = 1000;

% Implicit Euler
func = @(t_end,delta_t,y_0, diff_func) impl_euler( t_end,delta_t,y_0, diff_func, diff_diff_func, accuracy_limit,iteration_limit);
result_calc( 'Impl_Euler' ,func, diff_func, analytical_func, delta_t, t_end, y_0);

% Adams-Moulton
func = @(t_end,delta_t,y_0, diff_func) adams_moulton( t_end,delta_t,y_0, diff_func, diff_diff_func, accuracy_limit,iteration_limit);
result_calc( 'Adams-Moulton' ,func, diff_func, analytical_func, delta_t, t_end, y_0);

% Adams-Moulton linearisation 1
func = @(t_end,delta_t,y_0, diff_func) adams_moulton_lin1( t_end,delta_t,y_0, diff_func, diff_diff_func, accuracy_limit,iteration_limit);
result_calc( 'Adams-Moulton-lin1' ,func, diff_func, analytical_func, delta_t, t_end, y_0);

% Adams-Moulton linearisation 2
func = @(t_end,delta_t,y_0, diff_func) adams_moulton_lin2( t_end,delta_t,y_0, diff_func, diff_diff_func, accuracy_limit,iteration_limit);
result_calc( 'Adams-Moulton-lin2' ,func, diff_func, analytical_func, delta_t, t_end, y_0);

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
euler_arr = error_summation(func,diff_func, analytical_func, delta_t,t_end,y_0);

% Heun
func = @heun;
heun_arr = error_summation(func, diff_func, analytical_func, delta_t,t_end,y_0);

% Implicit Euler
func = @(t_end,delta_t,y_0, diff_func) impl_euler( t_end,delta_t,y_0, diff_func, diff_diff_func, accuracy_limit,iteration_limit);
impl_euler_arr = error_summation(func,diff_func, analytical_func, delta_t,t_end,y_0);

% Adams-Moulton
func = @(t_end,delta_t,y_0, diff_func) adams_moulton( t_end,delta_t,y_0, diff_func, diff_diff_func, accuracy_limit,iteration_limit);
adams_moulton_arr = error_summation(func, diff_func, analytical_func, delta_t,t_end,y_0);

% Adams-Moulton-lin1
func = @(t_end,delta_t,y_0, diff_func) adams_moulton_lin1( t_end,delta_t,y_0, diff_func, diff_diff_func, accuracy_limit,iteration_limit);
adams_moulton_lin1_arr = error_summation(func, diff_func, analytical_func, delta_t, t_end, y_0);

% Adams-Moulton-lin2
func = @(t_end,delta_t,y_0, diff_func) adams_moulton_lin2( t_end,delta_t,y_0, diff_func, diff_diff_func, accuracy_limit,iteration_limit);
adams_moulton_lin2_arr = error_summation(func, diff_func, analytical_func, delta_t, t_end, y_0);
%%

%% i) Stability

% parameters2
stability_accuracy_limit = accuracy_limit * sqrt(8);

% Explicit Euler
func = @expl_euler;
stability_tmp = stability_calc(func,diff_func, delta_t,t_end,y_0, stability_accuracy_limit);
euler_arr = [euler_arr ; stability_tmp];

% Heun
func = @heun;
stability_tmp = stability_calc(func,diff_func, delta_t,t_end,y_0, stability_accuracy_limit);
heun_arr = [heun_arr ; stability_tmp];

% Implicit Euler
func = @(t_end,delta_t,y_0, diff_func) impl_euler( t_end,delta_t,y_0, diff_func, diff_diff_func, accuracy_limit,iteration_limit);
stability_tmp = stability_calc(func,diff_func, delta_t,t_end,y_0, stability_accuracy_limit);
impl_euler_arr = [impl_euler_arr ; stability_tmp];

% Adams-Moulton
func = @(t_end,delta_t,y_0, diff_func) adams_moulton( t_end,delta_t,y_0, diff_func, diff_diff_func, accuracy_limit,iteration_limit);
stability_tmp = stability_calc(func,diff_func, delta_t,t_end,y_0, stability_accuracy_limit);
adams_moulton_arr = [adams_moulton_arr ; stability_tmp];

% Adams-Moulton-lin1
func = @(t_end,delta_t,y_0, diff_func) adams_moulton_lin1( t_end,delta_t,y_0, diff_func, diff_diff_func, accuracy_limit,iteration_limit);
stability_tmp = stability_calc(func,diff_func, delta_t,t_end,y_0, stability_accuracy_limit);
adams_moulton_lin1_arr = [adams_moulton_lin1_arr ; stability_tmp];

% Adams-Moulton-lin2
func = @(t_end,delta_t,y_0, diff_func) adams_moulton_lin2( t_end,delta_t,y_0, diff_func, diff_diff_func, accuracy_limit,iteration_limit);
stability_tmp = stability_calc(func,diff_func, delta_t,t_end,y_0, stability_accuracy_limit);
adams_moulton_lin2_arr = [adams_moulton_lin2_arr ; stability_tmp];
%%

%% Output

% needed for output. Length of delta_t can be variable
column_arr = [];
for i = 1:length_dt
    column_arr =[column_arr '_ '];
end

if (exist('printmat') == 2)
    row_names = 'delta_t (c)abs_error (d)error_factor (e)stability';
    printmat(euler_arr, 'Results of Euler-Method', row_names , column_arr)
    printmat(heun_arr, 'Results of Heun-Method', row_names, column_arr)
    printmat(impl_euler_arr, 'Results of Impl-Euler-Method', row_names , column_arr)
    printmat(adams_moulton_arr, 'Results of Adams-Moulton-Method', row_names, column_arr)
    printmat(adams_moulton_lin1_arr, 'Results of Adams-Moulton-Method-Lin1', row_names, column_arr)
    printmat(adams_moulton_lin2_arr, 'Results of Adams-Moulton-Method-Lin2', row_names, column_arr)
else
    disp('Here follows the result of the calculations for each method.')
    disp('Row 1 of each table contains delta-t - values,')
    disp('row 2 contains the calculated error vs analytical solution,')
    disp('row 3 contains the factor by which the error is reduced compared')
    disp('with the delta-t - value in the column to the left,')
    disp('and row 4 contains the error vs. the leftmost delta-t - value.')
    
    
    euler_arr
    heun_arr
    impl_euler_arr
    adams_moulton_arr
    adams_moulton_lin1_arr
    adams_moulton_lin2_arr
end
%%
    