%% Backwards Euler

dif_p = @(p) 7*(1-p/10)*9;               % ODE

p0 = 20;                                 % startvalue

grow = @(t) 200./(20-10.*exp(-7.*t));    % Growth function

%% a)
N=5;

t = linspace(N,0);
plot(t,grow(t));                         % Plotted p(t) in a graph

%% b)

dt = [1 1/2 1/4 1/8 1/16 1/32];
eu_mat = zeros(length(dt));
for i=1 : 1 %length(dt)
   y = Euler(grow, p0,dt(i),N-1);
   %TODO vectors must be the same length to plot
   %TODO fix for iteration so that a matrix is created with all Euler
   %values
   
end
length(y)  
length(t)

plot(t,y);

%TODO repeat the Euler iteration for Heun