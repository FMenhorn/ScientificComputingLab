function [ A ] = gen_matrix( N_x, N_y )
%GEN_MATRIX generates the matrix A as described in b)
%   INPUT:
%           N_x: Array of domain dimension in x direction
%           N_y: Array of domain dimension in y direction
%   Output:
%           A: matrix A as described in b)

h_x = 1/(N_x+1);
h_y = 1/(N_y+1);

% A = diag(ones(N_x*N_y,1))*(-2/h_x^2-2/h_y^2) ...
%    + (diag(ones(N_x*N_y-1,1),1) + diag(ones(N_x*N_y-1,1),-1))/h_x^2 ...
%    + (diag(ones(N_x*(N_y-1),1),N_x)+ diag(ones(N_x*(N_y-1),1),-N_x))/h_y^2

A = zeros(N_x*N_y);

for i = 1:N_x*N_y
    for j = 1:N_x*N_y
        if i==j
            A(i,j) = -2/h_x^2-2/h_y^2;
        end
        if ((j == i-1)&&(mod(j,N_y)) || (j == i+1) && mod(i,N_x)) 
            A(i,j) = 1/h_x^2;
        end
        if (j == i-N_x || j == i+N_x) && ((i-N_x) > 0 || (i+N_x) < N_y*N_x)
            A(i,j) = 1/h_y^2;
        end
    end
end

end

