function y_t  = Im_Eul(f, d_f, y0, d_t, t_end)
%IM_EUL Implements the Implicit Euler method
%	y_t: The result of Implicit Euler computed on  diff(y_t) = f(y_t)

%

stopping_Limit = 250;				% No. of iterations after which 
                                    % the Newton Method is forced to stop
len = t_end/d_t;                    % number of steps in range
y_t = [y0, zeros(1, len)];                
%newtons_Iterations = zeros(1,len);  % JFT (Just for testing), to be removed in the final version

for i = 2 : length(y_t)
	
	% y: the next step
	G_y = @(y)(y - y_t(i-1) - d_t*f(y));		
	diff_G_y = @(y)(1 - d_t*d_f(y));
	
	x = y_t(i-1); 
	itr = 0;
	while (abs(G_y(x)) > 10e-4 && itr < stopping_Limit)
        x_prev = x;
		x = x- (G_y(x))/(diff_G_y(x));
		itr = itr + 1;
		%newtons_Iterations(i) = newtons_Iterations(i)+1;		% JFT
	end
	
	if itr == stopping_Limit
		disp(strcat('Implicit Euler method for dt ',num2str(d_t), ...
                    ' stopped by the stopping criteria'));
		y_t(i) = Inf;

		break;
	end
	
	y_t(i) = x;
end

%figure('name',strcat('Implicit Eul, dt: ', num2str(d_t)));		% JFT
%bar(newtons_Iterations,'r')									% JFT
%xlabel('y(n)')													% JFT
%ylabel('Number of Newtons iterations')							% JFT

end