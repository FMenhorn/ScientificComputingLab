function [ y ] = RungeKutta( f,y0,dt,t_end )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
len = t_end/dt;

y = [y0,zeros(1,len)];
for n = 1:len
    temp1 = f(y(n));
    %temp2 = f(RKEuler(temp1,y(n),dt/2,dt));
    %temp3 = f(RKEuler(temp2,y(n),dt/2,dt));
    %temp4 = f(RKEuler(temp3,y(n),dt,dt));
    temp2 = Euler(f,y0+(dt/2)*temp1,dt/2,dt);
    temp21 = f(temp2(2));
    temp3 = Euler(f,y0+(dt/2)*temp21,dt/2,dt);
    temp31 = f(temp3(2));
    temp4 = Euler(f,y0+dt*temp31,dt,dt);
    temp41 = f(temp4(2)); 
    y(n+1) = y(n) + dt * (1/6) * (temp1 + 2*temp21 + 2*temp31 + temp41);
end

end

