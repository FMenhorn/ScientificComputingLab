function [ A ] = AnaSol( Nx,Ny,f )
%ANASOL returns the analytical solution to the PDE
%   Detailed explanation goes here

hx = 1/(Nx + 1);
hy = 1/(Ny + 1);
[Y,X] = meshgrid(hx:hx:1-hx,hy:hy:1-hy);
A = f(X,Y);

end

