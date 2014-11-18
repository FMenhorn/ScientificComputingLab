function [ T_approx,frames] = gauss_seidel( b, N_x, N_y )
%GAUSS_SEIDEL Summary of this function goes here
%   Detailed explanation goes here

h_x = 1/(N_x+1);
h_y = 1/(N_y+1);
% N_x;
% N_y;
x = 0:h_x:1;
y = 0:h_y:1;
hx_min2= 1/h_x^2;
hy_min2= 1/h_y^2;
doubleneg_h_sum = -2*hx_min2-2*hy_min2;

% [X,Y] = meshgrid(x,y);

T_approx = zeros(N_y+2,N_x+2);
accuracy_limit = 10^(-4);
res = accuracy_limit+1;
figure;
frames = [];

counter=0;
while ( res > accuracy_limit)
    res = 0;
    for i = 2:N_y+1
%         top_values = T_approx(i+1,:);
%         bottom_values = T_approx(i-1,:);
%         right_values = [T_approx(i,2:(N_x+2)) 0];
%         true_values = b((1:N_x)+(i-2)*N_x);
%         
%         T_tmp = ([0 true_values' 0] - (bottom_values + top_values)*hy_min2 - right_values*hx_min2);
%        
        T_tmp = ([0 b((1:N_x)+(i-2)*N_x)' 0] - (T_approx(i+1,:) + T_approx(i-1,:))*hy_min2 - [T_approx(i,2:(N_x+2)) 0]*hx_min2);
        
        for j = 2:N_x+1
            T_approx(i,j) = (T_tmp(j)-T_approx(i,j-1)*hx_min2)/doubleneg_h_sum;
        end
    end
%     T_approx;
%     res_tmp = 0;
    %TODO RESIDUAL CALCULATION
    %HERE
    %NEW
%     counter = 1;
%     for i = 1:N_x*N_y
%         res_tmp = b(i) - 
%     end
    %OLD
%     residual_left =   T_approx(2:end-1,1:end-2);
%     residual_right =  T_approx(2:end-1,3:end  );
%     residual_top =    T_approx(3:end  ,2:end-1);
%     residual_bottom = T_approx(1:end-2,2:end-1);
%     residual_matrix = (T_approx(2:end-1,2:end-1)*doubleneg_h_sum + (residual_left + residual_right)*hx_min2 + (residual_bottom + residual_top) * hy_min2)';
    residual_matrix = (T_approx(2:end-1,2:end-1)*doubleneg_h_sum ...
        + (T_approx(2:end-1,1:end-2) + T_approx(2:end-1,3:end  ))*hx_min2 ...
        + (T_approx(3:end  ,2:end-1) + T_approx(1:end-2,2:end-1)) * hy_min2)';
    
%     residual_vector = b-residual_matrix(:);
%     res= sqrt(1/(N_x*N_y))*norm(residual_vector);
    res= sqrt(1/(N_x*N_y))*norm(b-residual_matrix(:));
    
%     for i = 2:N_x+1
%         for j = 2:N_y+1
%             left_value = T_approx(i,j-1)*hx_min2;
%             right_value = T_approx(i,j+1)*hx_min2;
%             top_value = T_approx(i+1,j)*hy_min2;
%             bottom_value = T_approx(i-1,j)*hy_min2;
%             this_value = T_approx(i,j) *doubleneg_h_sum;
%             res_tmp = res_tmp + (b((j-2)*N_x+i-1) - (left_value+right_value+top_value+bottom_value+this_value))^2;
%         end
%         %res = res + (b((j-2)*N_x+i-1) - res_tmp)^2;
%     end
        counter=counter+1;
        %res = sqrt(1/(N_x*N_y)*res_tmp);
    if (mod(counter,100) == 0)
%         res_tmp
        res
        %surf(X,Y,T_approx);
        %drawnow
    end
end

end

