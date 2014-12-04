function [ T_next ] = expl_euler_step( T_cur,dt,hx_min2,hy_min2 )
%EXPL_EULER calculates one explicit euler step
%   INPUT: 
%       T_cur:      current values in each grid point
%       dt:         time step size delta t
%       hx_min2:    1/(hx^2) with hx being meshwidth in x
%       hy_min2:    1/(hy^2) with hy being meshwidth in y
%   OUTPUT:
%       T_next:     values after one explicit Euler step
    
    T_next = zeros(size(T_cur));
    T_next(2:end-1,2:end-1) = T_cur(2:end-1,2:end-1) + dt * (T_cur(2:end-1,2:end-1)*(hx_min2 + hy_min2)*(-2) ...
        + (T_cur(2:end-1,1:end-2) + T_cur(2:end-1,3:end  ))*hx_min2 ...
        + (T_cur(3:end  ,2:end-1) + T_cur(1:end-2,2:end-1)) * hy_min2);

end

