function [] = plotResults(method, fig_handle_surf,fig_handle_contour, N_x,N_y, result)
%PLOTRESULTS plots the result in a surface and contour plot
%   INPUT:
%           method: string holding type of method (used for the title)
%           fig_handle_surf: figure handle to the surf subplot
%           fig_handle_contour: figure handle to the contour subplot
%           N_x: Array of domain dimension in x direction
%           N_y: Array of domain dimension in y direction
%           result: result to plot

xx = 0:1/(1+N_x):1;
yy = 0:1/(1+N_y):1;
[X,Y] = meshgrid(xx,yy);

surf(fig_handle_surf,X,Y,result);   
title(fig_handle_surf,['(N_x,N_y) = (' num2str(N_x) ',' num2str(N_y) ')']);

contour(fig_handle_contour,X,Y,result);
%title(fig_handle_contour,['Contourplot for (N_x,N_y) = (' num2str(N_x) ',' num2str(N_y) ')']);

end

