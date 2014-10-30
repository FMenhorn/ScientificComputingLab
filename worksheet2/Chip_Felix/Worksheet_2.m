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
eu_mat = zeros()
for i=1 : len(dt)
    Euler(grow, p0,dt(i),N)
end