function [] = fig_labeler(figure_array, t_end)
%PLOT_LABELER Summary of this function goes here
%   Detailed explanation goes here
for fig_index = 1:length(figure_array)
    figure(figure_array(fig_index));
%     set(gcf,'units','normalized','outerposition',[0 0 1 1]);
%     set(gcf,'PaperPositionMode','auto')
    suplabel(['Explicit Euler with t_{end}= ' num2str(t_end(fig_index))],'t');
    if (7~=exist('plots','dir'))
        mkdir('plots');
    end
    name = ['plots/ExplicitEuler_t=' num2str(t_end(fig_index)) '.png'];
    saveas(gcf,name);
end
end


