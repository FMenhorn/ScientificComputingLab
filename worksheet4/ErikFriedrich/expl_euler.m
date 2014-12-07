function [ T_end ] = expl_euler( T_start,t_start,t_end,dt,N_x,N_y )
%EXPL_EULER solves the ode using the explicit Euler method
% INPUT:
%       T_start:    initial value of the grid points
%       t_start:    start time
%       t_end:      end time
%       dt:         time step size delta t, assumed to divide time interval
%       N_x:        number of inner grid points in x
%       N_y:        number of inner grid points in y
% OUTPUT:
%       T_end:      result after applying Euler method

    hx_min2 = (N_x+1)^2;
    hy_min2 = (N_y+1)^2;
    no_time_steps = (t_end-t_start)/dt;
    T_cur = T_start;
    for i = 1:no_time_steps
        T_cur = expl_euler_step(T_cur,dt,hx_min2,hy_min2);
    end
    T_end = T_cur;
end

