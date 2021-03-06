function [ T_next] = impl_euler_step( T_old, dt, N_x, N_y, accuracy_limit)
%IMPL_EULER_STEP approximates the PDE solution using an adapted
% Gauss-Seidel method from worksheet 3
%   INPUT:
%           T_old:          old/initial values of the grid points
%           dt:             time step size delta t
%           N_x:            Array of domain dimension in x direction
%           N_y:            Array of domain dimension in y direction
%           accuracy_limit: error limit on the resdiual to stop the
%                           Gauss-Seidel method
%   Output:
%           T_next:         result values after having applied one implicit
%                           Euler step
%
% Calculating updated values and residuals by summing up vectors and 
% matrices respectively, shifted one step in each direction. Faster than 
% explicit summing of each term in for-loops due to MatLab's optimisation
% procedures for vectors and matrices, but requires some temporary storage.

% h_x = 1/(N_x+1);
% h_y = 1/(N_y+1);

%precalculating for efficiency.
hx_min2= (N_x+1)^2;
hy_min2= (N_y+1)^2;
doubleneg_h_sum = -2*hx_min2-2*hy_min2;

%using initial guess = old values.
T_next = T_old;
%accuracy_limit = 10^(-4);
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
        %         
        %         T_tmp = (T_old(i,:) + dt*((bottom_values + top_values)*hy_min2 + right_values*hx_min2));
        T_tmp = (T_old(i,:) + (T_next(i+1,:) + T_next(i-1,:))*hy_min2*dt + [T_next(i,2:(N_x+2)) 0]*hx_min2*dt);
        
        %update x-values subsequently
        for j = 2:N_x+1
            T_next(i,j) = (T_tmp(j)+T_next(i,j-1)*hx_min2*dt)/(1-dt*doubleneg_h_sum);
        end
    end
    
    %Calculating residual. Equivalent readable code:
    %     residual_left =   T_approx(2:end-1,1:end-2);
    %     residual_right =  T_approx(2:end-1,3:end  );
    %     residual_top =    T_approx(3:end  ,2:end-1);
    %     residual_bottom = T_approx(1:end-2,2:end-1);
    %     residual_matrix = (T_approx(2:end-1,2:end-1)*(1-dt*doubleneg_h_sum) - (residual_left + residual_right)*hx_min2 - (residual_bottom + residual_top) * hy_min2)';

    %     residual_matrix = T_old-residual_matrix;
    %     res= sqrt(1/(N_x*N_y))*norm(residual_matrix(:));

    residual_matrix = T_old(2:end-1,2:end-1) - (T_next(2:end-1,2:end-1)*(1-dt*doubleneg_h_sum) ...
        - dt*((T_next(2:end-1,1:end-2) + T_next(2:end-1,3:end  ))*hx_min2 ...
        + (T_next(3:end  ,2:end-1) + T_next(1:end-2,2:end-1)) * hy_min2));

    %calculate residual using in-built 2-norm function, interpreting matrix
    %as a vector
    res= sqrt(1/(N_x*N_y))*norm(residual_matrix(:));
end

end

