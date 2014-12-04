function [ ] = plotter(handle,cur_N_xy,T_res,cur_dt,length_top,subplot_counter )
%PLOTTER plots the figure given to him in handle
% INPUT:
%           handle:             handle to the figure
%           cur_N_xy:           N_x and N_y values, i.e. number of inner grid
%                               points in x and y, N_x=N_y
%           T_res:              result to be plotted
%           cur_dt:             time step size delta t
%           length_top:         width of subplotfigure (number of columns)
%           subplot_counter:    subplot position

    surf_handle = plot_results(handle,cur_N_xy,cur_N_xy,T_res);
    
    if (length_top == 1)
        left = 1;
    else
        left = mod(subplot_counter,length_top);
    end
    top = subplot_counter <= length_top; 
    plot_labeler(handle,cur_dt,cur_N_xy,cur_N_xy,left,top)
    
end

