function [ T_approx,frames] = gauss_seidel( b, N_x, N_y )
%GAUSS_SEIDEL Summary of this function goes here
%   Detailed explanation goes here

h_x = 1/(N_x+1);
h_y = 1/(N_y+1);
N_x;
N_y;
x = 0:h_x:1;
y = 0:h_y:1;
hx_min2= 1/h_x^2;
hy_min2= 1/h_y^2;
doubneg_h_sum = -2*hx_min2-2*hy_min2;

[X,Y] = meshgrid(x,y);

T_approx = zeros(N_x+2,N_y+2);
accuracy_limit = 10^(-4);
res = accuracy_limit+1;
figure;
frames = [];

counter=0;
while ( res > accuracy_limit)
    res = 0;
    for i = 2:N_x+1
        for j = 2:N_y+1
            left_value = T_approx(i,j-1)*hx_min2;
            right_value = T_approx(i,j+1)*hx_min2;
            top_value = T_approx(i+1,j)*hy_min2;
            bottom_value = T_approx(i-1,j)*hy_min2;
            T_approx(i,j) = (b((j-2)*N_x+i-1)-left_value-right_value-top_value-bottom_value)/doubneg_h_sum;
        end
    end
    T_approx;
    res_tmp = 0;
    %TODO RESIDUAL CALCULATION
    %HERE
    %NEW
%     counter = 1;
%     for i = 1:N_x*N_y
%         res_tmp = b(i) - 
%     end
    %OLD
    for i = 2:N_x+1
        for j = 2:N_y+1
            left_value = T_approx(i,j-1)*hx_min2;
            right_value = T_approx(i,j+1)*hx_min2;
            top_value = T_approx(i+1,j)*hy_min2;
            bottom_value = T_approx(i-1,j)*hy_min2;
            this_value = T_approx(i,j) *doubneg_h_sum;
            res_tmp = res_tmp + (b((j-2)*N_x+i-1) - (left_value+right_value+top_value+bottom_value+this_value))^2;
        end
        %res = res + (b((j-2)*N_x+i-1) - res_tmp)^2;
    end
        counter=counter+1;
        res = sqrt(1/(N_x*N_y)*res_tmp);
    if (mod(counter,100) == 0)
        res_tmp
        surf(X,Y,T_approx);
        drawnow
    end
end

end

