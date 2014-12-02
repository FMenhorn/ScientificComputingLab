function [ X ] = ExEuler2D( X , dt )
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here

[m, n] = size(X);
Nx = m - 2;
Ny = n - 2;
hx = 1 / (Nx + 1);
hy = 1 / (Ny + 1);

X(2:end-1 , 2:end-1) = X(2:end-1 , 2:end-1) + dt * ...
	(1 / (hx^2) * ( X(1:end-2 , 2:end-1) - 2*X(2:end-1,2:end-1) + X(3:end,2:end-1)) ...
	+ 1/(hy^2)*( X(2:end-1,1:end-2) - 2*X(2:end-1,2:end-1) + X(2:end-1,3:end)));

end

