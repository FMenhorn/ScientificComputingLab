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
Er_AdMol = zeros(1, length(dt));			% App. Error of Adams Moulton method
Er_AML1 = zeros(1, length(dt));				% App. Error of Adams Moulton Linearization-1
Er_AML2 = zeros(1, length(dt));				% App. Error of Adams Moulton Linearization-2
% Color definition matrix for graphs
Color = {[1 1 0], [1 0 1], [0 1 1], [1 0 0], [0 1 0], [0 0 1], [0 0 0]};
% Figure position matrix for figures
FigPosition = {[66 277 512 384], [436 278 512 384], [855 278 512 384], ...
               [66 1 512 384], [434 1 512 384],[855 1 512 384]};

%% a)

%p = 20;                                  % Y axis value limits
t = linspace(t_end,0);
close all
set(0, 'DefaultFigurePosition', FigPosition{1})
figure('name','Analytical Solution');
plot(t,Analyt_Sol(t));                   % Plotted p(t) in a graph
axis([0,t_end,0,p0]);
xlabel('Time t');
ylabel('p(t)');
title('Analytical Solution');

fprintf('Program paused. Proceed with Task b). Press enter to continue.\n\n');
pause;

%% b)

% Explicit Euler
% all Explicit Euler approximation values are calculated along with the
% error E_Ex_Eul (see task g))

%Global layout and display configuration
set(0, 'DefaultFigurePosition', FigPosition{1})
close all
figure('name','Explicit Euler');

%Explicit Euler for all dt's
for i=1:length(dt)
t = 0:dt(i):t_end;
p = Analyt_Sol(t);

y = Euler(f,p0,dt(i),t_end);                    %Euler calculation
Er_ExEul(i) = sqrt((dt(i)/5)*sum((y-p).^2));    %Error calculation
plot(t,y,'Color',Color{i},'LineStyle','-')      %Plot formating
hold on
end

%Printing results
plot(t,p,'Color',Color{length(dt)+1},'LineStyle','-')
axis([0,t_end,0,p0]);

%Labeling
xlabel('Time t')
ylabel('p(t)')
legend(strcat('Explicit Euler with dt =',' ',num2str(dt(1))),...
       strcat('Explicit Euler with dt =',' ',num2str(dt(2))),...
       strcat('Explicit Euler with dt =',' ',num2str(dt(3))),...
       strcat('Explicit Euler with dt =',' ',num2str(dt(4))),...
	   strcat('Explicit Euler with dt =',' ',num2str(dt(5))),...
	   strcat('Explicit Euler with dt =',' ',num2str(dt(6))),...
       'Analytical Solution', 'Location','northeast')
title(['Comparison of Explicit Euler approximations wrt time step ' ...
       'and analytical solution.'])
hold off

% Heun
% all Heun approximation values are calculated along with the
% error Er_Heun

set(0, 'DefaultFigurePosition', FigPosition{2})
figure('name','Heun');

% Heun Calculaitons
for i=1:length(dt)
t = 0:dt(i):t_end;
p = Analyt_Sol(t);

y = Heun(f,p0,dt(i),t_end);                 %Heun Calculation
Er_Heun(i) = sqrt((dt(i)/5)*sum((y-p).^2)); %Deviation error calculation
plot(t,y,'Color',Color{i},'LineStyle','-')  %Plot for all dt results
hold on
end

%Analytical solution Plot
plot(t,p,'Color',Color{length(dt)+1},'LineStyle','-')
axis([0,t_end,0,p0]);

xlabel('Time t');
ylabel('p(t)');
legend(strcat('Heun with dt =',' ',num2str(dt(1))),...
       strcat('Heun with dt =',' ',num2str(dt(2))),...
       strcat('Heun with dt =',' ',num2str(dt(3))),...
       strcat('Heun with dt =',' ',num2str(dt(4))),...
	   strcat('Heun with dt =',' ',num2str(dt(5))),...
	   strcat('Heun with dt =',' ',num2str(dt(6))),...
       'Analytical Solution', 'Location','northeast')
title(['Comparison of Heun approximations wrt time step ' ...
       'and analytical solution.'])
hold off

fprintf('Program paused. Proceed with Task b). Press enter to continue.\n\n');
pause;

%% c) and d)
% Implicit Euler
% all Implicit Euler aproximation values are calculated along with the
% error Er_ImEul

%Figure layout
set(0, 'DefaultFigurePosition', FigPosition{3})
figure('name','Implicit Euler');

%Implicit Euler Calculations
for i=1:length(dt)
t = 0:dt(i):t_end;
p = Analyt_Sol(t);
y = Im_Eul(f,D_f,p0,dt(i),t_end);
Er_ImEul(i) = sqrt((dt(i)/5)*sum((y-p).^2));
plot(t,y,'Color',Color{i},'LineStyle','-') 
hold on
end

%Printing results
plot(t,p,'Color',Color{length(dt)+1},'LineStyle','-')
axis([0,t_end,0,p0]);

xlabel('Time t')
ylabel('p(t)')
legend(strcat('dt =',' ',num2str(dt(1))),...
       strcat('dt =',' ',num2str(dt(2))),...
       strcat('dt =',' ',num2str(dt(3))),...
       strcat('dt =',' ',num2str(dt(4))),...
	   strcat('dt =',' ',num2str(dt(5))),...
	   strcat('dt =',' ',num2str(dt(6))),...
       'Analytical Solution', 'Location','northeast')
title(['Comparison of Implicit Euler approximations wrt time step ' ...
       'and analytical solution.'])
hold off


% Adams Moulton
% all Adams Moulton approximation values are calculated along with the
% error Er_AdMol

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
axis([0,t_end,0,p0]); % Increase the yscale to track instable behaviour

xlabel('Time t')
ylabel('p(t)')
legend(strcat('dt =',' ',num2str(dt(1))),...
       strcat('dt =',' ',num2str(dt(2))),...
       strcat('dt =',' ',num2str(dt(3))),...
       strcat('dt =',' ',num2str(dt(4))),...
	   strcat('dt =',' ',num2str(dt(5))),...
	   strcat('dt =',' ',num2str(dt(6))),...
       'Analytical Solution', 'Location','northeast')
title(['Comparison of ADAMS MOULTON approximations wrt time step ' ...
       'and analytical solution.'])
hold off

fprintf('Program paused. Proceed with Task e). Press enter to continue.\n\n');
pause;

%% e) and f)
% Adams Moulton Linearization 1
% all Adams Moulton linearization1 approximation values are calculated along with the
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
axis([0,t_end,0,p0]);

xlabel('Time t')
ylabel('p(t)')
legend(strcat('dt =',' ',num2str(dt(1))),...
       strcat('dt =',' ',num2str(dt(2))),...
       strcat('dt =',' ',num2str(dt(3))),...
       strcat('dt =',' ',num2str(dt(4))),...
	   strcat('dt =',' ',num2str(dt(5))),...
	   strcat('dt =',' ',num2str(dt(6))),...
       'Analytical Solution', 'Location','northeast')
title(['Comparison of First Linearised Adams Moulton approximations wrt ' ...
       'time step and analytical solution.'])
hold off

% Adams Moulton Linearization 2
% all Adams Moulton linearization1 aproximation values are calculated along with the
% error Er_AML2

t_end = 30;	% JFT (Increased time frame to observe "long time" behaviour)

set(0, 'DefaultFigurePosition', FigPosition{6})
figure('name','AM Linearization2');

%plug and play liniarisation formula
for i=1:length(dt)
t = 0:dt(i):t_end;
p = Analyt_Sol(t);
y = AM_Lin2(p0,dt(i),t_end);
Er_AML2(i) = sqrt((dt(i)/5)*sum((y-p).^2));
plot(t,y,'Color',Color{i},'LineStyle','-')
hold on
end

%Printing results
plot(t,p,'Color',Color{length(dt)+1},'LineStyle','-')
axis([0,t_end,0,p0]);

xlabel('Time t')
ylabel('p(t)')
legend(strcat('dt =',' ',num2str(dt(1))),...
       strcat('dt =',' ',num2str(dt(2))),...
       strcat('dt =',' ',num2str(dt(3))),...
       strcat('dt =',' ',num2str(dt(4))),...
	   strcat('dt =',' ',num2str(dt(5))),...
	   strcat('dt =',' ',num2str(dt(6))),...
       'Analytical Solution', 'Location','northeast')
title(['Comparison of AM Linearization2 approximations wrt time step ' ...
       'and analytical solution.'])
hold off

fprintf('Program paused. Proceed with Task g). Press enter to continue.\n\n');
pause;
%% Task g)
% The following errors have been obtained from the calculations performed
% in task b) and d).

fprintf(['The following vector shows the errors obtained for comparing '...
         'the explicit euler approximation to the analytical sol. on different steps.\n']);
disp(Er_ExEul)

fprintf(['The following vector shows the errors obtained for comparing '...
         'the Heun approximation to the analytical sol. on different steps.\n']);
disp(Er_Heun)

fprintf(['The following vector shows the errors obtained for comparing '...
         'the implicit euler approximation to the analytical sol. on different steps.\n']);
disp(Er_ImEul)

fprintf(['The following vector shows the errors obtained for comparing '...
         'the Adams Moulton approximation to the analytical sol. on different steps.\n']);
disp(Er_AdMol)

fprintf(['The following vector shows the errors obtained for comparing '...
         'the Adams Moulton with Linearization1 to the analytical sol. on different steps.\n']);
disp(Er_AML1)

fprintf(['The following vector shows the errors obtained for comparing '...
         'the Adams Moulton with Linearization2 to the analytical sol. on different steps.\n']);
disp(Er_AML2)

%% Task h)
% The following error factors have been obtained from the calculations
% performed in task b).

fprintf('Error Factors for Explicit Euler method: \n');
Er_ExEul_Factor = Er_ExEul(1:end-1)./Er_ExEul(2:end);
disp(Er_ExEul_Factor)

fprintf('Error Factors for Heun method: \n');
Er_Heun_Factor = Er_Heun(1:end-1)./Er_Heun(2:end);
disp(Er_Heun_Factor)

fprintf('Error Factors for Implicit Euler method: \n');
Er_ImEul_Factor = Er_ImEul(1:end-1)./Er_ImEul(2:end);
disp(Er_ImEul_Factor)

fprintf('Error Factors for Adam Moulton method: \n');
Er_AdMol_Factor = Er_AdMol(1:end-1)./Er_AdMol(2:end);
disp(Er_AdMol_Factor)

fprintf('Error Factors for First Linearised AM method: \n');
Er_AML1_Factor = Er_AML1(1:end-1)./Er_AML1(2:end);
disp(Er_AML1_Factor)

fprintf('Error Factors for Second Linearised AM method: \n');
Er_AML2_Factor = Er_AML2(1:end-1)./Er_AML2(2:end);
disp(Er_AML2_Factor)

fprintf('Program paused. Proceed with Task e). Press enter to continue.\n\n');
pause;

%% Output all information
close all;
%set(0, 'DefaultFigurePosition', FigPosition{1})
f1 = figure('name','Explicit Euler Data');
cnames = {'dt = 1', 'dt = 1/2', 'dt = 1/4', ...
          'dt = 1/8', 'dt = 1/16', 'dt = 1/32'};
rnames = {'Error', 'Error Factor'};
EulerTable = uitable(f1,'Data',[Er_ExEul;[0,Er_ExEul_Factor]],...
                'ColumnName',cnames, 'RowName', rnames);
%Euler = array2table([dt;Er_ExEul;[0,Er_ExEul_Factor]])