function [ stability_arr ] = stability_calc( func, diff_func, delta_t, input_t_end, y_0, stability_accuracy_limit )
%STABILITY_CALC computes the stability of each method by comparing the
%difference between the max and min value in the last stability_time_steps
%to the stability_accuracy_limit. If abs(max-min) <
%stability_accuracy_limit, the method for the specific delta_t is
%considered stable
% INPUT: 
%       func:           numerical solver function that returns a vector of function values for timesteps 0-t_end with spacing delta_t for the function dy/dt (y) = diff_func(y), starting at y=y_0 at t=0
%                       (input: t_end, delta_t, y_0, diff_func, output: vector of y-values with length t_end/delta_t)
%       diff_func:      function for evaluating the differential at y dy/dt (y) = diff_func(y)
%       delta_t:        array of timestep lengths used in the numerical integrations, for which different errors are calculated
%       input_t_end:    suggestion of a t_end time. If it's to short, another
%                       another t_end is used, see line 32
%       y_0:            initial value for y at t=0
%       stability_accuracy_limit: limit to consider a method as stable
% OUTPUT:
%       stability_arr:  array holding the stability values for each timestep
%                       in delta_t. true = stable, false = unstable
%                       
    % minimum number of timesteps to use for stability
    min_calc_timesteps = 100;
    min_stable_timesteps = 10;
    min_stable_time_fraction = 0.1;

    %initialize variable and result
    length_dt = length(delta_t);
    stability_arr = nan(1,length_dt);
    max_dt = max(delta_t);
    t_end = max(input_t_end,max_dt*min_calc_timesteps); %if t_end is too short, calculate different t_end
    if(t_end ~= input_t_end)
        disp(['STABILITY_CALC: input_t_end=' num2str(input_t_end) ' too short. Use t_end=' num2str(t_end)]);
    end
    stability_time = max(t_end*min_stable_time_fraction,min_stable_timesteps*max_dt);
    
    %loop over delta_t values
    for i = 1:length_dt        
        result_tmp = func(t_end,delta_t(i),y_0,diff_func);

        stability_timesteps = 1 + stability_time / delta_t(i);
        max_value = max(result_tmp((end-stability_timesteps):end));
        min_value = min(result_tmp((end-stability_timesteps):end));

        if (abs(max_value-min_value) < stability_accuracy_limit)
            stability_arr (i) = true;
        else 
            stability_arr (i) = false;
        end    
%% Use to plot a specific approximation in the last stability_timesteps 
%  to qualitatively specify if it could be stable
%         max_value-min_value
%         if delta_t(i)==0.25
%         plot(1:stability_timesteps+1,result_tmp((end-stability_timesteps):end));
%         end
%%
    end

end

