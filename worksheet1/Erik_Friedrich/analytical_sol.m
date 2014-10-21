function [ p ] = analytical_sol( t )
%ANALYTICAL_SOL calculates the analytical solution 
% of dp/dt = (1-p/10)*p, which is
% p(t) = 10/(1+9 *e^(-t)).
% INPUT: 
%       t:          time t (can be a vector)
% OUTPUT:
%       p:          solution vector for all time steps of t

p = 10./(1+9 .*exp(-t));

end

