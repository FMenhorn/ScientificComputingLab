function [ Xbnd ] = GaussSiedel( Nx, Ny )
%GAUSSSIEDEL This function implements the Gauss Siedel Method for solving
%PDE
%   Detailed explanation goes here

LIM = 1e-4;   %max precision value
IMAX = 1000; %max iterations limit value
R = ones(IMAX);

Xbnd = zeros(Nx+2, Ny+2);
Xbnd(2: end-1,2:end-1) = 1;

%defining various coefs for center diference method
% for T mxn, N = m*n 
N = (Nx+2)*(Ny+2); 
%a = (Nx+3)^2;
a = (Nx+1)^2; % Assumed to be correct
%c = (Ny+3)^2;
c = (Ny+1)^2; % Assumed to be correct
b = -2*(a + c);
B = zeros(Nx + 2,Ny + 2);
Rmat = zeros(Nx,Ny);
hx = 1/(Nx + 1);
hy = 1/(Ny + 1);

%implementing the equation for finding B
for i=1:Nx + 2
	for j=1:Ny + 2
		x = (i-1)*hx;
		y = (j-1)*hy;
		B(i,j) = -2*pi^2*sin(pi*x)*sin(pi*y);
	end
end
[row,col] = size(B);
disp(row)
disp(col)

% TESTING
% Xbnd
% surf(B);
%TODO define LIM comparison loop
%R = 1;
n = 1;
 while R(n) > LIM || ...
    	n < IMAX 
	for j=2:Ny+1
		for i=2:Nx+1
			%Nx+2xNy+2  NxxNy
			Xbnd(i,j) = ((B(i,j) - a*Xbnd(i-1,j) - a*Xbnd(i + 1,j)- c*Xbnd(i,j -1) - c*Xbnd(i,j +1))/b);
			Rmat(i,j) = (B(i,j) -b*Xbnd(i,j) -a*Xbnd(i-1,j) - a*Xbnd(i+1,j)- c*Xbnd(i,j-1) - c*Xbnd(i,j+1));
		end
	end
	%
	R(n) = sqrt(sum(sum((Rmat.^2)))/(N));
	n = n + 1;
    %disp(n);
	if n == IMAX
		disp ('IMAX has been reached')
	end
end

surf(Xbnd);
disp(B)

end

