function [ delta_p ] = expl_euler_step( delta_t, differential )
%EXPL_EULER calculates one explicit euler step
%   INPUT: 
%       delta_t:        timestep length
%       differential:   value of differential for which the change in
%       function should be calculated
%   OUTPUT:
%       delta_p:        change in function value from the euler step
%   
delta_p = delta_t * differential;

end

