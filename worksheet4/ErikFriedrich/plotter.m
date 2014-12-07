function [ ] = plotter(handle,cur_N_xy,T_res,cur_dt,length_top,subplot_counter )
%PLOTTER plots the figure given in handle
% INPUT:
%           handle:             handle to the figure
%           cur_N_xy:           N_x and N_y values, i.e. number of inner grid
%                               points in x and y, N_x=N_y
%           T_res:              result to be plotted
%           cur_dt:             time step size delta t
%           length_top:         width of subplotfigure (number of columns)
%           subplot_counter:    subplot position

    % surf_handle could be used for other purposes, here obsolete
    surf_handle = plot_results(handle,cur_N_xy,cur_N_xy,T_res);
    
    % set boolean whether plot is the leftmost in the row or not, for
    % labels
    if (length_top == 1)
        left = 1;
    else
        left = mod(subplot_counter,length_top);
    end
    % same for top
    top = subplot_counter <= length_top; 
    plot_labeler(handle,cur_dt,cur_N_xy,cur_N_xy,left,top)
    
end

