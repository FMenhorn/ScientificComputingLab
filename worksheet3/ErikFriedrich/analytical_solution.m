function [ analytical_solution ] = analytical_solution( N_x,N_y,analytic_func )
%ANALYTICAL_SOLUTION calculates the analytical solution of the PDE
%   INPUT:
%           N_x: Array of domain dimension in x direction
%           N_y: Array of domain dimension in y direction
%           analytic_func: analytic solution function handle
%   Output:
%           analytic solution: analytic solution for each grid point
%           (xx(i),yy(j)) in the unit domain ]0,1[²
xx = 0:1/(1+N_x):1;
yy = 0:1/(1+N_y):1;
analytical_solution = nan(N_x+2,N_y+2);

for i = 1:length(xx)
    for j = 1:length(yy)
        analytical_solution(i,j) = analytic_func(xx(i),yy(j));
    end
end

end

