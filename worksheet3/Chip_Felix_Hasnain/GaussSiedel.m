function [ Xbnd ] = GaussSiedel( Nx, Ny )
%GAUSSSIEDEL This function implements the Gauss Siedel Method for solving
%PDE
%   Detailed explanation goes here

LIM = 1e-4;
IMAX = 900;

Xbnd = zeros(Nx+2, Ny+2);
Xbnd(2: end-1,2:end-1) = 1;


% for T mxn, N = m*n
N = Nx*Ny;
a = (Nx+1)^2;
c = (Ny+1)^2;
b = -2*(a + c);

%implementing the equation for finding B


B = zeros(Nx,Ny);
Rmat = zeros(Nx,Ny);
hx = 1/(Nx + 1);
hy = 1/(Ny + 1);
for i=1:Nx
	for j=1:Ny
		x = i*hx;
		y = j*hy;
		B(i,j) = -2*pi^2*sin(pi*x)*sin(pi*y);
	end
end
% TESTING
% Xbnd
% surf(B);
%TODO define LIM comparison loop
R = 1;
n = 0;
while R > LIM || ...
		n < IMAX 
	for j=1:Ny
		for i=1:Nx
			ii = i+1;
			jj = j+1;
			%Nx+2xNy+2  NxxNy
			Xbnd(ii,jj) = ((B(i,j) - a*Xbnd(ii-1,jj) - a*Xbnd(ii + 1,jj)- c*Xbnd(ii,jj -1) - c*Xbnd(ii,jj +1))/b);
			Rmat(i,j) = (B(i,j) -b*Xbnd(ii,jj) -a*Xbnd(ii-1,jj) - a*Xbnd(ii+1,jj)- c*Xbnd(ii,jj-1) - c*Xbnd(ii,jj+1));
		end
	end
	%
	R = sqrt(sum(sum((Rmat.^2)))/(N));
	n = n + 1;
	if n == IMAX
		disp ('IMAX has been reached')
	end
end

surf(Xbnd);

end

