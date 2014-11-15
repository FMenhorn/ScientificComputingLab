function [ error ] = error_calc( t_end, delta_t, y, y_exact )
%ERROR_CALC calculate the least-squares error between vectors y and y_exact which
%are calculated with timestep size of delta_t, thus weighing each interval
%with delta_t/t_end.
%   INPUT:
%           t_end: end time of the calculation
%           delta_t: timstep size for which y, y_exact are calculated
%           y, y_exact: vectors of same length containing calculated
%           function values at intervals of delta_t.
%
%   OUTPUT: 
%           error: the least-squares error sqrt (Δt/t_end * Σ (over i) (y_i -
%           y_exact_i)²  )

error = sqrt(delta_t/t_end * sum( (y-y_exact).^2));

end

