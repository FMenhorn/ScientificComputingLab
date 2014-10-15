function [ y ] = Euler( f,y0,dt,t_end )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
len = t_end/dt

y = [y0,zeros(1,len)];

for n = 1:len
    y(n+1) = y(n) + dt*f(y(n));
end

end

