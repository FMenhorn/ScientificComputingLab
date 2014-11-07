function [ y_next_old,iteration ] = newton_solver( expression, diff_expression,y_guess,accuracy_limit,iteration_limit)
%NEWTON_SOLVER solves the equation "expression = 0" using Newton's method (also known as
%the Newton-Raphson method)
% INPUT:
%       expression:  expression for which the root is to be calculated. Takes
%       y_(n+1) and returns the evaluated expression
%       diff_expression: the differentiated expression evaluated in
%       Newton's Method.
%       y_0:    starting value for y_(n+1) 
%       accuracy_limit: accepted threshhold value, returns y_(n+1) when
%       |expression(y_(n+1))|<accuracy_limit.
%       iteration_limit: number of maximal iterations 
% OUTPUT:
%       y_next: result value for y_(n+1)

% initialise y
y_next_old = y_guess;
y_next = y_next_old + 2*accuracy_limit; %to make sure loop starts

current_expr_value = expression(y_next_old);

iteration = 1;
% iteration loop.
while (((abs(y_next-y_next_old)>accuracy_limit) ...          % we are close, means that y-value does not change much with each iteration
        ||(abs(current_expr_value) > accuracy_limit)) ...    % also, we are finding where the expression is zero
        &&(iteration<iteration_limit))                      % break if too many iterations without finding.
    y_next_old = y_next;
    y_next = y_next_old - current_expr_value/diff_expression(y_next_old);
    current_expr_value = expression (y_next);
    iteration = iteration +1;
end


end