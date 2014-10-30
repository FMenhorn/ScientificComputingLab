function [ y_next ] = newton_solver( expression, diff_expression,y_0,accuracy_limit)
%NEWTON_SOLVER solves the equation = 0 using Newton's method (also known as
%the Newton-Raphson method)
% INPUT:
%       expression:  expression for which the root is to be calculated. Takes
%       y_(n+1) and returns the evaluated expression
%       diff_expression: the differentiated expression evaluated in
%       Newton's Method.
%       y_0:    starting value for y_(n+1) 
%       accuracy_limit: accepted threshhold value, returns y_(n+1) when
%       |expression(y_(n+1))|<accuracy_limit.
% OUTPUT:
%       y_next: result value for y_(n+1)

% initialise y
y_next = y_0;

current_expr_value = expression(y_next);

% iteration loop.
while (abs(current_expr_value) > accuracy_limit)
    y_next = y_next - current_expr_value/diff_expression(y_next);
    current_expr_value = expression (y_next);
end


end