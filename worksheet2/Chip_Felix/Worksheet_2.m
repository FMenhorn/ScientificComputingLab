%% Backwards Euler
% ODE
dif_p = @(p) 7*(1-p/10)*p;
% initial value
p0 = 20;                                 
% Growth function
grow = @(t) 200./(20-10*exp(-7.*t));    

%% a)
t_end=5;
t = linspace(0,t_end,1000);
plot(t,grow(t));
title('Population Equation');
xlabel('Time');
ylabel('Population');

fprintf('Program paused. Press enter to continue.\n\n');
pause;

%% b)
% Color definition matrix for graphs
Color = {[1 1 0], [1 0 1], [0 1 1], [1 0 0], [0 1 0], [0 0 1]};
% Initialisation of time steps
dt = [1 1/2 1/4 1/8 1/16 1/32];

for i=3:length(dt)
    t = 0:dt(i):t_end;
    y = Euler(dif_p,p0,dt(i),t_end);
    plot(t,y,'Color',Color{i},'LineStyle','-')
    hold on
end
%t = linspace(0,t_end,1000);
%plot(t,grow(t),'k-');
legend('dt = 1/4', 'dt = 1/8', 'dt = 1/16', 'dt = 1/32');
fprintf('Program paused. Press enter to continue.\n\n');
pause;









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