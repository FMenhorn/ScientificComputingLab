function [handle] = plot_results(fig_handle_surf, N_x,N_y, result)
%PLOT_RESULTS plots the result in a surface and contour plot
%   INPUT:
%           fig_handle_surf:    figure handle to the surf subplot
%           N_x:                Array of domain dimension in x direction
%           N_y:                Array of domain dimension in y direction
%           result:             result to plot
%   OUTPUT:
%           handle:             handle to figure

xx = 0:1/(1+N_x):1;
yy = 0:1/(1+N_y):1;
[X,Y] = meshgrid(xx,yy);

handle = surf(fig_handle_surf,X,Y,result);   

end

