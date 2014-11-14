close all

N_x = 5;
N_y = 4;

A = gen_matrix(N_x,N_y)

A_sparse = sparse(A)

x = 0:1/(1+N_x):1
y = 0:1/(1+N_y):1

b = nan(N_x*N_y,1)

for i = 1:N_x
    for j = 1:N_y
        b((j-1)*N_x+i) = -2*pi^2*sin(pi*x(i+1))*sin(pi*(y(j+1)));
    end
end
tic
x_full = inv(A)*b
toc
tic
x_sparse = inv(A_sparse)*b
toc
tic
x_gs = gauss_seidel(b,N_x,N_y)
toc
b
%whos A
%whos A_sparse