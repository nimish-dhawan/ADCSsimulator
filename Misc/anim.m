%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% NIMISH DHAWAN
% anim
% This script allows to plot beautiful orbit and attitude plots and save
% them
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc
close all

% Helper Functions
tilde = @(E, Eta) [Eta*eye(3)-skew(E), E; -E', Eta];
quat2C = @(E, Eta) (Eta^2-E'*E)*eye(3) + 2*(E*E') - 2*Eta*skew(E);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Extracting Data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
t = simOut.tout;
Fb_axes = eye(3);   % columns = body x, y, z
Fb_att = zeros(3,3,length(t));
q = [q1, q2, q3, q4];

for i = 1:length(t)
    qv = -q(i,1:3)';
    qs = q(i,4);

    for k = 1:3
        mult = quat2C(qv, qs) * Fb_axes(:,k);
        Fb_att(:,k,i) = mult;
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% F_B wrt F_I figure
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure('Color',[1 1 1])
ax = axes; hold(ax,'on'); grid(ax,'on'); axis(ax,'equal'); view(ax,[45,20])
box(ax,'on'); set(ax,'FontSize',10,'FontName', 'Times');
xlabel('x [km]')
ylabel('y [km]')
zlabel('z [km]')
title('$\mathcal{F}_B$ with respect to $\mathcal{F}_I$', 'Interpreter', 'latex')
S = load('topo.mat','topo'); C = S.topo; 

Re = 0.8*6378;  % km
[Xe,Ye,Ze] = sphere(60);
earthSurf = surf(ax, Re*Xe, Re*Ye, Re*Ze, ...
    C, 'FaceColor','texturemap','EdgeAlpha', 0);
lighting(ax,'gouraud'); camlight(ax,'headlight');

orbanm = animatedline(ax,'LineWidth',1);

scale = 1000;   % km axis length
i = 1;
O = [simOut.X_ECI(:,:,i) simOut.Y_ECI(:,:,i) simOut.Z_ECI(:,:,i)];

hx = quiver3(ax,O(1),O(2),O(3), scale*Fb_att(1,1,i),scale*Fb_att(2,1,i),scale*Fb_att(3,1,i), ...
    0,'r','LineWidth',2,'AutoScale','off');
hy = quiver3(ax,O(1),O(2),O(3), scale*Fb_att(1,2,i),scale*Fb_att(2,2,i),scale*Fb_att(3,2,i), ...
    0,'g','LineWidth',2,'AutoScale','off');
hz = quiver3(ax,O(1),O(2),O(3), scale*Fb_att(1,3,i),scale*Fb_att(2,3,i),scale*Fb_att(3,3,i), ...
    0,'b','LineWidth',2,'AutoScale','off');

hxL = plot3(NaN,NaN,NaN,'r-','LineWidth',1);
hyL = plot3(NaN,NaN,NaN,'g-','LineWidth',1);
hzL = plot3(NaN,NaN,NaN,'b-','LineWidth',1);
trL = plot3(NaN,NaN,NaN,'k-','LineWidth',1);

legend([hxL,hyL,hzL,trL], ...
       {'+B_x','+B_y','+B_z','Orbit'}, ...
       'Location','northeast');

m = 8000; xlim(ax,[-m m]); ylim(ax,[-m m]); zlim(ax,[-m m]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% s/c bodyrates figure
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure('Color',[1,1,1])
wbAxis = axes; hold(wbAxis,'on'); grid(wbAxis,'on'); 
box(wbAxis,'on'); set(wbAxis,'FontSize',10,'FontName', 'Times');
set(gcf, 'Position', [200 500 500 200])
title('Measured Angular Velocity', 'Interpreter', 'latex')
xlabel('Time [s]')
ylabel('\omega_B [rad/s]')
xlim([t(1), t(end)])


wb1 = animatedline('Color','r');
wb2 = animatedline('Color','g');
wb3 = animatedline('Color','b');
wb  = [wb1 wb2 wb3];

legend([wb1, wb2, wb3], {'\omega_x','\omega_y','\omega_z'}, 'Location', 'best')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% s/c attitude figure
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure('Color',[1,1,1])
attAx = axes;
hold(attAx,'on'); grid(attAx,'on'); 
box(attAx,'on'); set(attAx,'FontSize',10,'FontName', 'Times');
set(gcf, 'Position', [200 750 500 200])
xlabel('Time [s]')
ylabel('q')
title('Attitude', 'Interpreter', 'latex')
xlim([t(1), t(end)])

q1an = animatedline('Color','r');
q2an = animatedline('Color','g');
q3an = animatedline('Color','b');
q4an = animatedline('Color','k');

legend([q1an, q2an, q3an, q4an],{'q_1', 'q_2', 'q_3', 'q_4'}, 'Location', 'Best')

set(gcf,'Color',[1 1 1])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plotting results
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% frames = cell(1, length(t));
for i = 1:50:length(t)
    orbPlot(simOut, Fb_att, scale, i, hx, hy, hz, orbanm)
    % frames{i} = getframe(gcf);
    % wBplot(simOut, wb, i, t)  
    % attPlot(q, i, q1an, q2an, q3an, q4an, t)
end


% v = VideoWriter('myAnimation.mp4','MPEG-4');
% v.FrameRate = 10;
% open(v)
% 
% for k = 1:numel(frames)
%     writeVideo(v, frames{k});
% end
% 
% close(v)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot functions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function wBplot(simOut, wb, i, t)
    addpoints(wb(1), t(i), simOut.w1_est(:,:,i))
    addpoints(wb(2), t(i), simOut.w2_est(:,:,i))
    addpoints(wb(3), t(i), simOut.w3_est(:,:,i))
end

function orbPlot(simOut, Fb_att, scale, i, hx, hy, hz, orbanm)
    O = [simOut.X_ECI(:,:,i) simOut.Y_ECI(:,:,i) simOut.Z_ECI(:,:,i)];

    set(hx,'XData',O(1),'YData',O(2),'ZData',O(3), ...
           'UData',scale*Fb_att(1,1,i),'VData',scale*Fb_att(2,1,i),'WData',scale*Fb_att(3,1,i));
    set(hy,'XData',O(1),'YData',O(2),'ZData',O(3), ...
           'UData',scale*Fb_att(1,2,i),'VData',scale*Fb_att(2,2,i),'WData',scale*Fb_att(3,2,i));
    set(hz,'XData',O(1),'YData',O(2),'ZData',O(3), ...
           'UData',scale*Fb_att(1,3,i),'VData',scale*Fb_att(2,3,i),'WData',scale*Fb_att(3,3,i));

    addpoints(orbanm, O(1),O(2),O(3));
    drawnow;
end

function attPlot(q, i, q1an, q2an, q3an, q4an, t)
    addpoints(q1an, t(i), q(i, 1))
    addpoints(q2an, t(i), q(i, 2))
    addpoints(q3an, t(i), q(i, 3))
    addpoints(q4an, t(i), q(i, 4))
end