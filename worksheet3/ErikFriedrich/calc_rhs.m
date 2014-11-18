function [ b ] = calc_rhs( N_x,N_y,func )
%CALC_RHS calculates the righthand vector of the PDE using the function func,
%   on a rectangular grid on (0,1)², (without endpoints 0 and 1.)
x = 0:1/(1+N_x):1;
y = 0:1/(1+N_y):1;

b = nan(N_x*N_y,1);
for j = 1:N_y
    for i = 1:N_x
        b((j-1)*N_x+i) = func(x(i+1),y(j+1));
    end
end
end

