function y_t  = Adams_Moulton(f, d_f, y0, d_t, t_end)
% Implements the implicit Adams Moulton method

stopping_Limit = 150;					% No. of iterations after which the Newton Method is forced to stop
len = t_end/d_t + 1;
y_t = zeros(1, len);

newtons_Iterations = zeros(1,len);	% JFT (Just for testing), to be removed in the final version

stopped = 0;
y_t(1)= y0;

for i = 2:len
	yt_prev = y_t(i-1);
	G_y = @(y)(y - yt_prev - d_t*(f(yt_prev)+f(y))/2);
	diff_G_y = @(y)(1 - d_t*d_f(y)/2);
	
	x = y_t(i-1);
	itr = 0;
	
	x_graph = [];												% JFT
	
	while (abs(G_y(x)) > 10e-4  &&  itr < stopping_Limit)
		x = x- (G_y(x))/(diff_G_y(x));
		x_graph = [x_graph x];									% JFT
		itr = itr + 1;
		newtons_Iterations(i) = newtons_Iterations(i)+1;		% JFT
	end
	
	if itr == stopping_Limit
		disp(strcat('Adam Moultom method for dt ',num2str(d_t), ' stopped by the stopping criteria'));
		y_t(i) = Inf;
		
		% JFT: plotting the graph of x in case the Newton's method fails
		%figure('name',strcat('Adams Moulton, dt: ', num2str(d_t)));		% JFT
		%plot(x_graph)													% JFT
		%xlabel('Iteration number')										% JFT
		%ylabel('x')														% JFT

		break;
	end
	
	y_t(i) = x;
end

if stopped == 1
	disp(strcat('Adam Moultom method for dt ',num2str(d_t), ' stopped by the stopping criteria'));
end

% JFT: plotting the number of Newton's iterations per step of y(t)
%figure('name',strcat('Adams Moulton, dt: ', num2str(d_t)));		% JFT
%bar(newtons_Iterations,'r')										% JFT
%xlabel('y(n)')													% JFT
%ylabel('Number of Newtons iterations')							% JFT

end