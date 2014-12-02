clear all
%close all

Nx = [3 7 15 31];
Ny = [3 7 15 31];
dt = 1/64;
plot_dt = 64;
tmax = [1/8 2/8 3/8 4/8];
plot_tmax = [1 2 3 4];

f = figure('name' , strcat('Implicit Euler Method for dt = 1/' , num2str(plot_dt)));

for m = 1:length(Nx) % iterates over Nx	
					
		for k = 1:length(tmax)  % iterates over tmax	
				
				titrmax = tmax / dt;
				hx = 1/(Nx(m) + 1);
				hy = 1/(Ny(m) + 1);

				X = ones(Nx(m), Ny(m));
				X = padarray(X,[1,1]);

					for t = 1:titrmax % iterates over dt
						
						X = ImEuler2D(X,dt);
% 					
					end % t loop

					plot_index = (length(tmax))*(m-1) + k;
					plot_space = 0.03;
					subplot_tight(4, 4, plot_index, plot_space);
					surf(X)
					set(gcf, 'Position', get(0,'Screensize'));
					set(gcf,'renderer','painters');
					[Xmesh,Ymesh] = meshgrid(0:hx:1,0:hy:1);
					surf(Xmesh, Ymesh,X);
					
					if k==1
						zlabel(strcat('Nx=Ny=', num2str(Nx(m))),'fontweight','bold','fontsize',16);
					end
					if m==1
						title(strcat('Tmax = ', num2str(plot_tmax(k)),'/8'),'fontweight','bold','fontsize',16);
					end
						
		end		
		
		
		
end % 


saveas(f,strcat('ImplicitEulerForDt_1per', num2str(plot_dt),'.jpg'));