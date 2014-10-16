function [ delta_p ] = expl_euler_step( delta_t, differentiate )
%EXPL_EULER
%   Calculates one explicit euler step
delta_p = delta_t * differentiate;

end

