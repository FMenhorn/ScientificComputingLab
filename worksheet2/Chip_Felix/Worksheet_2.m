%% Variables

Analyt_Sol = @(t) 200./(20-10*exp(-7.*t));  % Analytical Solution
f = @(p) 7*(1-p/10)*p;						% ODE diff(p) = f(p)
D_f = @(p)(7*(1-p/5));						% diff of f wrt p
p0 = 20;									% Initial value
t_end = 5;									% end time
dt = [1 1/2 1/4 1/8 1/16 1/32];				% time steps
Er_ExEul = zeros(1, length(dt));			% App. Error of Explicit Euler method
Er_Heun = zeros(1, length(dt));				% App. Error of method of Heun
Er_ImEul = zeros(1, length(dt));			% App. Error of Implicit Euler
Er_AdMol = zeros(1, length(dt));			% App. Error of Implicit Euler
Er_AML1 = zeros(1, length(dt));				% App. Error of Implicit Euler
Er_AML2 = zeros(1, length(dt));				% App. Error of Implicit Euler
% Color definition matrix for graphs
Color = {[1 1 0], [1 0 1], [0 1 1], [1 0 0], [0 1 0], [0 0 1], [0 0 0]};
FigPosition = {[66 277 512 384], [436 278 512 384], [855 278 512 384], [66 1 512 384], [434 1 512 384],[855 1 512 384]};

%% a)

p = 20;                                  % Y axis value limits
t = linspace(t_end,0);
close all
set(0, 'DefaultFigurePosition', FigPosition{1})
figure
plot(t,Analyt_Sol(t));                   % Plotted p(t) in a graph


%% b)

% Explicit Euler
% all Explicit Euler aproximation values are calculated along with the
% error E_Ex_Eul

set(0, 'DefaultFigurePosition', FigPosition{1})
close all
figure('name','Explicit Euler');

for i=1:length(dt)
t = 0:dt(i):t_end;
p = Analyt_Sol(t);

y = Euler(f,p0,dt(i),t_end);
Er_ExEul(i) = sqrt((dt(i)/5)*sum((y-p).^2));
plot(t,y,'Color',Color{i},'LineStyle','-')
hold on
end

plot(t,p,'Color',Color{length(dt)+1},'LineStyle','-')
axis([0,5,0,20]);
fprintf(['The following vector shows the errors obtained for comparing '...
         'the euler approximation to the analytical sol. on different steps.\n']);
disp(Er_ExEul)
xlabel('Time t')
legend(strcat('Explicit Euler with dt =',' ',num2str(dt(1))),...
       strcat('Explicit Euler with dt =',' ',num2str(dt(2))),...
       strcat('Explicit Euler with dt =',' ',num2str(dt(3))),...
       strcat('Explicit Euler with dt =',' ',num2str(dt(4))),...
	   strcat('Explicit Euler with dt =',' ',num2str(dt(5))),...
	   strcat('Explicit Euler with dt =',' ',num2str(dt(6))),...
       'Analytical Solution', 'Location','northeast')
title(['Comparison of Explicit Euler approximations wtr time step ' ...
       'and analytical solution.'])
hold off

% Heun
% all Heun aproximation values are calculated along with the
% error Er_Heun

set(0, 'DefaultFigurePosition', FigPosition{2})
figure('name','Heun');

for i=1:length(dt)
t = 0:dt(i):t_end;
p = Analyt_Sol(t);

y = Heun(f,p0,dt(i),t_end);
Er_Heun(i) = sqrt((dt(i)/5)*sum((y-p).^2));
plot(t,y,'Color',Color{i},'LineStyle','-')
hold on
end

plot(t,p,'Color',Color{length(dt)+1},'LineStyle','-')
axis([0,5,0,20]);
fprintf(['The following vector shows the errors obtained for comparing '...
         'the euler approximation to the analytical sol. on different steps.\n']);
disp(Er_Heun)
xlabel('Time t')
legend(strcat('Heun with dt =',' ',num2str(dt(1))),...
       strcat('Heun with dt =',' ',num2str(dt(2))),...
       strcat('Heun with dt =',' ',num2str(dt(3))),...
       strcat('Heun with dt =',' ',num2str(dt(4))),...
	   strcat('Heun with dt =',' ',num2str(dt(5))),...
	   strcat('Heun with dt =',' ',num2str(dt(6))),...
       'Analytical Solution', 'Location','northeast')
title(['Comparison of Heun approximations wtr time step ' ...
       'and analytical solution.'])
hold off


%% c) and d)
% Implicit Euler
% all Implicit Euler aproximation values are calculated along with the
% error Er_ImEul

set(0, 'DefaultFigurePosition', FigPosition{3})
figure('name','Implicit Euler');

for i=1:length(dt)
t = 0:dt(i):t_end;
p = Analyt_Sol(t);
y = Im_Eul(f,D_f,p0,dt(i),t_end);
Er_ImEul(i) = sqrt((dt(i)/5)*sum((y-p).^2));
plot(t,y,'Color',Color{i},'LineStyle','-')
hold on
end

plot(t,p,'Color',Color{length(dt)+1},'LineStyle','-')
axis([0,5,0,20]);
fprintf(['The following vector shows the errors obtained for comparing '...
         'the euler approximation to the analytical sol. on different steps.\n']);
disp(Er_ImEul)
xlabel('Time t')
legend(strcat('dt =',' ',num2str(dt(1))),...
       strcat('dt =',' ',num2str(dt(2))),...
       strcat('dt =',' ',num2str(dt(3))),...
       strcat('dt =',' ',num2str(dt(4))),...
	   strcat('dt =',' ',num2str(dt(5))),...
	   strcat('dt =',' ',num2str(dt(6))),...
       'Analytical Solution', 'Location','northeast')
title(['Comparison of Implicit Euler approximations wtr time step ' ...
       'and analytical solution.'])
hold off


% Adams Moulton
% all Adams Moulton aproximation values are calculated along with the
% error Er_Heun

set(0, 'DefaultFigurePosition', FigPosition{4})
figure('name','Adams Moulton');

for i=1:length(dt)
t = 0:dt(i):t_end;
p = Analyt_Sol(t);
y = Adams_Moulton(f,D_f,p0,dt(i),t_end);
Er_AdMol(i) = sqrt((dt(i)/5)*sum((y-p).^2));
plot(t,y,'Color',Color{i},'LineStyle','-')
hold on
end

plot(t,p,'Color',Color{length(dt)+1},'LineStyle','-')
axis([0,5,0,20]);
fprintf(['The following vector shows the errors obtained for comparing '...
         'the euler approximation to the analytical sol. on different steps.\n']);
disp(Er_AdMol)
xlabel('Time t')
legend(strcat('dt =',' ',num2str(dt(1))),...
       strcat('dt =',' ',num2str(dt(2))),...
       strcat('dt =',' ',num2str(dt(3))),...
       strcat('dt =',' ',num2str(dt(4))),...
	   strcat('dt =',' ',num2str(dt(5))),...
	   strcat('dt =',' ',num2str(dt(6))),...
       'Analytical Solution', 'Location','northeast')
title(['Comparison of ADAMS MOULTON approximations wtr time step ' ...
       'and analytical solution.'])
hold off


%% e) and f)
% Adams Moulton Linearization 1
% all Adams Moulton linearization1 aproximation values are calculated along with the
% error Er_AML1

set(0, 'DefaultFigurePosition', FigPosition{5})
figure('name','AM Linearization1');

for i=1:length(dt)
t = 0:dt(i):t_end;
p = Analyt_Sol(t);
y = AM_Lin1(p0,dt(i),t_end);
Er_AML1(i) = sqrt((dt(i)/5)*sum((y-p).^2));
plot(t,y,'Color',Color{i},'LineStyle','-')
hold on
end

plot(t,p,'Color',Color{length(dt)+1},'LineStyle','-')
axis([0,5,0,20]);
fprintf(['The following vector shows the errors obtained for comparing '...
         'the Adams Moulton with Linearization1 to the analytical sol. on different steps.\n']);
disp(Er_AML1)
xlabel('Time t')
legend(strcat('dt =',' ',num2str(dt(1))),...
       strcat('dt =',' ',num2str(dt(2))),...
       strcat('dt =',' ',num2str(dt(3))),...
       strcat('dt =',' ',num2str(dt(4))),...
	   strcat('dt =',' ',num2str(dt(5))),...
	   strcat('dt =',' ',num2str(dt(6))),...
       'Analytical Solution', 'Location','northeast')
title(['Comparison of Implicit Euler approximations wtr time step ' ...
       'and analytical solution.'])
hold off

% Adams Moulton Linearization 2
% all Adams Moulton linearization1 aproximation values are calculated along with the
% error Er_AML2

set(0, 'DefaultFigurePosition', FigPosition{6})
figure('name','AM Linearization2');

for i=1:length(dt)
t = 0:dt(i):t_end;
p = Analyt_Sol(t);
y = AM_Lin2(p0,dt(i),t_end);
Er_AML2(i) = sqrt((dt(i)/5)*sum((y-p).^2));
plot(t,y,'Color',Color{i},'LineStyle','-')
hold on
end

plot(t,p,'Color',Color{length(dt)+1},'LineStyle','-')
axis([0,5,0,20]);
fprintf(['The following vector shows the errors obtained for comparing '...
         'the Adams Moulton with Linearization2 to the analytical sol. on different steps.\n']);
disp(Er_AML2)
xlabel('Time t')
legend(strcat('dt =',' ',num2str(dt(1))),...
       strcat('dt =',' ',num2str(dt(2))),...
       strcat('dt =',' ',num2str(dt(3))),...
       strcat('dt =',' ',num2str(dt(4))),...
	   strcat('dt =',' ',num2str(dt(5))),...
	   strcat('dt =',' ',num2str(dt(6))),...
       'Analytical Solution', 'Location','northeast')
title(['Comparison of AM Linearization2 approximations wtr time step ' ...
       'and analytical solution.'])
hold off