function [ Xbnd ] = GaussSeidel( Nx, Ny, B )
%GAUSSSEIDEL This function implements the Gauss Seidel Method for solving
%PDE
%   This function implements the Gauss-Seidel method as a function of the
%   number of unknowns in the x-direction (respectively y-direction) Nx
%   (respectively Ny) as well as the precomputed right-hand side B (see
%   RHS.m). It returns a matrix of computed values (unknowns and boundary
%   values) after repeteatedly iterating through the entire system until a
%   predefined accuracy limit has been reached.

LIM = 1e-4;   %max precision value
IMAX = 20000; %max iterations limit value
R = LIM + 1;

Xbnd = zeros(Nx+2, Ny+2);

% defining various coefs for center difference method
% for T mxn, N = m*n 
N = (Nx)*(Ny); 
% The linear system of equations subject to this task looks as follows:

% (1/hx^2)*T_i-1,j + (1/hy^2)*T_i,j-1 + (1/hx^2)*T_i+1,j + (1/hy^2)*T_i,j+1
% - 2((hy^2+hx^2)/(hx^2*hy^2)) = B

% By expressing 1/hx^2 and 1/hy^2 in terms of the number of unknowns Nx and
% Ny and substitung them by a and c, we obtain:
a = (Nx+1)^2;       
c = (Ny+1)^2;
b = -2*(a + c);

Rmat = zeros(Nx,Ny); % Bracket term of the residual calculation (see Worksheet)

n = 1; % Initialise the current number of iterations to 1

while R > LIM && n < IMAX
    % Note that the for-loops only run across the grid of unknowns! Values
    % at the boundaries are fixed.
	for j=2:Ny+1
		for i=2:Nx+1
            % (Re-)Calculating the current unknown in the grid by
            % reordering the above equation
			Xbnd(i,j) = ((B(i-1,j-1) - a*Xbnd(i-1,j) - a*Xbnd(i + 1,j)- c*Xbnd(i,j -1) - c*Xbnd(i,j +1))/b);
        end
    end
    for j=2:Ny+1
		for i=2:Nx+1
            % (Re-)Calculating the residual at every point in the grid.
    		Rmat(i,j) = B(i-1,j-1) - b*Xbnd(i,j) -a*Xbnd(i-1,j) - a*Xbnd(i+1,j)- c*Xbnd(i,j-1) - c*Xbnd(i,j+1);
        end
    end

	% Calculating the total residual per run
	R = sqrt(sum(sum(Rmat.^2))/N);
    
	n = n + 1;
    %disp(n);
	if n == IMAX
		disp ('IMAX has been reached')
    end
%     
%     loglog(n,R);
%     hold on;
%     
end
%R
% hold off;

end

