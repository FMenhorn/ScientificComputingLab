function [ error_arr ] = error_summation( N_x,N_y, an_sol, approx_solver, func_rhs )
%ERROR_SUMMATION calculates the error of the PDE solver approximation
% to the analytical solution
%   INPUT:
%           N_x: Array of domain dimension in x direction
%           N_y: Array of domain dimension in y direction
%           an_sol: analytical solution for the problem
%           approx_solver: function handle holding the pde solver used to
%                          solve for the approximate solution (e.g. Gauss-Seidel)
%           func_rhs: function to calculate the rhs b of the System Ax=b
%   Output:
%           error_arr: Array holding the errors and reduction factor compared
%                  to the analytical solution

Nx_len = length(N_x);
Ny_len = length(N_y);

if (Nx_len ~= Ny_len)
    error('Error_summation: Length of N_x array unequal to N_y array. There is something wrong!')
end

error_arr = nan(2,Nx_len);

for i = 1:Nx_len
        error_arr(1,i) = error_calc(N_x(i),N_y(i),an_sol,approx_solver,func_rhs);
        if(i~=1)
            error_arr(2,i) = error_arr(1,i-1)/error_arr(1,i);
        end
end

end

