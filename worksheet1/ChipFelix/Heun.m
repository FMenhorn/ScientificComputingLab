function [ y ] = Heun( f,y0,dt,t_end )
%HEUN The Heun function model is based on a similar concept as
%   the Euler model, but averages the slop for the function points n
%   and n+1.  This leads to a more percice result than with Heun
%   
len = t_end/dt; %the number of steps is calculated

y = [y0,zeros(1,len)]; % the result memory is allocated
for n = 1:len
     % a temporary value is calculated for the current Euler value
     % this value is based on previous Heun y result values
     % range for the calculation is limited to two steps for 
     % perfomance purposes
    temp = Euler(f,y(n),dt,dt); 
   
    %Average of both test point slopes
    y(n+1) = y(n) + dt * 0.5 * (f(y(n)) + f(temp(2)));
end

end

