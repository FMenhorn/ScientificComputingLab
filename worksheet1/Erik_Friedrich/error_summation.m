function [ result_arr ] = error_summation( func, diff_func, delta_t, t_end, y_0 )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    length_dt = length(delta_t);
    result_arr = nan(4,length_dt);
    
    for i = 1:length_dt
        time_steps = 0:delta_t(i):t_end;
        analytic_tmp = analytical_sol(time_steps);

        result_tmp = func(t_end,delta_t(i),y_0,diff_func);
        result_arr(1,i) = delta_t(i);
        result_arr(2,i) = error_calc(delta_t(i), result_tmp, analytic_tmp);

        factor = delta_t(i)/delta_t(1);
        if(i == 1)
            result_best = result_tmp;
        end
        result_best_tmp = zeros(1,length(result_tmp));
        k = 1;
        for j = 1:factor:length(result_best)
            result_best_tmp(k) = result_best(j);
            k = k+1;
        end
        result_arr(4,i) = error_calc(delta_t(i), result_tmp, result_best_tmp);
    end

    for i = 2:length_dt
        result_arr(3,i) = result_arr(2,i)/result_arr(2,i-1);
    end

end

