function y_t  = Adams_Moulton(f, d_f, y0, d_t, t_end)
% Implements the implicit Adams Moulton method

t = 0:d_t:t_end;
y_t = zeros(1, length(t));
stopped = 0;
y_t(1)= y0;

for i = 2:length(t)
	yt_prev = y_t(i-1);
	G_y = @(y)(y - yt_prev - d_t*(f(yt_prev)+f(y))/2);
	diff_G_y = @(y)(1 - d_t*d_f(y)/2);
	
	x = y_t(i-1);
	itr = 0;
	
	while (G_y(x)>10e-4 && itr < 50)
		x = x- (G_y(x))/(diff_G_y(x));
		itr = itr + 1;
	end
	
	if itr > 49
		disp(strcat('Adam Moultom method for dt ',num2str(d_t), ' stopped by the stopping criteria'));
		y_t(i) = Inf;
		break;
	end
	
	y_t(i) = x;
end

if stopped == 1
	disp(strcat('Adam Moultom method for dt ',num2str(d_t), ' stopped by the stopping criteria'));
end

end