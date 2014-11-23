
%% This section draws the graph of % of non zero elements in A (measure of sparsity)

StartSize = 3;		% Nx = Ny for the starting value
EndSize = 20;		% Nx = Ny for the ending value

NonZeroPercent = zeros(StartSize - EndSize +1);
NonZeroNum = zeros(StartSize - EndSize +1);

for n = StartSize:EndSize
	N = n*n;
	NonZeroNum(n-StartSize + 1) = (N*N - CountAZeros(n,n));
	NonZeroPercent(n-StartSize + 1) = NonZeroNum(n-StartSize + 1)/(N^2)*100;
end

x = StartSize:EndSize;
%subplot(1,2,1)
plot(x,NonZeroPercent)
title('% of non-zeros elements in A');
ylabel('%')

% subplot(1,2,2)
% plot(x,sqrt(NonZeroNum))
% title('Sqrt of number of non-zero elements in A');
% ylabel('sqrt(Number)')
