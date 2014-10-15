function [ y ] = Euler( f,y0,dt,t_end )
%EULER this function returns an euler approximation of a function
%   this approximation of a function is based on the function f
%   starting value y0 timesteps dt and the end time t_end

len = t_end/dt; %number of steps in range

y = [y0,zeros(1,len)];  %memory allocation for result vector

for n = 1:len
   %sum of tangents from point n to n+1 from 0 until t_end 
   %this creates a rough approximation of a function based on it's
   %derivative
    y(n+1) = y(n) + dt*f(y(n));
end

end

