A = open('shadow.fig');
export_fig('shadow', '-pdf','-transparent');


% A = open('initialHand.fig');
% set(gcf,'windowstyle','normal');
% positionscale=[100 100 300 200];
% paperwidth=3.5;
% paperheight=2.5;
% linewidth=1.5;
% 
% % set(findobj('Type','line','Color','y', 'LineStyle', '-'),'Color','b', 'LineStyle', ':','LineWidth',linewidth);
% % set(findobj('Type','line','Color','g', 'LineStyle', '-'),'Color','r', 'LineStyle', '-.','LineWidth',linewidth);
% % set(findobj('Type','line','Color','r', 'LineStyle', '-'),'Color','k', 'LineStyle', '--','LineWidth',linewidth);
% % set(findobj('Type','line','Color','k', 'LineStyle', '-'),'Color','y', 'LineStyle', ':','LineWidth',linewidth);
% % set(findobj('Type','line','Color','b', 'LineStyle', '-'),'Color','g', 'LineStyle', '-','LineWidth',linewidth);
% 
% % set(gca, 'FontName', 'Consolas', 'FontSize', 4, 'FontWeight','bold');
% % legend('IF(man)','AS(man)','IF(woman)', 'AS(woman)', '+sunlight', 'Location','SouthEast');
% % title('');
% % xlabel('Width of the scenario (Unit:m)', 'FontName', 'Consolas', 'FontSize', 8, 'FontWeight','bold');
% % ylabel('Length of the scenario (Unit:m)', 'FontName', 'Consolas', 'FontSize', 8, 'FontWeight','bold');
% 
% set(gcf, 'PaperPosition', [0 0 paperwidth paperheight ]); 
% set(gcf, 'PaperSize', [paperwidth paperheight]); 
% set(gcf, 'position', positionscale);
% 
% export_fig('initialHand', '-pdf','-transparent');
% 
% A = open('candidate.fig');
% set(gcf,'windowstyle','normal');
% 
% set(gcf, 'PaperPosition', [0 0 paperwidth paperheight ]); 
% set(gcf, 'PaperSize', [paperwidth paperheight]); 
% set(gcf, 'position', positionscale);
% export_fig('candidate', '-pdf','-transparent');
% 
% A = open('complementCandidate.fig');
% set(gcf,'windowstyle','normal');
% 
% set(gcf, 'PaperPosition', [0 0 paperwidth paperheight ]); 
% set(gcf, 'PaperSize', [paperwidth paperheight]); 
% set(gcf, 'position', positionscale);
% export_fig('complementCandidate', '-pdf','-transparent');
% 
% A = open('distribution.fig');
% set(gcf,'windowstyle','normal');
% 
% set(gcf, 'PaperPosition', [0 0 paperwidth paperheight ]); 
% set(gcf, 'PaperSize', [paperwidth paperheight]); 
% set(gcf, 'position', positionscale);
% export_fig('distribution', '-pdf','-transparent');
% 
% A = open('pruneCandidate.fig');
% set(gcf,'windowstyle','normal');
% 
% set(gcf, 'PaperPosition', [0 0 paperwidth paperheight ]); 
% set(gcf, 'PaperSize', [paperwidth paperheight]); 
% set(gcf, 'position', positionscale);
% export_fig('pruneCandidate', '-pdf','-transparent');
% 
% A = open('fingerFinal.fig');
% set(gcf,'windowstyle','normal');
% 
% set(gcf, 'PaperPosition', [0 0 paperwidth paperheight ]); 
% set(gcf, 'PaperSize', [paperwidth paperheight]); 
% set(gcf, 'position', positionscale);
% export_fig('fingerFinal', '-pdf','-transparent');