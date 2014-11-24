function [ column_label ] = column_labels( X,Y )
%COLUMN_LABELS returns a list of column labels according to X and Y in the form
% column_label(i) = (X(i),Y(i))
% INPUT:
%           X: lists of x labels
%           Y: lists of y labels
% OUTPUT:
%           column_label: list of column labels to X and Y
column_label =[];

if (length(X) ~= length(Y))
    error('COLUMN_LABELS: Length of X array unequal to Y array. There is something wrong!')
end

for i = 1:length(X)
    column_label = [column_label '(' num2str(X(i)) ',' num2str(Y(i)) ') '];
end

end

