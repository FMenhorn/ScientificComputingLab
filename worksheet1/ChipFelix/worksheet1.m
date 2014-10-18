%% Worksheet 1
% a) Use matlab to plot the function p(t) in a graph.

dt = [1,1/2,1/4,1/8];
t_end = 5;
t = 0:dt(2):t_end;
p = 10./(1+9.*exp(-t));

plot(t,p,'m-')
xlabel('Time t')
ylabel('p(t)')
title('Analytical solution of p(t)')

fprintf('Program paused. Proceed with Task c). Press enter to continue.\n');
pause;
%% b)
% see functions Euler.m, Heun.m, RungeKutta.m, (RKEuler.m)

%% c)

eq1 = @(p)(1-(p/10))*p;
y0 = 1;
E_eul = zeros(1,length(dt));
E_heu = zeros(1,length(dt));
E_RK = zeros(1,length(dt));

Color = {[1 1 0], [1 0 1], [0 1 1], [1 0 0], [0 1 0]};

% Euler
for i=1:length(dt)
t = 0:dt(i):t_end;
p = 10./(1+9.*exp(-t));

y = Euler(eq1,y0,dt(i),t_end);
E_eul(i) = sqrt((dt(i)/5)*sum((y-p).^2));
plot(t,y,'Color',Color{i},'LineStyle','-')
hold on
end
E_eul
plot(t,p,'Color',Color{length(dt)+1},'LineStyle','-')
xlabel('Time t')
legend(strcat('Euler with dt =',' ',num2str(dt(1))),...
       strcat('Euler with dt =',' ',num2str(dt(2))),...
       strcat('Euler with dt =',' ',num2str(dt(3))),...
       strcat('Euler with dt =',' ',num2str(dt(4))),...
       'Analytical Solution', 'Location','northwest')
title(['Comparison of Euler approximations with respect to time step ' ...
       'and analytical solution'])
hold off
fprintf('Program paused. Press enter to continue.\n');
pause;

% Heun
for i=1:length(dt)
t = 0:dt(i):t_end;
p = 10./(1+9.*exp(-t));

y = Heun(eq1,y0,dt(i),t_end);
E_heu(i) = sqrt((dt(i)/5)*sum((y-p).^2));
plot(t,y,'Color',Color{i},'LineStyle','-')
hold on
end
E_heu
plot(t,p,'Color',Color{length(dt)+1},'LineStyle','-')
xlabel('Time t')
legend(strcat('Heun with dt =',' ',num2str(dt(1))),...
       strcat('Heun with dt =',' ',num2str(dt(2))),...
       strcat('Heun with dt =',' ',num2str(dt(3))),...
       strcat('Heun with dt =',' ',num2str(dt(4))),...
       'Analytical Solution', 'Location','northwest')
title(['Comparison of Heun approximations with respect to time step ' ...
       'and analytical solution'])
hold off
fprintf('Program paused. Press enter to continue.\n');
pause;

% Runge-Kutta
for i=1:length(dt)
t = 0:dt(i):t_end;
p = 10./(1+9.*exp(-t));

y = RungeKutta(eq1,y0,dt(i),t_end);
E_RK(i) = sqrt((dt(i)/5)*sum((y-p).^2));
plot(t,y,'Color',Color{i},'LineStyle','-')
hold on
end
E_RK
plot(t,p,'Color',Color{length(dt)+1},'LineStyle','-')
xlabel('Time t')
legend(strcat('Runge-Kutta with dt =',' ',num2str(dt(1))),...
       strcat('Runge-Kutta with dt =',' ',num2str(dt(2))),...
       strcat('Runge-Kutta with dt =',' ',num2str(dt(3))),...
       strcat('Runge-Kutta with dt =',' ',num2str(dt(4))),...
       'Analytical Solution', 'Location','northwest')
title(['Comparison of Runge-Kutta approximations with respect to ' ...
       'time step and analytical solution'])
hold off
fprintf('Program paused. Proceed with Task e). Press enter to continue.\n');
pause;

%% d)
% see tables in Worksheet 1

%% e)

eq1 = @(p)(1-(p/10))*p;
y0 = 1;
E_eul = zeros(1,length(dt));
E_heu = zeros(1,length(dt));
E_RK = zeros(1,length(dt));

Color = {[1 1 0], [1 0 1], [0 1 1], [1 0 0], [0 1 0]};

% Euler
stepsize = 1;
for i=length(dt):-1:1
    ct = 1;
    y = Euler(eq1,y0,dt(i),t_end);
    if i == length(dt)
        p = y;
    end
    
    for j=1:stepsize:t_end/dt(length(dt))+1
        diff_vec = p(j)-y(ct);
        ct = ct + 1;
    end
    E_eul(i) = sqrt((dt(i)/5)*sum((diff_vec).^2));
    stepsize = stepsize * 2;
end
E_eul
fprintf('Program paused. Press enter to continue.\n');
pause;

% Heun
stepsize = 1;
for i=length(dt):-1:1
    ct = 1;
    y = Heun(eq1,y0,dt(i),t_end);
    if i == length(dt)
        p = y;
    end
    for j=1:stepsize:t_end/dt(length(dt))+1
        diff_vec = p(j)-y(ct);
        ct = ct + 1;
    end
    E_heu(i) = sqrt((dt(i)/5)*sum((diff_vec).^2));
    stepsize = stepsize * 2;
end
E_heu

fprintf('Program paused. Press enter to continue.\n');
pause;

% Runge-Kutta
stepsize = 1;
for i=length(dt):-1:1
    ct = 1;
    y = RungeKutta(eq1,y0,dt(i),t_end);
    if i == length(dt)
        p = y;
    end
    for j=1:stepsize:t_end/dt(length(dt))+1
        diff_vec = p(j)-y(ct);
        ct = ct + 1;
    end
    E_RK(i) = sqrt((dt(i)/5)*sum((diff_vec).^2));
    stepsize = stepsize * 2;
end
E_RK

fprintf('Program paused. Press enter to continue.\n');
pause;
