close all;
clear all;

%%WORKSHEET4
% TODO: HEAD!


t_end = [1/8 2/8 3/8 4/8];
dt = [1/64 1/128 1/256 1/512 1/1024 1/2048 1/4096];
N_xy = [3 7 15 31];
fig_array = [];

for t_end_index = 1:length(t_end)
    fig_array = [fig_array figure('name',['Explicit Euler with t_end ' num2str(t_end(t_end_index))],...
        'renderer','painters',...
        'units','normalized', ...
        'outerposition',[0 0 1 1], ...
        'PaperPositionMode','auto')];
%     suplabel(['(N_x,N_y)=' num2str(N_xy)],'y');
end

subplot_counter = 1;

for cur_N_xy = N_xy
    for cur_dt = dt
        T_res = zeros(cur_N_xy+2,cur_N_xy+2);
        T_res(2:end-1,2:end-1) = ones(cur_N_xy,cur_N_xy);
        t_start = 0;
        for t_end_index = 1:length(t_end)
            figure(fig_array(t_end_index))

            T_res = expl_euler(T_res,t_start,t_end(t_end_index),cur_dt,cur_N_xy,cur_N_xy);

            handle = subplot(length(N_xy),length(dt),subplot_counter);
            plotter(handle,cur_N_xy,T_res,t_end(t_end_index),['δt = 2^{' num2str(log2(cur_dt)) '}' ],length(dt),subplot_counter);
            %             plot_results(handle,cur_N_xy,cur_N_xy,T_res);
            %             left = mod(subplot_counter,length(dt));
            %             top = subplot_counter <= length(dt);
            %             plot_labeler(handle,cur_dt,cur_N_xy,cur_N_xy,left,top)

            t_start = t_end(t_end_index);
        end
        subplot_counter = subplot_counter +1;
    end

end
fig_labeler(fig_array, t_end);

t_end = [1/8 2/8 3/8 4/8];
dt = [1/64];
N_xy = [3 7 15 31];

fig_array = figure('name','Implicit Euler with dt = 1/64');
set(fig_array,'renderer','painters');
set(fig_array,'units','normalized','outerposition',[0 0 1 1]);
set(fig_array,'PaperPositionMode','auto')

accuracy_limit = 1e-6;

subplot_counter = 1;

for cur_N_xy = N_xy
    for cur_dt = dt
        T_res = zeros(cur_N_xy+2,cur_N_xy+2);
        T_res(2:end-1,2:end-1) = ones(cur_N_xy,cur_N_xy);
        t_start = 0;
        for t_end_index = 1:length(t_end)
            
            
            T_res = impl_euler(T_res,t_start,t_end(t_end_index),cur_dt,cur_N_xy,cur_N_xy,accuracy_limit);
            
            handle = subplot(length(N_xy),length(t_end),subplot_counter);
            plotter(handle,cur_N_xy,T_res,t_end(t_end_index),['t = ' num2str(t_end(t_end_index))],length(t_end),subplot_counter);
            %             plot_results(handle,cur_N_xy,cur_N_xy,T_res);
            %             left = mod(subplot_counter,length(dt));
            %             top = subplot_counter <= length(dt);
            %             plot_labeler(handle,cur_dt,cur_N_xy,cur_N_xy,left,top)
            
            t_start = t_end(t_end_index);
            subplot_counter = subplot_counter +1;
        end
    end
    
end
suplabel('Implicit Euler with δt = 1/64','t');
saveas(fig_array,'plots/ImplicitEuler.png');
