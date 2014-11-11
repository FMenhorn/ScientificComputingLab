function [ flag ] = StabilityCheck( p,y,limit )
%STABILITYCHECK implements a simple stability check
%   StabilityCheck takes into account 2 criteria upon which this function
%   decides, whether the approximating method is stable or not.
%   1) It computes the absolute difference of the analytical and
%   approximating method and checks, whether this is smaller than some
%   predefined accuracy limit in order to see, whether it converges to the
%   analytical solution in t_end
%   2) In order to account for oscillations, the two last absolute
%   differences are compared.
%   Returns 1 for stable aprox. and 0 for instable aprox.
absDif1 = abs(p(length(p))-y(length(y)));
absDif2 = abs(p(length(p)-1)-y(length(y)-1));
flag = absDif1 < limit && absDif1 - absDif2 < limit;

end

