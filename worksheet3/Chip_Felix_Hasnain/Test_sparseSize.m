
VecSize = zeros(1,30);
for i = 1:30
	clear A;
	A = zeros(i,i);
	A(1:3)=1;
	As = sparse(A);
	s = whos('As');
	VecSize(i)=s.bytes;
end
x = 1:30;
plot(x,VecSize);