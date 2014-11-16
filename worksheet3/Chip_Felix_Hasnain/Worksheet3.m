%% Worksheet3

% In this worksheet, the two-dimensional stationary heat equation of the
% following form is computed in different ways:
% 
% T_xx + T_yy = -2pi^2*sin(pi*x)sin(pi*y)
%
% on the unit square with homogeneous Dirichlet boundary conditions
% T(x,y)=0 for all (x,y) at the boundaries of the unit square.

%% Task a), b) and c)

% see functions Agen.m, GaussSeidel.m, RHS.m

%% Task d) and e)
f = @(x,y)(-2*pi^2*sin(pi*x).*sin(pi*y));
f_ana = @(x,y)(sin(pi*x).*sin(pi*y));

Nx = [7 15 31 63];
Ny = [7 15 31 63];

% 1) MATLAB DIRECT SOLVER
for n = 1 : length(Nx)
	hx = 1/(Nx + 1);
	hy = 1/(Ny + 1);
	
	A = Agen(Nx,Ny);
% 	b_temp = RHS(Nx,Ny,f);
	
% 	b = zeros(Nx*Ny,1);
% 	for i=1:Ny
% 		b(Nx*(i-1)+1:Nx*(i-1)+Nx) = b_temp(:,i);
% 	end
	b = RHS(Nx,Ny,f);
	b = b(:);
	tic;
	x = linsolve(A,b);
	t1 = toc;
	t1
	
	tic;
	x = A\b;
	t2 = toc;
	t2
	
	% TODO: What is internally happening with \ solving opposed to linsolve?
	%       \ is even faster!!! Why???
	
	X = zeros(Nx+2, Ny+2);
	X(1:end)=x(1:end);
	% for i=1:Ny
	%     X(2:Nx+1,i+1) = x(Nx*(i-1)+1:Nx*(i-1)+Nx);
	% end
	
	surf(X);
end
% 2)
tic;

%A = Agen(Nx,Ny);
A_sparse = sparse(A);
%b_temp = RHS(Nx,Ny,f);

% b = zeros(Nx*Ny,1);
% for i=1:Ny
%     b(Nx*(i-1)+1:Nx*(i-1)+Nx) = b_temp(:,i);
% end

x = A_sparse\b;
t3 = toc;
t3

X = zeros(Nx+2, Ny+2);
% for i=1:Ny
%     X(2:Nx+1,i+1) = x(Nx*(i-1)+1:Nx*(i-1)+Nx);
% end
X(1:end)=x(1:end);

surf(X);

% So, why is Sparse so incredibly fast and for that, why not always just
% using sparse matrices intead of iterative scheme?

% 3)

tic;
X = GaussSeidel(Nx,Ny,RHS(Nx,Ny,f));
t4 = toc;
t4

surf(X);



