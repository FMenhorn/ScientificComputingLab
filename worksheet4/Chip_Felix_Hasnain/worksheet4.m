clear all
close all

Nx = [3 7 15 31];
Ny = [3 7 15 31];
dt = [1/64 1/128 1/256 1/512 1/1024 1/2048 1/4096];
tmax = [1/8 2/8 3/8 4/8];

plot_dt = [64 128 256 512 2048 1024 4096];  % Just for plotting
plot_tmax = [1 2 3 4];						% Just for plotting
%% Explicit Euler
% The following 4 nested for-loops iterate over
%   1) four different values of tmax, such that ONE figure represents a
%      temperature distribution at ONE given point in time
%   2) different grid sizes Nx*Ny
%   3) different time steps
%   4) the respective time interval
%
% The explicit euler function is called for each combination separately.

for k = 1:length(tmax)  % iterates over tmax

	f = figure('name' , strcat('Explicit Euler Method for Tmax = ' , num2str(plot_tmax(k)) , '/8'));
					
		for m = 1:length(Nx) % iterates over Nx
			
			for n = 1:length(dt)  % iterates over dt
				
				titrmax = tmax(k) / dt(n); % Determine no. of time steps
                % Determine spatial step sizes
				hx = 1/(Nx(m) + 1);
				hy = 1/(Ny(m) + 1);
                
                % Create the initial grid at t=0 with 1 (0 at boundaries)
				X = ones(Nx(m), Ny(m));
				X = padarray(X,[1,1]);

					for t = 1:titrmax % iterates over the time interval
						
						X = ExEuler2D(X,dt(n), Nx(m), Ny(m));
% 					
					end % t loop
                    
                    % Plot
					plot_index = length(dt)*(m-1)+n;
					if m==1 || n==1
						plot_margin = [0.04 0.04]; %vertical and horizontal margins
					else
						plot_margin = [0.03 0.03]; %vertical and horizontal margins
					end
					subplot_tight(4,7,(length(dt)*(m-1)+n),plot_margin);
					surf(X)
					set(gcf, 'Position', get(0,'Screensize'));
					set(gcf,'renderer','painters');
					set(gcf, 'Color', 'w')
					[Xmesh,Ymesh] = meshgrid(0:hx:1,0:hy:1);
					surf(Xmesh, Ymesh,X);
					
					if n==1
						zlabel(strcat('Nx=Ny=', num2str(Nx(m))));
					end %if
					if m==1
						title(strcat('dt=1/', num2str(plot_dt(n))));
                    end	%if
			end		% n loop
		end		% m loop
		
		saveas(f,strcat('Plots_ExEuler4Tmax_',num2str(plot_tmax(k)),'per8.jpg'));
		
end % k loop

%% Implicit Euler
% The following 3 nested for-loops iterate over
%
%   1) different grid sizes Nx*Ny
%   2) different time steps
%   3) the respective time interval
%
% The implicit euler function is called for each combination separately.

dt = 1/64;
plot_dt = 64;

f = figure('name' , strcat('Implicit Euler Method for dt = 1/' , ...
    num2str(plot_dt)));

for m = 1:length(Nx) % iterates over Nx	
					
		for k = 1:length(tmax)  % iterates over tmax	
				
				titrmax = tmax(k) / dt;
				hx = 1/(Nx(m) + 1);
				hy = 1/(Ny(m) + 1);

				X = ones(Nx(m), Ny(m));
				X = padarray(X,[1,1]);

					for t = 1:titrmax % iterates over dt
						
						X = ImEuler2D(X,dt);
% 					
					end % t loop
                    
                    % Plot
					plot_index = (length(tmax))*(m-1) + k;
					plot_margin = [0.05 0.05]; %vertical and horizontal margins
					subplot_tight(4, 4, plot_index, plot_margin);
					surf(X)
					set(gcf, 'Position', get(0,'Screensize'));
					set(gcf,'renderer','painters');
					set(gcf, 'Color', 'w')
					[Xmesh,Ymesh] = meshgrid(0:hx:1,0:hy:1);
					surf(Xmesh, Ymesh,X);
					
					if k==1
						zlabel(strcat('Nx=Ny=', num2str(Nx(m))));
					end
					if m==1
						title(strcat('Tmax = ', num2str(...
                            plot_tmax(k)),'/8'));
                    end		
		end					
end


saveas(f,strcat('Plots_ImEuler4Dt_1per', num2str(plot_dt),'.jpg'));
