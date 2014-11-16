function [rhs] = RHS( Nx,Ny,f )

%implementing the equation for finding the right hand side
% for i=1:Nx + 2
% 	for j=1:Ny + 2
% 		x = (i-1)*hx;
% 		y = (j-1)*hy;
% 		B(i,j) = -2*pi^2*sin(pi*x)*sin(pi*y);
% 	end
% end
% end

hx = 1/(Nx + 1);
hy = 1/(Ny + 1);
[Y,X] = meshgrid(hx:hx:1-hx,hy:hy:1-hy);
rhs = f(X,Y);

