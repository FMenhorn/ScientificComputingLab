function [ y ] = RKEuler( temp,y0,dt,t_end )
%EULER this function returns an euler approximation of a function
%   this approximation of a function is based on the function f
%   starting value y0 timesteps dt and the end time t_end

len = t_end/dt; %number of steps in range

y = [y0,zeros(1,len)];

for n = 1:len
    y(n+1) = y(n) + dt*temp;
end

end

