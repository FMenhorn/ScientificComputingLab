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
% Storage requirement for different grid sizes with full matrix
Strg_Full = zeros(1,length(Nx));
% Time requirements for different grid sizes with sparse matrix
Rtime_Sparse = zeros(1,length(Nx));
% Storage requirement for different grid sizes with sparse matrix
Strg_Sparse = zeros(1,length(Nx));
% Time requirements for different grid sizes for Gauss Siedel method
Rtime_GS = zeros(1,length(Nx));
% Storage requirement for different grid sizes for Gauss Siedel method
Strg_GS = zeros(1,length(Nx));

%% Task a), b) and c)

% see functions Agen.m, GaussSeidel.m, RHS.m

%% Task d), e)

% 1) DIRECT SOLUTION WITH FULL MATRIX

figure('name','Direct Solution with Full Matrix');
set(gcf, 'Position', get(0,'Screensize'));

for n = 1:length(Nx)
	hx = 1/(Nx(n) + 1);
	hy = 1/(Ny(n) + 1);
	A = Agen(Nx(n),Ny(n));
	b = RHS(Nx(n),Ny(n),f);
	b = b(:);
	tic;
	x = linsolve(A,b);
% 	Calculating the runtime
	Rtime_Full(n) = toc;

	X = zeros(Nx(n), Ny(n));
	X(1:end) = x(1:end);
	X = padarray(X,[1,1]);

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
	
% 	Calculating the storage
	s_A = whos('A'); s_X = whos('X'); s_b = whos('b');
	Strg_Full(n) = s_A.bytes + s_X.bytes + s_b.bytes;
end


% 2) DIRECT SOLUTION WITH SPARSE MATRIX
tic;

%subplot(2,4)
figure('name','Direct Solution with Sparse Matrix');
set(gcf, 'Position', get(0,'Screensize'));

for n = 1:length(Nx)
	hx = 1/(Nx(n) + 1);
	hy = 1/(Ny(n) + 1);
	A = Agen(Nx(n),Ny(n));
	b = RHS(Nx(n),Ny(n),f);
	b = b(:);
	tic;
	A_sparse = sparse(A);
	x = A_sparse\b;
% 	Calculating the runtime
	Rtime_Sparse(n) = toc;
	X = zeros(Nx(n), Ny(n));
	X(1:end) = x(1:end);
	X = padarray(X,[1,1]);
 		
% 	Calculating the storage
	s_A_sparse = whos('A_sparse'); s_X = whos('X'); s_b = whos('b');
	Strg_Sparse(n) = s_A_sparse.bytes + s_X.bytes + s_b.bytes;
	
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
	Strg_GS(n) = s_X.bytes + s_b.bytes;
	
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


%% Task f) and g) 

% Runtime and storage requirements already calculated in the previous
% section

% Calculating error in Gauss Seidel
Nx = [7 15 3 6 12];
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

% Plotting results in a table
f4 = figure('name','Results');
set(f4, 'Position', [300 280 670 340])
cnames = {'7', '13', '31', '63'};
rnames = {' Full-Matrix: Runtime ', 'Storage'};
FullMatTable = uitable(f4,'Data',[Rtime_Full ; Strg_Full],...
                'ColumnName',cnames, 'RowName', rnames,...
                'Position', [10 250 663 75], 'ColumnWidth', {100});

rnames = {'Sparse-Matrix: Runtime', 'Storage'};			
SparseMatTable = uitable(f4,'Data',[Rtime_Sparse ; Strg_Sparse],...
                'ColumnName',cnames, 'RowName', rnames,...
                'Position', [10 170 663 75], 'ColumnWidth', {100});

rnames = {'Gauss-Seidel: Runtime ', 'Storage'};
GSMatTable = uitable(f4,'Data',[Rtime_GS ; Strg_GS],...
                'ColumnName',cnames, 'RowName', rnames,...
                'Position', [10 90 663 75], 'ColumnWidth', {100});

cnames = {'7', '13', '31', '63', '127'};
rnames = {'  Gauss-Seidel: Error ', 'Error Factor'};
ErrorTable = uitable(f4,'Data',[GSerr;[0,GSerrFactor]],...
                'ColumnName',cnames, 'RowName', rnames,...
                'Position', [10 10 663 75], 'ColumnWidth', {80});		
