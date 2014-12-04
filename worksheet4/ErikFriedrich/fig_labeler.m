function [] = fig_labeler(figure_array, t_end)
%FIG_LABELER labels the given figures from figure_array and saves them
% INPUT:
%       figure_array:   array holding handles to figures
%       t_end:          end time (used for labeling)
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


