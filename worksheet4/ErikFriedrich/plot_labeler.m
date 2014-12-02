function [ ] = plot_labeler( fig_handle,dt,N_x,N_y,left,top )
%PLOT_LABELER Summary of this function goes here
%   Detailed explanation goes here

if top==1
    title(fig_handle,[' dt= 2^{' num2str(log2(dt)) '}']);
end
if left==1
    zlabel(fig_handle,['(N_x,N_y) = (' num2str(N_x) ',' num2str(N_y) ')']);
end

end

