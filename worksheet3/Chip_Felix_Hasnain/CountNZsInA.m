function [nonZCount, zCount ] = CountNZsInA( Nx,Ny)
%COUNTAZEROS This function counts the number of zeros and non zero elements
% the function A generated by AGEN
%   Nx is the number of rows in T matrix
%	Ny is the number of columns in T matrix
%	nonZCount is the number of non zeros in A
%	zCount is the number of zeros in A


nZ_top_or_bottom = 2*3 + (Nx-2)*4;

%  non zero elements in centre rows
nZ_centre_rows = 2*4 + (Nx - 2)*5;

% Counting the number of non zeros in A
nonZCount = 2*nZ_top_or_bottom + (Ny-2)*nZ_centre_rows;

%Counting the number of zeros in A
Size_of_A = (Nx*Ny)^2;
zCount = Size_of_A - nonZCount;

end
