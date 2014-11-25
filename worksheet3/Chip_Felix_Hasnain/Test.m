
clear all;
close all;

f = @(x,y)(-2*pi^2*sin(pi*x).*sin(pi*y));
f_ana = @(x,y)(sin(pi*x).*sin(pi*y));

minItr = 3;
maxItr = 100;
% Time requirements for different grid sizes with full matrix
Rtime_Full = zeros(1,maxItr - minItr + 1);
% Storage requirement in Bytes for different grid sizes with full matrix
Strg_Full_Bytes = zeros(1,maxItr - minItr + 1);
% Storage requirement in No of elements for different grid sizes with full matrix
Strg_Full_Elements = zeros(1,maxItr - minItr + 1);
% Time requirements for different grid sizes with sparse matrix
Rtime_Sparse = zeros(1,maxItr - minItr + 1);
% Storage requirement in Bytes for different grid sizes with sparse matrix
Strg_Sparse_Bytes = zeros(1,maxItr - minItr + 1);
% Storage requirement in No of elements for different grid sizes with sparse matrix
Strg_Sparse_Elements = zeros(1,maxItr - minItr + 1);
% Time requirements for different grid sizes for Gauss Siedel method
Rtime_GS = zeros(1,maxItr - minItr + 1);
% Storage requirement in Bytes for different grid sizes for Gauss Siedel method
Strg_GS_Bytes = zeros(1,maxItr - minItr + 1);
% Storage requirement in number of elements for different grid sizes for Gauss Siedel method
Strg_GS_Elements = zeros(1,maxItr - minItr + 1);

Itr = zeros(1,maxItr - minItr +1);

for n = minItr:maxItr
	disp(n)
	
	hx = 1/(n + 1);
	hy = 1/(n + 1);
	b = RHS(n,n,f);
	b = b(:);
	tic;
	A = Agen(n,n);
	x = A\b;
% 	Calculating the runtime of FULL MATRIAX
	X = zeros(n,n);
	X(1:end) = x(1:end);
	X = padarray(X,[1,1]);

	Rtime_Full(n) = toc;


% 	Calculating the storage of FULL MATRIAX
	s_A = whos('A'); s_X = whos('X'); s_b = whos('b');
	Strg_Full_Bytes(n) = s_A.bytes + s_X.bytes + s_b.bytes;
	Strg_Full_Elements(n) = numel(A) + numel(X) + numel(b);
	
	% SPARSE MATRIX
tic;
	A = Agen(n,n);
	A_sparse = sparse(A);
	x = A_sparse\b;
% 	Calculating the runtime SPARSE
	X = zeros(n,n);
	X(1:end) = x(1:end);
	X = padarray(X,[1,1]);
	Rtime_Sparse(n) = toc;
 		
% 	Calculating the storage SPARSE
	s_A_sparse = whos('A_sparse'); s_X = whos('X'); s_b = whos('b');
	Strg_Sparse_Bytes(n) = s_A_sparse.bytes + s_X.bytes + s_b.bytes;
	Strg_Sparse_Elements(n) = CountNZsInA(n,n) + numel(X) + numel(b);
	
	b = RHS(n,n,f);
	
	%GAUSS SEIDEL
	tic;
	[X Itr(n-minItr + 1)] = GaussSeidel( n, n, b );
% 	Calculating the runtime
	Rtime_GS(n) = toc;
 		
% 	Calculating the storage
	s_X = whos('X'); s_b = whos('b');
	Strg_GS_Bytes(n) = s_X.bytes + s_b.bytes;
	Strg_GS_Elements(n) = numel(X) + numel(b);
	
	
end


figure;
hold on;
plot(Rtime_Full, 'k')
plot(Rtime_Sparse, 'g')
plot(Rtime_GS, 'r')
title('Run Time')
legend('Full', 'Sparse', 'Gauss Seidel')
hold off;

figure;
hold on;
plot(Strg_Full_Bytes, 'k')
plot(Strg_Sparse_Bytes, 'g')
plot(Strg_GS_Bytes, 'r')
title('Storage in Bytes')
legend('Full', 'Sparse', 'Gauss Seidel')
hold off;


figure;
hold on;
plot(Strg_Full_Elements, 'k')
plot(Strg_Sparse_Elements, 'g')
plot(Strg_GS_Elements, 'r')
title('Storage as Number of Elements')
legend('Full', 'Sparse', 'Gauss Seidel')
hold off;

