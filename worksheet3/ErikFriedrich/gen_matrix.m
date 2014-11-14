function [ A ] = gen_matrix( N_x, N_y )
%GEN_MATRIX Summary of this function goes here
%   Detailed explanation goes here

h_x = 1/(N_x+1)
h_y = 1/(N_y+1)

A = zeros(N_x*N_y);

for i = 1:N_x*N_y
    for j = 1:N_x*N_y
        if i==j
            A(i,j) = -2/h_x-2/h_y;
        end
        if (j == i-1 || j == i+1) && ((i-1) ~= 0 || (i+1) ~= N_y) 
            A(i,j) = 1/h_x;
        end
        if (j == i-N_x || j == i+N_x) && ((i-N_x) > 0 || (i+N_x) < N_y*N_x)
            A(i,j) = 1/h_y;
        end
    end
end

end

