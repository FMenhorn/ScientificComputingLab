function [ A ] = Agen( Nx, Ny )
%AGEN 
%  This function will generate a second degree center step finite
%  difference transform matrix based on the dimensions of Nx x Ny

% TODO: COMMENT ON HOW WE DERIVED PARAMETERS a, b and c!!!!!

% for T mxn, N = m*n
N = Nx*Ny;
a = (Nx+1)^2;
c = (Ny+1)^2;
b = -2*(a + c);

A = zeros(N);

for j=1:Ny
	for i=1:Nx
		%always initialize new zero matrix
		B = zeros(Nx,Ny);
		%current point always set to center coef.
		B(i,j) = b;
		%left point set to left coef. if not on boundary
		if(i>1)
			B(i-1,j) = a;
		end
		%right point set to right coef if not on boundary
		if(i<Nx)
			B(i+1,j) = a;
		end
		%upper point set to upper coef. if not on boundary
		if(j>1)
			B(i,j-1) = c;
		end
		%lower point set to lower coef if not on boundary
		if(j<Ny)
			B(i,j+1) = c;
		end
		disp(B);
		disp(B(:)')
		%stringing out B matrix & addiing to row
		% the term i+-(j-1)*m discribes the correlation between the
		% itteration position in T and the row number in A
		A(i+(j-1)*Nx,:) = B(:)'; 
	end
end

end

