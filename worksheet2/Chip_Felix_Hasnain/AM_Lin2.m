function y_t  = AM_Lin2(y0, d_t, t_end)
% Implements the Linearization 1 of Admas Moulton Menthod

stopping_Limit = 250;					% No. of iterations after which the Newton Method is forced to stop
len = t_end/d_t;
y_t = [y0,zeros(1, len)];
%newtons_Iterations = zeros(1,len);	% JFT (Just for testing), to be removed in the final version

for i = 2 : length(y_t)
	y_prv = y_t(i-1);
	G_y = @(y)(y - y_prv - d_t/2*(7*(1-y_prv/10)*y_prv + 7*(1-y_prv/10)*y));
	diff_G_y = @(y)(-d_t*7*(1-y_prv/10)/2+1);
	
	% x = round(rand(1)*100);
	x = y_t(i-1);
	itr = 0;

	while (abs(G_y(x)) > 10e-4  &&  itr < stopping_Limit)
		x = x- (G_y(x))/(diff_G_y(x));
		itr = itr + 1;
		%newtons_Iterations(i) = newtons_Iterations(i)+1;		% JFT
	end
	
	if itr == stopping_Limit
		disp(strcat('Adams-M-Lin1 method for dt ',num2str(d_t), ' stopped by the stopping criteria'));
		y_t(i) = Inf;
		
		break;
	end
	
	y_t(i) = x;
end

%figure('name',strcat('AM Lin2, dt: ', num2str(d_t)));			% JFT
%bar(newtons_Iterations,'r')										% JFT
%xlabel('y(n)')													% JFT
%ylabel('Number of Newtons iterations')							% JFT

end

