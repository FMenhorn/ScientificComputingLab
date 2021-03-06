close all
clear all

%% WORKSHEET3
% This worksheet switches to partial differential equations (PDE).
% We work on the two-dimensional stationary heat equation:
%               T_xx + T_yy = -2*pi²*sin(pi*x)*sin(pi*y)
% on the unit square ]0;1[² with the temperatur T(x,y), the two-dimensional
% coordinates x and y, and the homogeneous Dirichlet boundary condition 
%               T(x,y) = 0 forall (x,y) in \partial ]0;1[²
% The boundary value problem has the anallytical solution
%               T(x,y) = sin(pi*x)*sin(pi*y)


an_sol = @(x,y) sin(pi*x)*sin(pi*y);
func_pde = @(x,y) -2*pi^2*sin(pi*x)*sin(pi*y);

%% Runtime and storage analysis and plotting
disp('###Runtime and Storage Analysis###')
disp('Matrix sizes')
N_x = [7,15,31,63]
N_y = [7,15,31,63]

% Get labels later used for plotting
column_labels_runtime = column_labels(N_x,N_y);

gs_accuracy_limit = 1e-4;

Nx_len = length(N_x);
Ny_len = length(N_y);

if (Nx_len ~= Ny_len)
    error('Worksheet3 RuntimeAndStorage: Length of N_x array unequal to N_y array. There is something wrong!')
end

rtstorage_T_direct = nan(2,Nx_len);
rtstorage_T_sparse = nan(2,Nx_len);
rtstorage_T_gs = nan(2,Nx_len);

figure_direct = figure('name', 'Direct solver using full matrix A');
figure_sparse = figure('name', 'Direct solver using sparse matrix A');
figure_gs = figure('name','Gauss-Seidel Method');

for i = 1:Nx_len
    %generate equation system matrices
    A = gen_matrix(N_x(i),N_y(i));

    A_sparse = sparse(A);

    % create solution grid
    xx = 0:1/(1+N_x(i)):1;
    yy = 0:1/(1+N_y(i)):1;

    %generate right-hand side of PDE (endpoints exclusive)
    b = calc_rhs(N_x(i),N_y(i),func_pde);

    %use different solvers and measure runtime.
    runtime_direct = tic;
    x_full = A\b;
    rtstorage_T_direct(1,i) = toc(runtime_direct);
    
    runtime_sparse = tic;
    x_sparse = A_sparse\b;
    rtstorage_T_sparse(1,i) = toc(runtime_sparse);
    
    runtime_gs = tic;
    [x_gs, storage_gs] = gauss_seidel(b,N_x(i),N_y(i),gs_accuracy_limit);
    rtstorage_T_gs(1,i) = toc(runtime_gs);
    
    %save the storage used to the rtstorage array
    rtstorage_T_direct(2,i) = get_storage(A)/1024;
    rtstorage_T_sparse(2,i) = get_storage(A_sparse)/1024;
    rtstorage_T_gs(2,i) =   storage_gs/1024;
    
    % Plotting in a subplot grid for each method
    plot_matrix = zeros(length(xx),length(yy));
    
    figure(figure_direct);
    direct_surf = subplot(2,Nx_len,i);
    direct_contour = subplot(2,Nx_len,i+Nx_len);
    x_full_re = reshape(x_full,sqrt(length(x_full)),sqrt(length(x_full)));
    plot_matrix(2:end-1,2:end-1) = x_full_re;
    plot_results('Direct-solver',direct_surf,direct_contour,N_x(i),N_y(i),plot_matrix);
    
    figure(figure_sparse);
    sparse_surf = subplot(2,Nx_len,i);
    sparse_contour = subplot(2,Nx_len,i+Nx_len);
    x_sparse_re = reshape(x_sparse,sqrt(length(x_sparse)),sqrt(length(x_sparse)));
    plot_matrix(2:end-1,2:end-1) = x_sparse_re;
    plot_results('Sparse-solver',sparse_surf,sparse_contour,N_x(i),N_y(i),plot_matrix);

    figure(figure_gs);
    gs_surf = subplot(2,Nx_len,i);
    gs_contour = subplot(2,Nx_len,i+Nx_len);
    plot_results('Gauss-Seidel',gs_surf,gs_contour,N_x(i),N_y(i),x_gs);
end

% using suplabel for labelling of subplots, courtesy of Ben Barrowes
figure(figure_direct);
suplabel('Contour and Surface plot','y');
suplabel('Direct solver using full matrix','t');
figure(figure_sparse);
suplabel('Contour and Surface plot','y');
suplabel('Direct solver using sparse matrix','t');
figure(figure_gs);
suplabel('Contour and Surface plot','y');
suplabel('Custom Gauss-Seidel solver','t');
%%

%% Error calculation
disp('###Error calculation###')
disp('Matrix sizes')
N_x = [7,15,31,63,127]
N_y = [7,15,31,63,127]

% Get labels later used for plotting
column_labels_error = column_labels(N_x,N_y);

Nx_len = length(N_x);
Ny_len = length(N_y);

if (Nx_len ~= Ny_len)
    error('Worksheet3 ErrorCalculation: Length of N_x array unequal to N_y array. There is something wrong!')
end

solver = @(bb, N_xx, N_yy) gauss_seidel(bb, N_xx, N_yy, gs_accuracy_limit);
func_rhs = @(N_xx,N_yy) calc_rhs(N_xx,N_yy,func_pde);
error_res = error_summation(N_x,N_y,an_sol,solver,func_rhs);

%%

%% Results
if (exist('printmat') == 2)
    row_labels = 'runtime(s) storage(kB)';
    printmat(rtstorage_T_direct, 'Runtime and Storage for direct solver', row_labels,column_labels_runtime);
    printmat(rtstorage_T_sparse, 'Runtime and Storage for direct sparse solver', row_labels,column_labels_runtime);
    printmat(rtstorage_T_gs, 'Runtime and Storage for Gauss-Seidel solver', row_labels,column_labels_runtime);
    row_labels = 'abs_error error_factor';
    printmat(error_res, 'Results of Gauss-Seidel', row_labels , column_labels_error)
else
    disp('Here follows the result of the Runtime calculation.')
    disp('Row 1 of each table contains the runtime in seconds.')
    disp('Row 2 of each table contains the storage needed in kilobytes.')
    disp('Runtime and Storage for direct solver:')
    disp(column_labels_runtime)
    disp(rtstorage_T_direct(1,:))
    disp(rtstorage_T_direct(2,:))
    disp('Runtime and Storage for direct sparse solver:')
    disp(column_labels_runtime)
    disp(rtstorage_T_sparse(1,:))
    disp(rtstorage_T_sparse(2,:))
    disp('Runtime and Storage for Gauss-Seidel solver:')
    disp(column_labels_runtime)
    disp(rtstorage_T_gs(1,:))
    disp(rtstorage_T_gs(2,:))
    
    disp('Here follows the result of the Error calculation')
    disp('Row 1 of each table contains number of grid points,')
    disp('row 2 contains the calculated error vs analytical solution,')
    disp('row 3 contains the factor by which the error is reduced compared')
    disp('with the previous calculation')

    disp(column_labels_error)
    disp(error_res)   
end
