clc
close all


x_I = simOut.dataPacket.x_I.Data;
y_I = simOut.dataPacket.y_I.Data;
z_I = simOut.dataPacket.z_I.Data;


quat2C = @(q) (q(4)^2-q(1:3)'*q(1:3))*eye(3) + 2*(q(1:3)*q(1:3)')...
               - 2*q(4)*skew(q(1:3));


fig = figure(); fig.Visible = "on";
axis equal; grid on; box on; view([30,20]); theme('light');

[V,F] = drawsc();

hPatch = patch('Vertices', V, ...
                  'Faces', F, ...
                  'FaceColor', 'w', ...
                  'FaceAlpha', 0.9, ...
                  'EdgeColor', 'k');
hold on

xlabel('X_{ECI}'); ylabel('Y_{ECI}'); zlabel('Z_{ECI}')
Rview = 0.3;

q = [simOut.dataPacket.q1_est.Data,...
     simOut.dataPacket.q2_est.Data,...
     simOut.dataPacket.q3_est.Data,...
     simOut.dataPacket.q4_est.Data];
t = simOut.tout;

rate = 30;
frames = numel(1:rate:length(t));

mv(frames) = struct('cdata',[],'colormap',[]);

ax = gca; ax.FontName = 'Times New Roman'; ax.FontSize = 9;

idx = 0;
for k = 1:rate:length(t)
    idx = idx+1;
    C_BI = quat2C(q(k,:)');
    C_IB = C_BI.';

    V_rot = (C_IB * V.').' + [x_I(k), y_I(k), z_I(k)];
    set(hPatch, 'Vertices', V_rot)

    xlim(x_I(k) + [-Rview Rview])
    ylim(y_I(k) + [-Rview Rview])
    zlim(z_I(k) + [-Rview Rview])

    title(['Time Elapsed: ', num2str(t(k)), ' sec'])
    drawnow limitrate
    mv(idx) = getframe(fig); 
end

%%
% fig.Visible = 'on';
% mv = mv(1:idx);
% movie(fig,mv);

%%

function [V,F] = drawsc()
    cm2m = 1/200; 
    xlen = 30*cm2m; ylen = 10*cm2m; zlen = 10*cm2m;

    V = [-xlen/2  -ylen/2  -zlen/2
         -xlen/2  -ylen/2   zlen/2
         -xlen/2   ylen/2  -zlen/2
         -xlen/2   ylen/2   zlen/2
          xlen/2  -ylen/2  -zlen/2
          xlen/2  -ylen/2   zlen/2
          xlen/2   ylen/2  -zlen/2
          xlen/2   ylen/2   zlen/2];

    F = [1 2 4 3     % -X face
         5 6 8 7     % +X face
         1 2 6 5     % -Y face
         3 4 8 7     % +Y face
         1 3 7 5     % -Z face
         2 4 8 6];   % +Z face

end
