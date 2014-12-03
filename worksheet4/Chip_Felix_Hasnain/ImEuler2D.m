function [ Tout ] = ImEuler2D( Tin,dt )
% ImEuler2D computes the implicit Euler scheme by using the Gauss-Seidel
% method.
%   

LIM = 1e-6;   %max precision value
IMAX = 20000; %max iterations limit value
R = LIM + 1;
[Nx, Ny] = size(Tin(2:end-1,2:end-1));
Tout = zeros(Nx+2, Ny+2); % including the boundaries in Tout

% defining various coefs for center difference method
% for T mxn, N = m*n 
N = Nx*Ny; 

% The linear system of equations subject to this task looks as follows:

% a*T_i-1,j + b*T_i,j-1 + a*T_i+1,j + b*T_i,j+1 + c*T_i,j = Tin, where

a = -dt*(Nx+1)^2;       
b = -dt*(Ny+1)^2;
c = 2*dt*((Nx+1)^2+(Ny+1)^2)+1;

Rmat = zeros(Nx,Ny); % Bracket term of the residual calculation (see WS3)

n = 1; % Initialise the current number of iterations to 1

while R > LIM && n < IMAX
    % Note that the for-loops only run across the grid of unknowns! Values
    % at the boundaries are fixed.
	for j=2:Ny+1
		for i=2:Nx+1
            % (Re-)Calculating the current unknown in the grid by
            % reordering the above equation
			Tout(i,j) = Tin(i,j)/c - (a/c)*(Tout(i+1,j)+Tout(i-1,j)) - ...
                (b/c)*(Tout(i,j-1)+Tout(i,j+1));
        end
    end
    for j=2:Ny+1
		for i=2:Nx+1
            % (Re-)Calculating the residual at every point in the grid.
    		Rmat(i,j) = Tin(i,j) - a*(Tout(i-1,j)+Tout(i+1,j)) - ...
                b*(Tout(i,j-1)+Tout(i,j+1)) - c*(Tout(i,j));
        end
    end

	% Calculating the total residual per run
	R = sqrt(sum(sum(Rmat.^2))/N);
    
	n = n + 1;
    
	if n == IMAX
		disp ('IMAX has been reached')
    end
end
end