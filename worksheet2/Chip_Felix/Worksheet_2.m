%% Variables

dif_p = @(p) 7*(1-p/10)*9;					% ODE
p0 = 20;									% Initial value
t_end = 5;									% end time
Analyt_Sol = @(t) 200./(20-10*exp(-7.*t));  % Analytical Solution
Er_ExEul = zeros(length(dt));				% App. Error of Explicit Euler method
Er_Heun = zeros(1, length(dt));				% App. Error of method of Heun


%% a)

p = 20;                                  % Y axis value limits
t = linspace(t_end,0);
plot(t,Analyt_Sol(t));                   % Plotted p(t) in a graph

%% b)

dt = [1 1/2 1/4 1/8 1/16 1/32];

% Hasnian: @Chip I have put your code in comments and changed the output parammeter of Euler function. You can revert it back
% by uncommenting the code section.

% eu_mat = zeros(t_end/dt(6),length(dt));
% for i = 6 : 1 
%    eu_mat(:, i) = Euler(grow(), p0,dt(i),t_end);
%    %TODO vectors must be the same length to plot Note:  why doesn't this return
%    %the correct value matrix, what am i missing? the valaues arnt even
%    %writen into the matrix eu_mat
%    %TODO fix for iteration so that a matrix is created with all Euler
%    %values
%    
%    % Chip: my personal goal is to have a matrix that contains all solution values
%    % listed in rows for every resolution
%	 % Hasnain: It is a good idea to keep the record of solutions. It would
%	 be a bit tricky to store the vectors of different length in one
%	 matrix. We shall discuss it further.
%    
% end

% length(t) used to trouble shoot. returns 100. standard linspace value?
%plot(t / p,y);

% Color definition matrix for graphs
Color = {[1 1 0], [1 0 1], [0 1 1], [1 0 0], [0 1 0], [0 0 1], [0 0 0]};

% Explicit Euler
% all Explicit Euler aproximation values are calculated along with the
% error E_Ex_Eul

figure;

for i=1:length(dt)
t = 0:dt(i):t_end;
p = Analyt_Sol(t);

y = Euler(dif_p,p0,dt(i),t_end)
Er_ExEul(i) = sqrt((dt(i)/5)*sum((y-p).^2));
plot(t,y,'Color',Color{i},'LineStyle','-')
hold on
end
plot(t,p,'Color',Color{length(dt)+1},'LineStyle','-')
axis([0,5,0,20]);
fprintf(['The following vector shows the errors obtained for comparing '...
         'the euler approximation to the analytical sol. on different steps.\n']);
Er_ExEul
plot(t,p,'Color',Color{length(dt)+1},'LineStyle','-')
xlabel('Time t')
legend(strcat('Explicit Euler with dt =',' ',num2str(dt(1))),...
       strcat('Explicit Euler with dt =',' ',num2str(dt(2))),...
       strcat('Explicit Euler with dt =',' ',num2str(dt(3))),...
       strcat('Explicit Euler with dt =',' ',num2str(dt(4))),...
	   strcat('Explicit Euler with dt =',' ',num2str(dt(5))),...
	   strcat('Explicit Euler with dt =',' ',num2str(dt(6))),...
       'Analytical Solution', 'Location','northwest')
title(['Comparison of Explicit Euler approximations with respect to time step ' ...
       'and analytical solution.'])
hold off
fprintf('Program paused. Press enter to continue.\n\n');
pause;

% Explicit Euler
% all Explicit Euler aproximation values are calculated along with the
% error E_Ex_Eul

figure;

for i=1:length(dt)
t = 0:dt(i):t_end;
p = Analyt_Sol(t);

y = Euler(dif_p,p0,dt(i),t_end)
Er_Heun(i) = sqrt((dt(i)/5)*sum((y-p).^2));
plot(t,y,'Color',Color{i},'LineStyle','-')
hold on
end
plot(t,p,'Color',Color{length(dt)+1},'LineStyle','-')
axis([0,5,0,20]);
fprintf(['The following vector shows the errors obtained for comparing '...
         'the euler approximation to the analytical sol. on different steps.\n']);
Er_Heun
plot(t,p,'Color',Color{length(dt)+1},'LineStyle','-')
xlabel('Time t')
legend(strcat('Heun with dt =',' ',num2str(dt(1))),...
       strcat('Heun with dt =',' ',num2str(dt(2))),...
       strcat('Heun with dt =',' ',num2str(dt(3))),...
       strcat('Heun with dt =',' ',num2str(dt(4))),...
	   strcat('Heun with dt =',' ',num2str(dt(5))),...
	   strcat('Heun with dt =',' ',num2str(dt(6))),...
       'Analytical Solution', 'Location','northwest')
title(['Comparison of Heun approximations with respect to time step ' ...
       'and analytical solution.'])
hold off
fprintf('Program paused. Press enter to continue.\n\n');
pause;

