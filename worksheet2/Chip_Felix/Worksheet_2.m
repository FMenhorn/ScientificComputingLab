%% Backwards Euler

dif_p = @(p) 7*(1-p/10)*9;               % ODE

p0 = 20;                                 % startvalue

grow = @(t) 200./(20-10*exp(-7.*t));    % Growth function

%% a)
t_end=5;
p = 20;                                  % number of plotted points
t = linspace(t_end,0,p)
plot(t,grow(t));                         % Plotted p(t) in a graph

%% b)

dt = [1 1/2 1/4 1/8 1/16 1/32];
eu_mat = zeros(t_end/dt(6));
for i = 6 : 1 
   eu_mat(:, i) = Euler(grow(), p0,dt(i),t_end);
   %TODO vectors must be the same length to plot Note:  why doesn't this return
   %the correct value matrix, what am i missing? the valaues arnt even
   %writen into the matrix eu_mat
   %TODO fix for iteration so that a matrix is created with all Euler
   %values
   
   
   
end

% length(t) used to trouble shoot. returns 100. standard linspace value?
plot(t / p,y);

%TODO repeat the Euler iteration for Heun