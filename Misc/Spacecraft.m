clc; close all

% --- Dimensions (meters) ---
bus = [0.10 0.10 0.10];     % [Lx Ly Lz] cube
panel = struct();
panel.L = 0.30;             % panel length
panel.W = 0.10;             % panel width
panel.th = 0.005;           % panel thickness
panel.gap = 0.02;           % gap from bus

% --- Figure / axes ---
fig = figure('Color','w'); 
theme('light');
ax = axes('Projection','perspective');
hold(ax,'on'); grid(ax,'on'); axis(ax,'equal');
xlabel(ax,'X'); ylabel(ax,'Y'); zlabel(ax,'Z');
view(ax, 35, 20);
box(ax, "on");
axis(ax,'off')

% --- Colors ---
col.bus   = [0.92 0.92 0.92];
col.edge  = [0.10 0.10 0.10];
col.panel = [0.60 0.60 0.60];

% --- Draw bus (cube) centered at origin ---
drawBox(ax, bus, [0 0 0], eye(3), col.bus, col.edge, 0.9);

% --- Draw two panels attached to +/-X faces ---
% Panel local box dims: [thickness (x), width (y), length (z)] in its own frame
panelDims = [panel.th, panel.W, panel.L];

% +X panel: place it outside +X face
Rpx = [0,0,1;1,0,0;0,1,0];  % Rotation matrix for +X panel
c_plus = [ bus(1)/2 + panel.gap + panel.L/2, 0, 0];
drawBox(ax, panelDims, c_plus, Rpx, col.panel, col.edge, 0.95);
dimpx = [bus(1)/2, 0, 0; bus(1)/2 + panel.gap, 0, 0];
drawLine(ax, dimpx, [0,0,0]);

% -X panel
Rmx = [0,0,1;1,0,0;0,1,0];  % Rotation matrix for +X panel
c_minus = [-bus(1)/2 - panel.gap - panel.L/2, 0, 0];
drawBox(ax, panelDims, c_minus, Rmx, col.panel, col.edge, 0.95);
dimmx = [-bus(1)/2, 0, 0; -bus(1)/2 - panel.gap, 0, 0];
drawLine(ax, dimmx, [0,0,0]);

% --- Final camera / limits ---
lim = 0.5;
xlim(ax,[-lim lim]); ylim(ax,[-lim lim]); zlim(ax,[-lim lim]);

% ========================= Helper: draw a box with patch =========================
function drawBox(ax, dims, center, R, faceColor, edgeColor, faceAlpha)
% dims = [Lx Ly Lz] in the box local frame
Lx = dims(1); Ly = dims(2); Lz = dims(3);

% 8 vertices in local coordinates (centered at origin)
V = 0.5 * [
   -Lx -Ly -Lz;
   -Lx -Ly  Lz;
   -Lx  Ly -Lz;
   -Lx  Ly  Lz;
    Lx -Ly -Lz;
    Lx -Ly  Lz;
    Lx  Ly -Lz;
    Lx  Ly  Lz];

% Rotate + translate
Vw = (R * V')' + center;

% Faces (each row is a quad of vertex indices)
F = [
    1 3 4 2;   % -X
    5 6 8 7;   % +X
    1 2 6 5;   % -Y
    3 7 8 4;   % +Y
    1 5 7 3;   % -Z
    2 4 8 6];  % +Z

patch(ax,'Vertices',Vw,'Faces',F, ...
    'FaceColor',faceColor,'FaceAlpha',faceAlpha, ...
    'EdgeColor',edgeColor,'LineWidth',1.1);
end

function drawLine(ax, dim, color)

line(ax, "XData", dim(:,1), "YData", dim(:,2), "ZData", dim(:,3), ...
     "Color", color, 'LineWidth', 1);

end

