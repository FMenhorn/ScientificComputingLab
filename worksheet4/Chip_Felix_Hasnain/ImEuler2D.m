function [ Tout ] = ImEuler2D( Tin, dt )
%OMPLICITEULER2D This function implements one Implicit Euler iteration. It
%uses the Gauss Seidel approximation for solving the implicit equation
%
%   INPUT ARGUMENTS
%	Xin which is value of X in the current iteration
%	dt is the time step
%	
%	OUTPUT ARGUMENT
%	Xout is the value of X after dt timestep

LIM = 1e-6;   %max precision value
IMAX = 20000; %max iterations limit value
Res = LIM + 1; %residual
[m, n] = size(Tin);
Nx = m - 2;		% Nx is the grid size in x direction
Ny = n - 2;		% Ny is the grid size in y direction
hx = 1/(Nx + 1);
hy = 1/(Ny + 1);
Tout = Tin;
Rmat = zeros(Nx,Ny); % Bracket term of the residual calculation

n = 1; % Initialise the current number of iterations to 1

while Res > LIM && n < IMAX
    % Note that the for-loops only run across the grid of unknowns! Values
    % at the boundaries are fixed.
	for i = 2 : Nx+1
		for j = 2 : Ny+1
			Tt = (1/hx.^2)*(Tout(i-1,j) + Tout(i+1,j)) + ...
				 (1/hy.^2)*(Tout(i,j-1) + Tout(i,j+1));
			Tout(i,j) + dt*(- 2 * Tout(i,j))= Tin(i,j) + dt * Tt;
        
	end
	
    for i=2:Nx+1
		for j=2:Ny+1
            % (Re-)Calculating the residual at every point in the grid.
    		Tt = (1/hx.^2)*(Tout(i-1,j) - 2 * Tout(i,j) + Tout(i+1,j)) + ...
				 (1/hy.^2)*(Tout(i,j-1) - 2 * Tout(i,j) + Tout(i,j+1));
			 Rmat(i-1,j-1) = Tin(i,j) + dt * Tt - Tout(i,j);
        end
    end

	% Calculating the total residual per run
	Res = sqrt(sum(sum(Rmat.^2))/(Nx*Ny));
	n = n + 1;		% increment iteration counter
% 	if n == IMAX	% 
% 		disp ('IMAX has been reached')
% 	end %if statement
%     
end %while 

end %function

