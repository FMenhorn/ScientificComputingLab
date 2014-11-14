close all

N_x = 63;
N_y = 63;

A = gen_matrix(N_x,N_y);

A_sparse = sparse(A);

x = 0:1/(1+N_x):1;
y = 0:1/(1+N_y):1;

b = nan(N_x*N_y,1);
for i = 1:N_x
    for j = 1:N_y
        b((j-1)*N_x+i) = -2*pi^2*sin(pi*x(i+1))*sin(pi*(y(j+1)));
    end
end
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
[X,Y] = meshgrid(x,y);
figure;
plot_matrix = zeros(length(x),length(y));
x_full_re = reshape(x_full,sqrt(length(x_full)),sqrt(length(x_full)));
plot_matrix(2:end-1,2:end-1) = x_full_re;
surf(X,Y,plot_matrix);

figure;
x_sparse_re = reshape(x_sparse,sqrt(length(x_sparse)),sqrt(length(x_sparse)));
plot_matrix(2:end-1,2:end-1) = x_sparse_re;
surf(X,Y,plot_matrix);

figure;
surf(X,Y,x_gs);