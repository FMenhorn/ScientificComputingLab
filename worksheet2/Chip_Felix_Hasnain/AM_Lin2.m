function y_t  = AM_Lin2(y0, d_t, t_end)
% Implements the Linearization 1 of Admas Moulton Menthod

t = 0:d_t:t_end;
y_t = zeros(1, length(t));
y_t(1)= y0;

for i = 2:length(t)
	y_prv = y_t(i-1);
	G_y = @(y)(y - y_prv - d_t/2*(7*(1-y_prv/10)*y_prv + 7*(1-y_prv/10)*y));
	diff_G_y = @(y)(-d_t*7*(1-y_prv/10)/2+1);
	
	x = y_t(i-1);
	itr = 0;
	
	while (G_y(x)>10e-4 && itr < 50)
		x = x- (G_y(x))/(diff_G_y(x));
		itr = itr + 1;
	end
	
	if itr > 49
		disp(strcat('Adams-M-Lin1 method for dt ',num2str(d_t), ' stopped by the stopping criteria'));
		y_t(i) = Inf;
		
		break;
	end
	
	y_t(i) = x;
end

end

