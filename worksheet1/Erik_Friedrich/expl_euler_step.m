function [ delta_p ] = expl_euler_step( p_old,delta_t, func )
%EXPL_EULER
%   Calculates one explicit euler step
delta_p = delta_t * func(p_old);

end

