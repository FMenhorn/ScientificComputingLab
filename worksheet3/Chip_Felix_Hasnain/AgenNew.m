function [ A ] = AgenNew( Nx,Ny )
%UNTITLED10 Summary of this function goes here
%   Detailed explanation goes here
tic;
N = Nx*Ny;
a = (Nx+1)^2;
c = (Ny+1)^2;
b = -2*(a + c);


A = b*diag(ones(1,N)) + ...
	c*diag(ones(1,N-Nx), -Nx);
Arr_r = 2:N+1:N*N;
Arr_r(Nx:Nx:length(Arr_r))=[];
A(Arr_r)=a;
A = A + A';
toc
end

