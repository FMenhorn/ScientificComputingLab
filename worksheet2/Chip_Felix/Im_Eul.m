function y_t  = Im_Eul(f, d_f, y0, d_t, t_end)
%IM_EUL Implements the Implicit Euler method
%	y_t: The result of Implicit Euler computed on  diff(y_t) = f(y_t)

%
len = t_end/d_t + 1;			%number of steps in range

y_t = zeros(1, len);
y_t(1)= y0;

for i = 2 : len
	
	% y: the next step
	G_y = @(y)(y - y_t(i-1) - d_t*f(y));		
	diff_G_y = @(y)(1 - d_t*d_f(y));
	
	x = y_t(i-1);
	
	while (G_y(x)>10e-4)
		z = x- (G_y(x))/(diff_G_y(x));
		x = z;
	end
	
	y_t(i) = x;
end

end

