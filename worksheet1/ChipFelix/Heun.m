function [ y ] = Heun( f,y0,dt,t_end )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
len = t_end/dt;

y = [y0,zeros(1,len)];
for n = 1:len
    temp = Euler(f,y(n),dt,dt);
    y(n+1) = y(n) + dt * 0.5 * (f(y(n)) + f(temp(2)));
end

end

