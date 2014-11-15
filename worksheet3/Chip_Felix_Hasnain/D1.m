%implementing the equation for finding B
for i=1:Nx + 2
	for j=1:Ny + 2
		x = (i-1)*hx;
		y = (j-1)*hy;
		B(i,j) = -2*pi^2*sin(pi*x)*sin(pi*y);
	end
end