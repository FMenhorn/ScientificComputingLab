function y_t  = Im_Eul(f, d_f, y0, d_t, t_end)
%IM_EUL Implements the Implicit Euler method
%	y_t: The result of Implicit Euler computed on  diff(y_t) = f(y_t)

%

stopping_Limit = 250;					% No. of iterations after which the Newton Method is forced to stop
len = t_end/d_t + 1;					%number of steps in range
newtons_Iterations = zeros(1,len);		% JFT (Just for testing), to be removed in the final version
y_t = zeros(1, len);
y_t(1)= y0;

for i = 2 : len
	
	% y: the next step
	G_y = @(y)(y - y_t(i-1) - d_t*f(y));		
	diff_G_y = @(y)(1 - d_t*d_f(y));
	
	x = y_t(i-1); 
	itr = 0;
	
	while (abs(G_y(x)) > 10e-4  &&  itr < stopping_Limit)
		x = x- (G_y(x))/(diff_G_y(x));
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

%figure('name',strcat('Implicit Eul, dt: ', num2str(d_t)));		% JFT
%bar(newtons_Iterations,'r')										% JFT
%xlabel('y(n)')													% JFT
%ylabel('Number of Newtons iterations')							% JFT

end