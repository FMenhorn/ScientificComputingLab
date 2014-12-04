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
%   c) Plot the solution for different t_end, N_x/N_y and dt
%   d) Implement an implicit Euler, solve the linear system of equations
%   with an adapted Gauss-Seidel solver from worksheet 3
%   e) Plot the solutions for dt=1/64 and different t_end.


%%a)

% We assume convergence, thus the solution converges to zero:
%                   lim(t->inf) T(x,y,t) = 0

%%

%% b) and c)

% Given starting parameters
t_end = [1/8 2/8 3/8 4/8];
dt = [1/64 1/128 1/256 1/512 1/1024 1/2048 1/4096];
N_xy = [3 7 15 31];
fig_array = [];

% Initialize the figures used for the subplots and initialize
% subplot_counter which gives the position of the current subplot
for t_end_index = 1:length(t_end)
    fig_array = [fig_array figure('name',['Explicit Euler with t_end ' num2str(t_end(t_end_index))],...
        'renderer','painters',...
        'units','normalized', ...
        'outerposition',[0 0 1 1], ...
        'PaperPositionMode','auto')];
%     suplabel(['(N_x,N_y)=' num2str(N_xy)],'y');
end
subplot_counter = 1;

% Start solving (1) using explicit Euler for different gridsizes N_xy
% (N_x=N_y), different dt and different t_end, receiving the result in
% T_res and plotting it in plotter.
% To save computation time, we do not start the computation always from
% zero, but from the previous t_end value, i.e. t_start(i) = t_end(i-1),
% since dt(i) = dt(i-1) and N_xy(i) = N_xy(i-1)
for cur_N_xy = N_xy
    for cur_dt = dt
        T_res = zeros(cur_N_xy+2,cur_N_xy+2);
        T_res(2:end-1,2:end-1) = ones(cur_N_xy,cur_N_xy);
        t_start = 0;
        for t_end_index = 1:length(t_end)
            figure(fig_array(t_end_index))

            T_res = expl_euler(T_res,t_start,t_end(t_end_index),cur_dt,cur_N_xy,cur_N_xy);

            handle = subplot(length(N_xy),length(dt),subplot_counter);
            plotter(handle,cur_N_xy,T_res,t_end(t_end_index),['dt = 2^{' num2str(log2(cur_dt)) '}' ],length(dt),subplot_counter);

            t_start = t_end(t_end_index);
        end
        subplot_counter = subplot_counter +1;
    end

end
fig_labeler(fig_array, t_end);
%%

%% d) and e)

% Given starting parameters
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
            plotter(handle,cur_N_xy,T_res,t_end(t_end_index),['t = ' num2str(t_end(t_end_index))],length(t_end),subplot_counter);
            
            t_start = t_end(t_end_index);
            subplot_counter = subplot_counter +1;
        end
    end
    
end
suplabel('Implicit Euler with dt = 1/64','t');
saveas(fig_array,'plots/ImplicitEuler.png');
