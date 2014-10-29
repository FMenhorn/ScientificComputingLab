function [ p ] = analytical_sol( t )
%ANALYTICAL_SOL calculates the analytical solution 
% of dp/dt = (1-p/10)*p, which is
% p(t) = 10/(1+9 *e^(-t)).
% INPUT: 
%       t:          time t (can be a vector)
% OUTPUT:
%       p:          result vector for p values for each time step in t

p = 200./(20-10 .*exp(-7*t));

end

