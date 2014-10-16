function [ y ] = RungeKutta( f,y0,dt,t_end )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
len = t_end/dt;

y = [y0,zeros(1,len)];
for n = 1:len
    temp1 = f(y(n));
    temp2 = f(Euler(f,y(n),dt,2*dt));
    y(n+1) = y(n) + dt * (1/6) * (temp1 + 2*temp2 + 2*temp3 + temp4);
end

end

