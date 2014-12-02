function [ ] = plotter(handle,format,cur_N_xy,T_res,t,cur_dt,length_dt,subplot_counter )
%PLOTTER Summary of this function goes here
%   Detailed explanation goes here

    surf_handle = plot_results(handle,cur_N_xy,cur_N_xy,T_res);
    
    if (length_dt == 1)
        left = 1;
    else
        left = mod(subplot_counter,length_dt);
    end
    top = subplot_counter <= length_dt; 
    plot_labeler(handle,cur_dt,cur_N_xy,cur_N_xy,left,top)
    
    %mkdir('plots');
    name = ['plots/ExplicitEuler_dt=2^' num2str(log2(cur_dt)) '_Nxy=' num2str(cur_N_xy) '_t=' num2str(t) ];
    %saveas(surf_handle,name,format);
end

