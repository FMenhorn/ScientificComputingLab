function [ T_approx] = gauss_seidel( b, N_x, N_y )
%GAUSS_SEIDEL approximates the PDE solution using the Gauss-Seidel method
%   INPUT:
%           b: array holding the rhs of the PDE
%           N_x: Array of domain dimension in x direction
%           N_y: Array of domain dimension in y direction
%   Output:
%           T_approx: Array holding the approximated result for each grid
%           point
% Calculating updated values and residuals by summing up vectors and 
% matrices respectively, shifted one step in each direction. Faster than 
% explicit summing of each term in for-loops due to MatLab's optimisation
% procedures for vectors and matrices, but requires some temporary storage.

h_x = 1/(N_x+1);
h_y = 1/(N_y+1);

%precalculating for efficiency.
hx_min2= 1/h_x^2;
hy_min2= 1/h_y^2;
doubleneg_h_sum = -2*hx_min2-2*hy_min2;

%using initial guess 0 for all entries in the solution matrix, and setting
%the boundary values (the outer values of the matrix) to 0. 
T_approx = zeros(N_y+2,N_x+2);
accuracy_limit = 10^(-4);
res = accuracy_limit+1;

%loop until the residual is small enough.
while ( res > accuracy_limit)
    
    % updating all the inner values of the matrix in a loop, using the
    % already calculated values and the boundary (stored in the outermost
    % rows/columns), one row<=>one set of x-values at a time.
    for i = 2:N_y+1
% equivalent readable code:
%         top_values = T_approx(i+1,:);
%         bottom_values = T_approx(i-1,:);
%         right_values = [T_approx(i,2:(N_x+2)) 0];
%         true_values = b((1:N_x)+(i-2)*N_x);
%         
%         T_tmp = ([0 true_values' 0] - (bottom_values + top_values)*hy_min2 - right_values*hx_min2);
        T_tmp = ([0 b((1:N_x)+(i-2)*N_x)' 0] - (T_approx(i+1,:) + T_approx(i-1,:))*hy_min2 - [T_approx(i,2:(N_x+2)) 0]*hx_min2);
        
        %update x-values subsequently
        for j = 2:N_x+1
            T_approx(i,j) = (T_tmp(j)-T_approx(i,j-1)*hx_min2)/doubleneg_h_sum;
        end
    end
% Calculating residual. Equivalent readable code:
%     residual_left =   T_approx(2:end-1,1:end-2);
%     residual_right =  T_approx(2:end-1,3:end  );
%     residual_top =    T_approx(3:end  ,2:end-1);
%     residual_bottom = T_approx(1:end-2,2:end-1);
%     residual_matrix = (T_approx(2:end-1,2:end-1)*doubleneg_h_sum + (residual_left + residual_right)*hx_min2 + (residual_bottom + residual_top) * hy_min2)';
    
%     residual_vector = b-residual_matrix(:);
%     res= sqrt(1/(N_x*N_y))*norm(residual_vector);

    residual_matrix = (T_approx(2:end-1,2:end-1)*doubleneg_h_sum ...
        + (T_approx(2:end-1,1:end-2) + T_approx(2:end-1,3:end  ))*hx_min2 ...
        + (T_approx(3:end  ,2:end-1) + T_approx(1:end-2,2:end-1)) * hy_min2)';

    res= sqrt(1/(N_x*N_y))*norm(b-residual_matrix(:));
end

end

