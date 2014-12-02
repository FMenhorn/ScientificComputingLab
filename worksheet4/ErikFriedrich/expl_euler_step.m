function [ T_next ] = expl_euler_step( T_cur,dt,hx_min2,hy_min2 )
%EXPL_EULER_STEP Summary of this function goes here
%   Detailed explanation goes here
    
    T_next = zeros(size(T_cur));
    T_next(2:end-1,2:end-1) = T_cur(2:end-1,2:end-1) + dt * (T_cur(2:end-1,2:end-1)*(hx_min2 + hy_min2)*(-2) ...
        + (T_cur(2:end-1,1:end-2) + T_cur(2:end-1,3:end  ))*hx_min2 ...
        + (T_cur(3:end  ,2:end-1) + T_cur(1:end-2,2:end-1)) * hy_min2);

end

