%% Worksheet3

% In this worksheet, the two-dimensional stationary heat equation of the
% following form is computed in different ways:
% 
% T_xx + T_yy = -2pi^2*sin(pi*x)sin(pi*y)
%
% on the unit square with homogeneous Dirichlet boundary conditions
% T(x,y)=0 for all (x,y) at the boundaries of the unit square.


%% VARIABLES

clear all;
close all;

f = @(x,y)(-2*pi^2*sin(pi*x).*sin(pi*y));
f_ana = @(x,y)(sin(pi*x).*sin(pi*y));
Nx = [7 15 31 63];
Ny = [7 15 31 63];

% Time requirements for different grid sizes with full matrix
Rtime_Full = zeros(1,length(Nx));
% Storage requirement in Bytes for different grid sizes with full matrix
Strg_Full_Bytes = zeros(1,length(Nx));
% Storage requirement in No of elements for different grid sizes with full matrix
Strg_Full_Elements = zeros(1,length(Nx));
% Time requirements for different grid sizes with sparse matrix
Rtime_Sparse = zeros(1,length(Nx));
% Storage requirement in Bytes for different grid sizes with sparse matrix
Strg_Sparse_Bytes = zeros(1,length(Nx));
% Storage requirement in No of elements for different grid sizes with sparse matrix
Strg_Sparse_Elements = zeros(1,length(Nx));
% Time requirements for different grid sizes for Gauss Seidel method
Rtime_GS = zeros(1,length(Nx));
% Storage requirement in Bytes for different grid sizes for Gauss Seidel method
Strg_GS_Bytes = zeros(1,length(Nx));
% Storage requirement in number of elements for different grid sizes for Gauss Seidel method
Strg_GS_Elements = zeros(1,length(Nx));

%% Task a), b) and c)

% see functions Agen.m, GaussSeidel.m, RHS.m

%% Task d), e)

% 1) DIRECT SOLUTION WITH FULL MATRIX

figure('name','Direct Solution with Full Matrix');
set(gcf, 'Position', get(0,'Screensize'));

for n = 1:length(Nx)
	hx = 1/(Nx(n) + 1);
	hy = 1/(Ny(n) + 1);
	b = RHS(Nx(n),Ny(n),f);
    % Expand (transform) the matrix that is returned from RHS.m into a
    % vector.
	b = b(:);
    clear A x;
    tic;
	A = Agen(Nx(n),Ny(n));
    x = A\b;
    % Expand (transform) the vector that is returned from solving the 
    % linear system into a matrix for plotting over a grid.
	X = zeros(Nx(n), Ny(n));
    X(1:end) = x(1:end);
    % As so far only a grid of unknowns has been constructed (X only
    % contains the computed values without the boundaries!) Thus, in order
    % to plot the whole system, boundary conditions (BC = 0) are
    % incorporated by appending zeros around the grid (X matrix).
	X = padarray(X,[1,1]);
    % Calculating the runtime
    Rtime_Full(n) = toc;


% 	Coloured surface plot of Temperatue
	subplot(2,4,n)
	[Xmesh,Ymesh] = meshgrid(0:hx:1,0:hy:1);
	surf(Xmesh,Ymesh,X);
	axis([0 1 0 1 0 1]);
	title(strcat('Surface plot: Nx = ', num2str(Nx(n)), ...
		', Ny = ', num2str(Ny(n))));
	xlabel('x-axis');
	ylabel('y-axis');
	zlabel('Temperature');
	
% 	Contour plot of Temperature
	subplot(2,4,n+4)
	contour(Xmesh,Ymesh,X)
	xlabel('x-axis');
	ylabel('y-axis');
	title(strcat('Contour plot: Nx = ', num2str(Nx(n)), ...
		', Ny = ', num2str(Ny(n))));
	
% 	Calculating the storage in terms of bytes and in terms of elements
	s_A = whos('A'); s_X = whos('X'); s_b = whos('b');
	Strg_Full_Bytes(n) = s_A.bytes + s_X.bytes + s_b.bytes;
	Strg_Full_Elements(n) = numel(A) + numel(X) + numel(b);
end


% 2) DIRECT SOLUTION WITH SPARSE MATRIX
% For explanation of individual code segments, please refer to 1).

%subplot(2,4)
figure('name','Direct Solution with Sparse Matrix');
set(gcf, 'Position', get(0,'Screensize'));

for n = 1:length(Nx)
	hx = 1/(Nx(n) + 1);
	hy = 1/(Ny(n) + 1);
	b = RHS(Nx(n),Ny(n),f);
	b = b(:);
    clear A A_sparse x;
    tic;
	A = Agen(Nx(n),Ny(n));
	A_sparse = sparse(A);
	x = A_sparse\b;
	X = zeros(Nx(n), Ny(n));
	X(1:end) = x(1:end);
	X = padarray(X,[1,1]);
    % Calculating the runtime
    Rtime_Sparse(n) = toc;

 		
% 	Calculating the storage
	s_A_sparse = whos('A_sparse'); s_X = whos('X'); s_b = whos('b');
	Strg_Sparse_Bytes(n) = s_A_sparse.bytes + s_X.bytes + s_b.bytes;
	Strg_Sparse_Elements(n) = CountNZsInA(Nx(n),Ny(n)) + numel(X) + numel(b);
	
% 	Coloured surface plot of Temperatue
	subplot(2,4,n)
	[Xmesh,Ymesh] = meshgrid(0:hx:1,0:hy:1);
	surf(Xmesh,Ymesh,X);
	axis([0 1 0 1 0 1]);
	title(strcat('Surface plot: Nx = ', num2str(Nx(n)), ...
		', Ny = ', num2str(Ny(n))));
	xlabel('x-axis');
	ylabel('y-axis');
	zlabel('Temperature');
	
% 	Contour plot of Temperature
	subplot(2,4,n+4)
	contour(Xmesh,Ymesh,X)
	xlabel('x-axis');
	ylabel('y-axis');
	title(strcat('Contour plot: Nx = ', num2str(Nx(n)), ...
		', Ny = ', num2str(Ny(n))));
	
end


% 3) ITERATIVE SOLUTION WITH GAUSS SEIDEL METHOD

figure('name','Iterative Solution with Gauss Seidel Method');
set(gcf, 'Position', get(0,'Screensize'));

for n = 1:length(Nx)
	hx = 1/(Nx(n) + 1);
	hy = 1/(Ny(n) + 1);
	
	b = RHS(Nx(n),Ny(n),f);
	tic;
	X = GaussSeidel( Nx(n), Ny(n), b );
% 	Calculating the runtime
	Rtime_GS(n) = toc;
 		
% 	Calculating the storage
	s_X = whos('X'); s_b = whos('b');
	Strg_GS_Bytes(n) = s_X.bytes + s_b.bytes;
	Strg_GS_Elements(n) = numel(X) + numel(b);
	
% 	Coloured surface plot of Temperature
	subplot(2,4,n)
	[Xmesh,Ymesh] = meshgrid(0:hx:1,0:hy:1);
	surf(Xmesh,Ymesh,X);
	axis([0 1 0 1 0 1]);
	title(strcat('Surface plot: Nx = ', num2str(Nx(n)), ...
		', Ny = ', num2str(Ny(n))));
	xlabel('x-axis');
	ylabel('y-axis');
	zlabel('Temperature');
	
% 	Contour plot of Temperature
	subplot(2,4,n+4)
	contour(Xmesh,Ymesh,X)
	xlabel('x-axis');
	ylabel('y-axis');
	title(strcat('Contour plot: Nx = ', num2str(Nx(n)), ...
		', Ny = ', num2str(Ny(n))));
end


%% Task f) and g) 

% Runtime and storage requirements already calculated in the previous
% section

% Calculating error in Gauss Seidel
Nx = [7 15 31 63 127];
Ny = Nx;
len = length(Nx);
e = zeros(1,len);
GSerr = zeros(1,len);
for i=1:len
    X = GaussSeidel(Nx(i),Ny(i),RHS(Nx(i),Ny(i),f));
	X = X(2:end-1,2:end-1);
	A_ana = AnaSol(Nx(i),Ny(i),f_ana);
    GSerr(i) = GS_error(Nx(i),Ny(i),X,A_ana);
end
GSerrFactor = GSerr(1:end-1)./GSerr(2:end);

% Changing the units of runtime from seconds to mili-seconds
Rtime_Full = Rtime_Full*1000;
Rtime_GS = Rtime_GS*1000;
Rtime_Sparse = Rtime_Sparse*1000;

% Converting the storage in kilobytes and rounding off
Strg_Full_Bytes = round(Strg_Full_Bytes./1024);
Strg_GS_Bytes = round(Strg_GS_Bytes./1024);
Strg_Sparse_Bytes = round(Strg_Sparse_Bytes./1024);


% PLOTTING RESULTS IN TABLE

% Maximum number of characters in the column  string
maxCharsInCol1 = 26;			
% length of Column 1 in pixels
LengthOfCol1 = 40 + maxCharsInCol1*10;	
rowLen = 680;		%Length of row in pixels

numOfRows = [3,4,4,4];				% Number of Rows in each table
tableHeight = 25*numOfRows;
numOfTables = 4;
% Constructing table height vector
tblHigtVec(1)= 10;
tblHigtVec(2)= 5 + tblHigtVec(1)+tableHeight(1);
tblHigtVec(3)= 5 + tblHigtVec(2)+tableHeight(2);
tblHigtVec(4)= 5 + tblHigtVec(3)+tableHeight(3);
tblHigtVec(5)= 10 + tblHigtVec(4)+tableHeight(4);

% Figure of suitable size
f4 = figure('name','Results');
set(f4, 'Position', [300 280 (rowLen+20) tblHigtVec(numOfTables+1)])

% Table for results of Full Matrix
cnames = {'7', '15', '31', '63'};
rnames = {' Full-Matrix: Runtime(ms) ', 'Storage(kBs)','Storage(No. of elements)'};
FullMatTable = uitable(f4,'Data',[Rtime_Full ; Strg_Full_Bytes; Strg_Full_Elements],...
                'ColumnName',cnames, 'RowName', rnames,...
                'Position', [10 tblHigtVec(4) rowLen tableHeight(4)], 'ColumnWidth', {95});

% Table for results of Sparse Matrix
rnames = {'Sparse-Matrix: Runtime(ms)', 'Storage (kBs)','Storage(No. of elements)'};			
SparseMatTable = uitable(f4,'Data',[Rtime_Sparse ; Strg_Sparse_Bytes; Strg_Sparse_Elements],...
                'ColumnName',cnames, 'RowName', rnames,...
                'Position', [10 tblHigtVec(3) rowLen tableHeight(3)], 'ColumnWidth', {95});

% Table for results of Gauss Seidel
rnames = {'Gauss-Seidel: Runtime(ms) ', 'Storage (kBs)','Storage(No. of elements)'};
GSMatTable = uitable(f4,'Data',[Rtime_GS ; Strg_GS_Bytes; Strg_GS_Elements],...
                'ColumnName',cnames, 'RowName', rnames,...
                'Position', [10 tblHigtVec(2) rowLen tableHeight(2)], 'ColumnWidth', {95});

% Table for error factor of Gauss Seidel
cnames = {'7', '15', '31', '63', '127'};
rnames = {'    Gauss-Seidel: Error   ', 'Error Factor'};
ErrorTable = uitable(f4,'Data',[GSerr;[0,GSerrFactor]],...
                'ColumnName',cnames, 'RowName', rnames,...
                'Position', [10 tblHigtVec(1) rowLen tableHeight(1)], 'ColumnWidth', {76});		
