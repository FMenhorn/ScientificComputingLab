clear all
%close all

Nx = [3 7 15 31];
Ny = [3 7 15 31];
dt = [1/64 1/128 1/256 1/512 1/1024 1/2048 1/4096];
dt2 = [64 128 256 512 2048 1024 4096];
tmax = [1/8 2/8 3/8 4/8];
plot_tmax = [1 2 3 4];

for k = 1:length(tmax)  % iterates over tmax
	f = figure('name' , strcat('tmax = ' , num2str(plot_tmax(k)) , '/8'));
					
		for m = 1:length(Nx) % iterates over Nx
			
			for n = 1:length(dt)  % iterates over dt
				
				titrmax = tmax / dt(n);
				hx = 1/(Nx(m) + 1);
				hy = 1/(Ny(m) + 1);

				X = ones(Nx(m), Ny(m));
				X = padarray(X,[1,1]);

					for t = 1:titrmax % iterates over dt
						
						X = ExEuler2D(X,dt(n));
% 					
					end % t loop

					subplot_tight(4,7,(length(dt)*(m-1)+n),0.03);
					surf(X)
					set(gcf, 'Position', get(0,'Screensize'));
					set(gcf,'renderer','painters');
					[Xmesh,Ymesh] = meshgrid(0:hx:1,0:hy:1);
					surf(Xmesh, Ymesh,X);
					
					if n==1
						zlabel(strcat('Nx=Ny=', num2str(Nx(m))),'fontweight','bold','fontsize',16);
					end
					if m==1
						title(strcat('dt=1/', num2str(dt2(n))),'fontweight','bold','fontsize',16);
					end
					
			end		% n loop
		end		% m loop
		
		saveas(f,strcat('Plots_tmax_',num2str(plot_tmax(k)),'per8.jpg'));
		
end % k loop


