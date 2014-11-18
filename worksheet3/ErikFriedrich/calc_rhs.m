function [ b ] = calc_rhs( N_x,N_y,func )
%CALC_RHS calculates the righthandside of the PDE using the function func
%   Detailed explanation goes here
x = 0:1/(1+N_x):1;
y = 0:1/(1+N_y):1;

b = nan(N_x*N_y,1);
for i = 1:N_x
    for j = 1:N_y
        b((j-1)*N_x+i) = func(x(i+1),y(j+1));
    end
end
end

