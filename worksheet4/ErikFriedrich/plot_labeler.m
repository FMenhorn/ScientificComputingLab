function [ ] = plot_labeler( fig_handle,top_string,N_x,N_y,left,top )
%PLOT_LABELER labels the rows and columns of the figure given to the method
% in fig_handle
% INPUT:
%           fig_handle: handle to figure
%           top_string: string to be used for title
%           N_x:        number of inner grid points in x
%           N_y:        number of inner grid points in y
%           left:       boolean to check if figure is in the left most row
%                       of the subplotfigure
%           top:        boolean to check if figure is in the top row of the
%                       subplotfigure

if top==1
    title(fig_handle,top_string);
end
if left==1
    zlabel(fig_handle,['(N_x,N_y) = (' num2str(N_x) ',' num2str(N_y) ')']);
end

end

