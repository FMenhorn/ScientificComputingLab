function [ Tout ] = ExEuler2D( T, dt, Nx, Ny )
% ExEuler2D Computes the 2D explicit Euler function (FTCS - Forward in time,
% centered in space)
%   This function takes the grid of the previous time step and uses these
%   values to compute the values at the current time step using an FTCS
%   scheme.

Tout = zeros(Nx+2, Ny+2);	% initializing the output matrix

hx = 1 / (Nx + 1);
hy = 1 / (Ny + 1);

<<<<<<< Updated upstream
% The equation implemented for Explicit Euler looks like:
%	Tout(i,j) = T(i,j) + dt*Tt
% Where
%	Tt = Txx + Tyy
% Further:
%	Txx = (1 / (hx^2) * ( T(i-1,j) - 2*T(i,j) + T(i+1,j)) and
%	Tyy = (1 / (hy^2) * ( T(i,j-1) - 2*T(i,j) + T(i,j+1))

% By simplifying the above equations for finding the coefficients, the final
% equation looks like
% Tout = a*T(i-1,j) + b*T(i,j-1) + a*T(i+1,j) + b*T(i,j+1) + c*T(i,j) where

a = dt/(hx^2);
b = dt/(hy^2);
c = 1 - 2*dt*(1/(hx^2) + 1/(hy^2));

% Solving for the whole matrix in one equation

Tout(2:end-1 , 2:end-1) = a * (T(1:end-2,2:end-1) + T(3:end,2:end-1))...
						+ b * (T(2:end-1,1:end-2) + T(2:end-1,3:end))...
						+ c * T(2:end-1 , 2:end-1);
=======

X(2:end-1 , 2:end-1) = X(2:end-1 , 2:end-1) + dt * ...
	(1 / (hx^2) * ( X(1:end-2 , 2:end-1) - 2*X(2:end-1,2:end-1) + X(3:end,2:end-1)) ...
	+ 1/(hy^2)*( X(2:end-1,1:end-2) - 2*X(2:end-1,2:end-1) + X(2:end-1,3:end)));
>>>>>>> Stashed changes

end

