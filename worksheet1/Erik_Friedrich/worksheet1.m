%Worksheet 1

%% variables for time discretization
t_end = 9;
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
%title('Analytical Solution');
hold on;
%%

%% b)
% 1) Explicit Euler
euler_res = expl_euler(t_end,delta_t,y_0,diff_func);

%figure;
plot(time_steps,euler_res,'g');
%title('Explicit Euler');

% 2) Method of Heun
heun_res = heun(t_end,delta_t,y_0,diff_func);

%figure;
plot(time_steps,heun_res,'b');
%title('Method of Heun');

% 3) Runge-Kutta
runge_kutta_res = runge_kutta(t_end,delta_t,y_0,diff_func);

%figure;
plot(time_steps,runge_kutta_res,'r');
%title('Runge-Kutta');
legend('AnSol', 'ExplEul','Heun','RungeKutta','Location','southeast');
title(['Comparison of ode solution methods for dt = ' num2str(delta_t)]);
    