%Worksheet 1
% In this first worksheet, the ode 
%                   dp/dt = (1-p/10) * p (1) 
% is examined. It describes the dynamics of the population of a 
% certain species. The initial condition is given as 
%                   p(0) = 1 (2)
% and the analytical solution is
%                   p(t) = 10/(1+9*exp(-t)) (3)
% The purpose of this worksheet is to examine properties of different
% numerical methods (namely Euler, Heun and Runge-Kutta) with the help 
% of this ode.
% The tasks are as follows:
% a) plot function (3) in a graph
% b) Implement the following methods for a general function dy/dt = f(y)
%    for the initial condition y(0) = y_0:
%       1) explicit Euler
%       2) method of Heun
%       3) Runge-Kutta method (fourth order)
% c) Compute approximations for equation (1) with initial condition (2)
%    end time t_end = 5 and time steps delta_t = 1,1/2,1/4,1/8. For each
%    case compute the approximation error
%                   error = sqrt(dt/5 sum_k (p_k - p_{k,exact})^2)) (4)
%    where p_k represents the approximation and p_{k,exact} is the exact
%    solution at t = delta_t * k;
% d) For each error determine the factor by which the error is reduced if
%    the step size delta_t is halved. (5)
% e) Since in general the analytic solution is not know, compute the
%    approximated error
%                   error_approximated = 
%                               sqrt(dt/5 sum_k (p_k - p_{k,best})^2)) (6)
%    where again p_k denotes the approximation and p_{k,best} represents 
%    the best solution computed with the smallest time step delta_t.
% Show the result in tables at the end.
format long

%% variables for time discretization
t_end = 5;
delta_t = 1;
time_steps = 0:delta_t:t_end;
%% 

%% ODE settings
% initial value
y_0 = 1;
%%

%% function for calculating the differential 
diff_func = @(p) (1-p./10).*p;
%%

%% a) Plot of Analytical Solution
figure;
analytic_time = 0:0.001:t_end;
plot(analytic_time,analytical_sol(analytic_time),'black');
hold on;
%%

%% b)
% 1) Explicit Euler
euler_res = expl_euler(t_end,delta_t,y_0,diff_func);

%figure;
plot(time_steps,euler_res,'g');

% 2) Method of Heun
heun_res = heun(t_end,delta_t,y_0,diff_func);

%figure;
plot(time_steps,heun_res,'b');

% 3) Runge-Kutta
runge_kutta_res = runge_kutta(t_end,delta_t,y_0,diff_func);

%figure;
plot(time_steps,runge_kutta_res,'r');
legend('AnSol', 'ExplEul','Heun','RungeKutta','Location','southeast');
title(['Comparison of ode solution methods for dt = ' num2str(delta_t)]);
xlabel('time t in seconds');
ylabel('y');   
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

% initiate arrays with similar structure to worksheet table
% first row: different delta_t
% second row: error (see (4))
% third row: error reduced factor (see (5))
% fourth row: error_approximated (see (6))
% example:
% euler_arr = nan(4,length_dt);
% heun_arr = nan(4,length_dt);
% runge_kutta_arr = nan(4,length_dt);

% needed for output. Length of delta_t can be variable
column_arr = [];
for i = 1:length_dt
    column_arr =[column_arr '_ '];
end

analytic_func = @analytical_sol;
    
% Explicit Euler
func = @expl_euler;
euler_arr = error_summation(func,diff_func, analytic_func, delta_t,t_end,y_0);

% Heun
func = @heun;
heun_arr = error_summation(func, diff_func, analytic_func, delta_t,t_end,y_0);

% Runge-Kutta
func = @runge_kutta;
runge_kutta_arr = error_summation(func, diff_func, analytic_func, delta_t, t_end, y_0);

%Output
if (exist('printmat') == 2)
    printmat(euler_arr, 'Results of Euler-Method', 'delta_t absolute_error error_factor approx_error', column_arr)
    printmat(heun_arr, 'Results of Heun-Method', 'delta_t absolute_error error_factor approx_error', column_arr)
    printmat(runge_kutta_arr, 'Results of Runge-Kutta-Method', 'delta_t absolute_error error_factor approx_error', column_arr)
else
    euler_arr
    heun_arr
    runge_kutta_arr
end


    