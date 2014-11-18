function [ analytical_solution ] = analytical_solution( N_x,N_y,func )
%ANALYTICAL_SOLUTION Summary of this function goes here
%   Detailed explanation goes here
xx = 0:1/(1+N_x):1;
yy = 0:1/(1+N_y):1;
analytical_solution = nan(N_x+2,N_y+2);

for i = 1:length(xx)
    for j = 1:length(yy)
        analytical_solution(i,j) = func(xx(i),yy(j));
    end
end

end

