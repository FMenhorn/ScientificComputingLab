function [ zCount ] = CountAZeros( Nx,Ny)
%COUNTAZEROS This function count the number of zero elements of matrix A 
%   Nx is the number of rows in T matrix
%	Ny is the number of columns in T matrix

% *****TOP ROW*******		Ones_top_or_bottom
% ********C**********		Ones_centre_rows 
% ********N**********			..	
% ********T**********			..
% ********R**********		Ones_centre_rows 
% ****BOTTOM ROW*****		Ones_top_or_bottom

Ones_top_or_bottom = 2*3 + (Nx-2)*4; 
Ones_centre_rows = 2*4 + (Nx - 2)*5;
Size_of_A = (Nx*Ny)^2;
zCount = Size_of_A - 2*Ones_top_or_bottom - (Ny-2)*Ones_centre_rows;
end

