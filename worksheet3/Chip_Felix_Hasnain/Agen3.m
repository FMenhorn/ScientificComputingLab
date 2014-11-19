function [ A ] = Agen3( Nx, Ny )
%AGEN3 
%  This function will generate a second degree center step finite
%  difference transform matrix based on the dimensions of Nx x Ny

% TODO: COMMENT ON HOW WE DERIVED PARAMETERS a, b and c!!!!!

% for T mxn, N = m*n
N = Nx*Ny;
a = (Nx+1)^2;
c = (Ny+1)^2;
b = -2*(a + c);

A = zeros(N);
A2 = zeros(N);

for j=1:Ny
	for i=1:Nx
		
		Row_index = i+(j-1)*Nx;

		%current point always set to center coef.
		A2(Row_index, i+(j-1)*Nx) = b;
		
		%left point set to left coef. if not on boundary
		if(i>1)
			A2(Row_index, (i-1)+(j-1)*Nx) = a;
		end
		%right point set to right coef if not on boundary
		if(i<Nx)
			A2(Row_index, (i + 1)+(j-1)*Nx) = a;
		end
		%upper point set to upper coef. if not on boundary
		if(j>1)
			A2(Row_index, i+(j-2)*Nx) = c;
		end
		%lower point set to lower coef if not on boundary
		if(j<Ny)
			A2(Row_index, i+(j)*Nx) = c;
		end
	end
end

end

