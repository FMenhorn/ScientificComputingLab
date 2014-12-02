close all;
clear all;

%%WORKSHEET4
% TODO: HEAD!


t_end = [1/8 2/8 3/8 4/8];
dt = [1/64 1/128 1/256 1/512 1/1024 1/2048 1/4096];
N_xy = [3 7 15 31];
for t_end_index = 1:length(t_end)
    figure('name',['Explicit Euler with t_end ' num2str(t_end(t_end_index))]);
%     suplabel(['(N_x,N_y)=' num2str(N_xy)],'y');
    set(gcf,'renderer','painters');
    subplot_counter = 1;
    for cur_N_xy = N_xy
        for cur_dt = dt

            T_start = zeros(cur_N_xy+2,cur_N_xy+2);
            T_start(2:end-1,2:end-1) = ones(cur_N_xy,cur_N_xy);
            
            T_res = expl_euler(T_start,0,t_end(t_end_index),cur_dt,cur_N_xy,cur_N_xy);
            
            handle = subplot(length(N_xy),length(dt),subplot_counter);
            plotter(handle,'png',cur_N_xy,T_res,t_end(t_end_index),cur_dt,length(dt),subplot_counter);
%             plot_results(handle,cur_N_xy,cur_N_xy,T_res);
%             left = mod(subplot_counter,length(dt));
%             top = subplot_counter <= length(dt); 
%             plot_labeler(handle,cur_dt,cur_N_xy,cur_N_xy,left,top)
            
            
            subplot_counter = subplot_counter +1;
        end
    end
    
    suplabel(['Explicit Euler with t_{end}= ' num2str(t_end(t_end_index))],'t');
end
