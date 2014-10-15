function [ p ] = analytical_sol( t )
%ANALYTICAL_SOL 
% Calculates the analytical solution 
% of dp/dt = (1-p/10)*p, which is
% p(t) = 10/(1+9 *exp ^(-t)).

p = 10/(1+9 *exp ^(-t));

end

