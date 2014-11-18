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

N_x = 63;
N_y = 63;
an_sol = @(x,y) sin(pi*x)*sin(pi*y);
func_b = @(x,y) -2*pi^2*sin(pi*x)*sin(pi*y);

A = gen_matrix(N_x,N_y);

A_sparse = sparse(A);

xx = 0:1/(1+N_x):1;
yy = 0:1/(1+N_y):1;

b = calc_rhs(N_x,N_y,func_b);

tic
x_full = A\b;
toc
tic
x_sparse = A_sparse\b;
toc
tic
x_gs = gauss_seidel(b,N_x,N_y);
toc

%Plotting
[X,Y] = meshgrid(xx,yy);
figure;
plot_matrix = zeros(length(xx),length(yy));
x_full_re = reshape(x_full,sqrt(length(x_full)),sqrt(length(x_full)));
plot_matrix(2:end-1,2:end-1) = x_full_re;
surf(X,Y,plot_matrix);

figure;
x_sparse_re = reshape(x_sparse,sqrt(length(x_sparse)),sqrt(length(x_sparse)));
plot_matrix(2:end-1,2:end-1) = x_sparse_re;
surf(X,Y,plot_matrix);

figure;
surf(X,Y,x_gs);