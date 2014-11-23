function [ e ] = GS_error ( Nx,Ny,A_GS,A_ana )
%ERROR computes the error between the Gauss-Seidel implementation and the
%analytical solution.
%   Detailed explanation goes here
e = sqrt(sum(sum((A_GS-A_ana).^2))/(Nx*Ny));
end

