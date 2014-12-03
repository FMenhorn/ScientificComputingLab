function [ ] = plotter(handle,cur_N_xy,T_res,t,cur_dt,length_top,subplot_counter )
%PLOTTER Summary of this function goes here
%   Detailed explanation goes here

    surf_handle = plot_results(handle,cur_N_xy,cur_N_xy,T_res);
    
    if (length_top == 1)
        left = 1;
    else
        left = mod(subplot_counter,length_top);
    end
    top = subplot_counter <= length_top; 
    plot_labeler(handle,cur_dt,cur_N_xy,cur_N_xy,left,top)
    

end

