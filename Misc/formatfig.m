%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nimish Dhawan
% 6th January 2026
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% =========================================================================
% Description:
% =========================================================================
% Resizes the current figure to match the desired scale. To make consistent
% subfigures, the width scaling factors of the two subfigures must sum to 
% 0.9 or less, AND the height scaling factor for ALL figures must be equal.
% Provide the linewidth in inches if it is known. The default linewidth is 
% 7 inches. For consistency, use this defined width scale in LaTeX:
% \includegraphics[width=width\linewidth]{...} 
% =========================================================================
% Examples:
% =========================================================================
% Use before plot() function and after figure function:
% Ex.1 --------------------------------------------------------------------
% figure
% formatfig() -> uses default width, height and linewidth
% plot(...)
% Ex.2 --------------------------------------------------------------------
% figure
% formatfig(0.4) -> uses default height and linewidth
% plot(...)
% Ex.3 --------------------------------------------------------------------
% figure
% formatfig(0.4,0.6) -> uses default linewidth
% plot(...)
% Ex.4 --------------------------------------------------------------------
% figure
% formatfig(0.4,0.6,8) -> all user defined arguments
% plot(...)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Input(s)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% width     : width scaling factor
% height    : height scaling factor
% linewidth : linewidth of the page in inches

function formatfig(width, height, linewidth)

% Location of the figure on screen from left bottom 
location = [1,1];

if nargin < 1 || isempty(width)
    width = 0.8;
end

if nargin < 2 || isempty(height)
    height = 0.8;
end

if nargin < 3 || isempty(linenwidth)
    linewidth = 7;
end

scale = [width*linewidth, height*linewidth];

set(gcf, 'Units', 'inches', 'Position', [location, scale])
set(gcf, 'DefaultAxesFontName', 'Times', ...
         'DefaultAxesFontSize', 10, 'DefaultTextFontName',...
         'Times', 'DefaultTextFontSize', 9);
% set(gcf, ...
%     'Color', 'w', ...
%     'DefaultAxesColor', 'w', ...
%     'DefaultTextColor', 'k', ...
%     'DefaultAxesXColor', 'k', ...
%     'DefaultAxesYColor', 'k', ...
%     'DefaultAxesZColor', 'k', ...
%     'DefaultLineColor', 'k');

end