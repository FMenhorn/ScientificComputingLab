%% Worksheet 1
% a) Use matlab to plot the function p(t) in a graph.

dt = 1;
t_end = 9;
t = 0:dt:t_end;
p = 10./(1+9.*exp(-t));

plot(t,p,'m-')
hold on
%% b)
%1)
diff_func = @(p)(1-(p/10))*p;
y0 = 1;
y = Euler(diff_func,y0,dt,t_end);

plot(t,y,'r-')
%2)
y = Heun(diff_func,y0,dt,t_end);
plot(t,y,'g-')

%3)

y = RungeKutta(diff_func,y0,dt,t_end)

plot(t,y,'b-')

