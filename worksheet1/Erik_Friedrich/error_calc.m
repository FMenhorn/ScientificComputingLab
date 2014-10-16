function [ error ] = error_calc( delta_t, y, y_exact )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

error = sqrt(delta_t/5 * sum( (y-y_exact).^2));

end

