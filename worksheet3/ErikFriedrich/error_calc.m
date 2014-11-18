function [ error ] = error_calc( N_x, N_y, an_sol,approx_solver,func_rhs )
%ERROR_CALC Summary of this function goes here
%   Detailed explanation goes here

N_x
N_y

rhs = func_rhs( N_x,N_y);
T_gs = approx_solver(rhs,N_x,N_y);

T_ansol = analytical_solution(N_x,N_y,an_sol);

error = sqrt(1/(N_x*N_y)*(sum(sum((T_gs-T_ansol)^2))));

end

