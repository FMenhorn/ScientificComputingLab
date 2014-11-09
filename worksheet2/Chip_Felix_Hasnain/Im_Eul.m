function [y_out, failureFlag]  = Im_Eul(f, d_f, y0, d_t, t_end)
%IM_EUL Adams Moulton Method for solvong an ODE
%
% Inputs are	f: ODE
%				d_f: derivative of the ODE w.r.t t
%				y0: initial value
%				dt: time interval per step.
%				t_end: time to finish solving
% Outputs are	y_out: solution of ODE 
%				failure_flag: it would be 0 in case of a successful solution and 1 in case of failure.
%


ITMAX = 100;						% Newtons Method terminated after ITMAX iterations
TOL = 10e-4;						% Tolerance
									
len = t_end/d_t;							% number of steps in range
y_out = [y0, zeros(1, len)];                

%newtons_Iterations = zeros(1,len);			% JFT: Just for testing

for i = 2 : length(y_out)
	
	% y: estimated value of next step
	G = @(y)(y - y_out(i-1) - d_t*f(y));	% Expression of Implicit Euler method				
	dG = @(y)(1 - d_t*d_f(y));				% Derivateve of G wrt y
	
	x = y_out(i-1);
	x_prev = x + 1;							% initializing x_prev ie. |x-x_prev| > TOL
	itCount = 0;							% Iterations count
	failureFlag = 0;
	
	% Applying Newtons Method to find y
	while (abs(G(x)) >= TOL ...
			&& abs(x-x_prev)>= TOL)
		
		% Testing the failure criteria
		if(itCount >= ITMAX)
			disp('Newtons Method: Iteration count exceeds the maximum limit.');
			failureFlag = 1;
			break;
		end%if
		if(abs(x) > 1.d6)
			disp('Newtons Method: Iterate too large');
		failureFlag = 1;
			break;
		end%if
		if(dG(x) == 0)
			disp('Newtons Method: Derivative of expression is equal to zero.');
			failureFlag = 1;
			break;
		end%if
		
		% Failing criteria not satisfied for this iteration
		x_prev = x;
		x = x- (G(x))/(dG(x));
		itCount = itCount + 1;
		
		%newtons_Iterations(i) = newtons_Iterations(i)+1;		% JFT
	
	end%while
	
	if failureFlag == 1
		disp(strcat('Implicit Euler method for dt ',num2str(d_t), ...
                    ' stopped by the stopping criteria'));
		y_out(i) = Inf;
		break;
	end%if
	
	y_out(i) = x;
end%for