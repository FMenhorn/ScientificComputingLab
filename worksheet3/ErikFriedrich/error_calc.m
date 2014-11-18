function [ error ] = error_calc( N_x, N_y, an_sol_func,approx_solver,func_rhs )
%ERROR_CALC Function for calculating the error in the numerical PDE soln
%   INPUT:
%       N_x, N_y: number of inside points used in the x-y solution mesh
%       an_sol_func: function of two variables that is used as exact
%       reference
%       approx_solver: solver to be evaluated
%       func_rhs: function generating the right hand side of the PDE
%       del²(T)=b 
%   OUTPUT:
%       error: the mean-square standard deviation error given by 
%       √( 1/(N_x*N_y) * Σ_i Σ_j (T_1(i,j) - T_2(i,j))^2)

%initiate RHS
rhs = func_rhs( N_x,N_y);
%calculate approximate
T_gs = approx_solver(rhs,N_x,N_y);
%calculate reference
T_ansol = analytical_solution(N_x,N_y,an_sol_func);
%calculate final error using the inbuilt norm function
error = sqrt(1/(N_x*N_y))*norm(T_gs(:)-T_ansol(:));

end

