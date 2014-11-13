%%Worksheet3
%%Exercise a)

%define N
N=16;
%define A
clear all;
A = zeros(16); %init A matrix
% Init T
T = zeros(4); %init T vector
x = zeros(16,1);
ii=1; %define counter
%define T
for i=1:4
    for j=1 :4
        if not (j==1 | i==1 | j==4 | i==4)
            T(i,j) = 1;
        end
    end
end

%A(1,2) = 2; 

%init x and A 
for i=1:4
    for j=1 :4
        
        x(ii)=T(i,j);
        ii = ii + 1;
       %TODO define A
    end
end