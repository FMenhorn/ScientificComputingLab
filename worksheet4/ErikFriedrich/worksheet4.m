close all;
clear all;

%%WORKSHEET4
% This worksheet treats the 2D-instationary heat equation
%                   T_t = T_xx + T_xx                       (1)
% on the unit square ]0,1[^2, using the two dimensional coordinates x,y and
% Dirichlet boundary conditions.
%       T(x,y,t) = 0 forall (x,y) in d]0,1[^2, t in ]0,inf[
% and
%           T(x,y,0) = 1 forall (x,y) in ]0,1[^2
% As in worksheet 3, finite differences are used to spatially discretize.
% The exercises are the following:
%   a) Determine lim(t->inf) T(x,y,t)
%   b) Implement an explicit Euler step for time discretization
%   c) Plot the solution for varying t_end, N_x/N_y and dt
%   d) Implement an implicit Euler, solve the linear system of equations
%   with an adapted Gauss-Seidel solver from worksheet 3
%   e) Plot the solutions for dt=1/64 and varying t_end.


%% a)

% We assume convergence, thus the solution converges to zero proven for
% example by separation of variables to find a solution, which under the
% given circumstances can be shown to be unique.:
%                   lim(t->inf) T(x,y,t) = 0

%%

%% b) and c)
t_end = [1/8 2/8 3/8 4/8];
T_correct = nan(4,65,65);
for cur_N_xy = 63
    for cur_dt = 1/(2^14)
        T_res = zeros(cur_N_xy+2,cur_N_xy+2);
        T_res(2:end-1,2:end-1) = ones(cur_N_xy,cur_N_xy);
        t_start = 0;
        for t_end_index = 1:length(t_end)
            %figure(fig_array(t_end_index))

            T_res = expl_euler(T_res,t_start,t_end(t_end_index),cur_dt,cur_N_xy,cur_N_xy);

            %handle = subplot(length(N_xy),length(dt),subplot_counter);
            %plotter(handle,cur_N_xy,T_res,['dt = 2^{' num2str(log2(cur_dt)) '}' ],length(dt),subplot_counter);

            t_start = t_end(t_end_index);
            T_correct(t_end_index,:,:) = T_res;
        end

       % subplot_counter = subplot_counter +1;
    end
end

% Starting parameters as given in worksheet
t_end = [1/8 2/8 3/8 4/8];
dt = [1/64 1/128 1/256 1/512];
N_xy = [3 7 15 31];
error_val = nan(4,length(dt),length(N_xy));

% Initialize the figures used for the subplots and initialize
% subplot_counter which gives the position of the current subplot
fig_array = [];
% for t_end_index = 1:length(t_end)
%     fig_array = [fig_array figure('name',['Explicit Euler with t_end ' num2str(t_end(t_end_index))],...
%         'renderer','painters',...
%         'units','normalized', ...
%         'outerposition',[0 0 1 1], ...
%         'PaperPositionMode','auto')];
% %     suplabel(['(N_x,N_y)=' num2str(N_xy)],'y');
% end
subplot_counter = 1;

% Start solving (1) using explicit Euler for different gridsizes N_xy
% (N_x=N_y), different dt and different t_end, receiving the result in
% T_res and plotting it in plotter.
% To save computation time, we do not start the computation always from
% zero, but from the previous t_end value, i.e. t_start(i) = t_end(i-1),
% since dt(i) = dt(i-1) and N_xy(i) = N_xy(i-1)
i_N = 1;
%i_dt = 1;
h_ref = 1/64;
for cur_N_xy = N_xy
    i_dt = 1;
    for cur_dt = dt
        T_res = zeros(cur_N_xy+2,cur_N_xy+2);
        T_res(2:end-1,2:end-1) = ones(cur_N_xy,cur_N_xy);
        t_start = 0;
        for t_end_index = 1:length(t_end)
            %figure(fig_array(t_end_index))

            T_res = expl_euler(T_res,t_start,t_end(t_end_index),cur_dt,cur_N_xy,cur_N_xy);

            %handle = subplot(length(N_xy),length(dt),subplot_counter);
            %plotter(handle,cur_N_xy,T_res,['dt = 2^{' num2str(log2(cur_dt)) '}' ],length(dt),subplot_counter);

            t_start = t_end(t_end_index);
            
            h = 1/(cur_N_xy+1);
            h_ratio = h/h_ref;
            
            size(T_res(2:end-1,2:end-1))
            size(T_correct(t_end_index,2:h_ratio:(end-h_ratio-1),2:h_ratio:(end-h_ratio-1)))
            T_tmp = nan(cur_N_xy,cur_N_xy);
            T_tmp(:,:) = T_correct(t_end_index,2:h_ratio:(end-h_ratio-1),2:h_ratio:(end-h_ratio-1));
            size(T_tmp)
            error_matrix = T_res(2:end-1,2:end-1) - T_tmp(:,:);
            
            error_val(t_end_index,i_dt,i_N) = norm(error_matrix(:));
        end
        subplot_counter = subplot_counter +1;
        i_dt = 1 + i_dt;
    end
    i_N = i_N +1;
end
column_label =[];
for i = 1:16
    column_label = [column_label '(' num2str(i) ',' num2str(i) ') '];
end
tmp = nan(4,4);
for i = 1:4
tmp(:,:) = error_val(i,:,:);
printmat(tmp,'error',column_label,column_label);
end
return
%fig_labeler(fig_array, t_end);
%%

%% d) and e)

% Starting parameters as given in worksheet
t_end = [1/8 2/8 3/8 4/8];
dt = [1/64];
N_xy = [3 7 15 31];

% Initialize the figures used for the subplots and initialize
% subplot_counter which gives the position of the current subplot
fig_array = figure('name','Implicit Euler with dt = 1/64');
set(fig_array,'renderer','painters');
set(fig_array,'units','normalized','outerposition',[0 0 1 1]);
set(fig_array,'PaperPositionMode','auto');
subplot_counter = 1;

% accuray_limit used in Gauss-Seidel solver (in impl_euler_step)
accuracy_limit = 1e-6;

% Start solving (1) using implicit Euler for different gridsizes N_xy
% (N_x=N_y), different dt and different t_end, receiving the result in
% T_res and plotting it in plotter. In impl_euler, the resulting linear
% system of equations in each time step is solved with an adapted
% Gauss-Seidel (in impl_euler_step) scheme from worksheet 3
% Again to save computation time, we do not start the computation always from
% zero, but from the previous t_end value, i.e. t_start(i) = t_end(i-1),
% since dt(i) = dt(i-1) and N_xy(i) = N_xy(i-1)
for cur_N_xy = N_xy
    for cur_dt = dt
        T_res = zeros(cur_N_xy+2,cur_N_xy+2);
        T_res(2:end-1,2:end-1) = ones(cur_N_xy,cur_N_xy);
        t_start = 0;
        for t_end_index = 1:length(t_end)
            
            T_res = impl_euler(T_res,t_start,t_end(t_end_index),cur_dt,cur_N_xy,cur_N_xy,accuracy_limit);
            
            handle = subplot(length(N_xy),length(t_end),subplot_counter);
            %plotter(handle,cur_N_xy,T_res,['t = ' num2str(t_end(t_end_index))],length(t_end),subplot_counter);
            
            t_start = t_end(t_end_index);
            subplot_counter = subplot_counter +1;
        end
    end
    
end
%suplabel('Implicit Euler with dt = 1/64','t');
%saveas(fig_array,'plots/ImplicitEuler.png');
