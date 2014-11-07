function [ result_arr ] = error_summation( func, diff_func, analytical_sol_func, delta_t, t_end, y_0 )
%ERROR_SUMMATION computes an array containing different error measures
% INPUT: 
%       func:         numerical solver function that returns a vector of function values for timesteps 0-t_end with spacing delta_t for the function dy/dt (y) = diff_func(y), starting at y=y_0 at t=0
%                     (input: t_end, delta_t, y_0, diff_func, output: vector of y-values with length t_end/delta_t)
%       diff_func:    function for evaluating the differential at y dy/dt (y) = diff_func(y)
%       analytical_sol_func: exact solution to the ODE, y(t) = analytical_sol_func(t)
%       delta_t:      array of timestep lengths used in the numerical integrations, for which different errors are calculated
%       t_end:        calculation end time
%       y_0:          initial value for y at t=0
% OUTPUT:
%       result_arr:   table with different error measurements, each column corresponding to the respective delta_t value
%                     result_arr(1,:): value of delta_t in that column
%                     result_arr(2,:): least-squares error compared with analytical soln
%                     result_arr(3,i): factor of error size reduction compared with last timestep [=result_arr(2,i-1)/result_arr(2,i)]
%                       
    %initialize variable and result
    length_dt = length(delta_t);
    result_arr = nan(3,length_dt);
    
    %calculate reference function values 
    time_steps = 0:delta_t(1):t_end;
    result_analytic = analytical_sol_func(time_steps);
    result_reference = func(t_end,delta_t(1),y_0,diff_func);
    result_arr(1,1) = delta_t(1);
    result_arr(2,1) = error_calc(t_end,delta_t(1), result_reference, result_analytic);
    
    %loop over delta_t values
    for i = 2:length_dt        
        result_tmp = func(t_end,delta_t(i),y_0,diff_func);
        result_arr(1,i) = delta_t(i);
  
        delta_t_factor = delta_t(i)/delta_t(1); % assume factor is integer. Can correct otherwise. 
                                                %TODO: assert this!
        %extract reference elements
        result_analytic_temp = result_analytic(1:delta_t_factor:end);
        result_ref_tmp = result_reference(1:delta_t_factor:end);
        
        %compute errors
        result_arr(2,i) = error_calc(t_end, delta_t(i), result_tmp, result_analytic_temp);

        %compute error reduction factors
        result_arr(3,i) = result_arr(2,i)/result_arr(2,i-1);
    end

end

