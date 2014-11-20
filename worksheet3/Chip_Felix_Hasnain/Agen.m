function [ A ] = Agen( Nx, Ny )
%AGEN3 
%  This function will generate a second degree center step finite
%  difference transform matrix based on the dimensions of Nx x Ny

% for T mxn, N = m*n
N = Nx*Ny;
a = (Nx+1)^2;
c = (Ny+1)^2;
b = -2*(a + c);

A = zeros(N);

for j=1:Ny
	for i=1:Nx
		
		Row_index = i+(j-1)*Nx;

		%current point always set to center coef.
		A(Row_index, i+(j-1)*Nx) = b;
		
		%left point set to left coef. if not on boundary
		if(i>1)
			A(Row_index, (i-1)+(j-1)*Nx) = a;
		end
		%right point set to right coef if not on boundary
		if(i<Nx)
			A(Row_index, (i + 1)+(j-1)*Nx) = a;
		end
		%upper point set to upper coef. if not on boundary
		if(j>1)
			A(Row_index, i+(j-2)*Nx) = c;
		end
		%lower point set to lower coef if not on boundary
		if(j<Ny)
			A(Row_index, i+(j)*Nx) = c;
		end
	end
end

end

%% Other Implementation-1
% 
% function [ A ] = Agen( Nx, Ny )
% %AGEN 
% %  This function will generate a second degree center step finite
% %  difference transform matrix based on the dimensions of Nx x Ny
% 
% % TODO: COMMENT ON HOW WE DERIVED PARAMETERS a, b and c!!!!!
% 
% % for T mxn, N = m*n
% N = Nx*Ny;
% a = (Nx+1)^2;
% c = (Ny+1)^2;
% b = -2*(a + c);
% 
% A = zeros(N);
% 
% for j=1:Ny
% 	for i=1:Nx
% 		%always initialize new zero matrix
% 		B = zeros(Nx,Ny);
% 		%current point always set to center coef.
% 		B(i,j) = b;
% 		%left point set to left coef. if not on boundary
% 		if(i>1)
% 			B(i-1,j) = a;
% 		end
% 		%right point set to right coef if not on boundary
% 		if(i<Nx)
% 			B(i+1,j) = a;
% 		end
% 		%upper point set to upper coef. if not on boundary
% 		if(j>1)
% 			B(i,j-1) = c;
% 		end
% 		%lower point set to lower coef if not on boundary
% 		if(j<Ny)
% 			B(i,j+1) = c;
% 		end
% 		%disp(B);
% 		%disp(B(:)')
% 		%stringing out B matrix & addiing to row
% 		% the term i+-(j-1)*m discribes the correlation between the
% 		% itteration position in T and the row number in A
% 		A(i+(j-1)*Nx,:) = B(:)'; 
% 	end
% end
% 
% end

%% Other Implementation - 2

% function [ A ] = Agen( Nx,Ny )
% %UNTITLED10 Summary of this function goes here
% %   Detailed explanation goes here
% tic;
% N = Nx*Ny;
% a = (Nx+1)^2;
% c = (Ny+1)^2;
% b = -2*(a + c);
% 
% 
% A = b*diag(ones(1,N)) + ...
% 	c*diag(ones(1,N-Nx), -Nx);
% Arr_r = 2:N+1:N*N;
% Arr_r(Nx:Nx:length(Arr_r))=[];
% A(Arr_r)=a;
% A = A + A';
% toc
% end
% 

