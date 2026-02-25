% Nimish Dhawan, 2026

function generatePlot(app)

clc
close all

simOut = app.simOut;
t = simOut.tout;

%%
% Plotting angular velocity
figure()
subplot(3,1,1)
    plot(t, simOut.dataPacket.wsc1_est.Data, '-k')
    hold on
    plot(t, simOut.dataPacket.wsc1.Data, '--r')
    grid on
    xlim([t(1) t(end)])
    legend('Estimate', 'Ground Truth', 'Location','northeast','Orientation','horizontal')
    ylabel('\omega_x [rad/s]')

subplot(3,1,2)
    plot(t, simOut.dataPacket.wsc2_est.Data, '-k')
    hold on
    plot(t, simOut.dataPacket.wsc2.Data, '--r')
    grid on
    xlim([t(1) t(end)])
    ylabel('\omega_y [rad/s]')

subplot(3,1,3)
    plot(t, simOut.dataPacket.wsc3_est.Data, '-k')
    hold on
    plot(t, simOut.dataPacket.wsc3.Data, '--r')
    grid on
    xlim([t(1) t(end)])
    xlabel('Time [s]')
    ylabel('\omega_z [rad/s]')
theme(gcf,"light")

fontname('Times New Roman');
fontsize(10,"points");

% Plotting spacecraft attitude
figure()
subplot(4,1,1)
    plot(t, simOut.dataPacket.q1_est.Data, '-k')
    hold on
    plot(t, simOut.dataPacket.q1.Data, '--r')
    grid on
    xlim([t(1) t(end)])
    legend('Estimate', 'Ground Truth', 'Location','northeast','Orientation','horizontal')
    ylabel('q_1')

subplot(4,1,2)
    plot(t, simOut.dataPacket.q2_est.Data, '-k')
    hold on
    plot(t, simOut.dataPacket.q2.Data, '--r')
    grid on
    xlim([t(1) t(end)])
    ylabel('q_2')

subplot(4,1,3)
    plot(t, simOut.dataPacket.q3_est.Data, '-k')
    hold on
    plot(t, simOut.dataPacket.q3.Data, '--r')
    grid on
    xlim([t(1) t(end)])
    ylabel('q_3')

subplot(4,1,4)
    plot(t, simOut.dataPacket.q4_est.Data, '-k')
    hold on
    plot(t, simOut.dataPacket.q4.Data, '--r')
    grid on
    xlim([t(1) t(end)])
    xlabel('Time [s]')
    ylabel('q_4')
theme(gcf,"light")

fontname('Times New Roman');
fontsize(10,"points");

% Wheels angular momentum
figure()
subplot(3,1,1)
    plot(t, simOut.dataPacket.h1_wheels.Data, '-k')
    grid on
    xlim([t(1) t(end)])
    ylabel('h_{b,1} [N.m.s]')

subplot(3,1,2)
    plot(t, simOut.dataPacket.h2_wheels.Data, '-k')
    grid on
    xlim([t(1) t(end)])
    ylabel('h_{b,2} [N.m.s]')

subplot(3,1,3)
    plot(t, simOut.dataPacket.h3_wheels.Data, '-k')
    grid on
    xlim([t(1) t(end)])
    xlabel('Time [s]')
    ylabel('h_{b,3} [N.m.s]')
theme(gcf,"light")
fontname('Times New Roman');
fontsize(10,"points");

% Wheels angular velocity
figure()

subplot(3,1,1)
    plot(t, simOut.dataPacket.w1_wheels.Data, '-k')
    grid on
    xlim([t(1) t(end)])
    xlabel('Time [s]')
    ylabel('\omega_{b,1} [rad/s]')

subplot(3,1,2)
    plot(t, simOut.dataPacket.w2_wheels.Data, '-k')
    grid on
    xlim([t(1) t(end)])
    xlabel('Time [s]')
    ylabel('\omega_{b,2} [rad/s]')

subplot(3,1,3)
    plot(t, simOut.dataPacket.w3_wheels.Data, '-k')
    grid on
    xlim([t(1) t(end)])
    xlabel('Time [s]')
    ylabel('\omega_{b,3} [rad/s]')
theme(gcf,"light")

fontname('Times New Roman');
fontsize(10,"points");

% Command torque
figure()
subplot(3,1,1)
    plot(t, simOut.dataPacket.T1_cmd.Data, '-k')
    grid on
    xlim([t(1) t(end)])
    xlabel('Time [s]')
    ylabel('T_{b,1} [N·m]')

subplot(3,1,2)
    plot(t, simOut.dataPacket.T2_cmd.Data, '-k')
    grid on
    xlim([t(1) t(end)])
    xlabel('Time [s]')
    ylabel('T_{b,2} [N·m]')

subplot(3,1,3)
    plot(t, simOut.dataPacket.T3_cmd.Data, '-k')
    grid on
    xlim([t(1) t(end)])
    xlabel('Time [s]')
    ylabel('T_{b,3} [N·m]')
theme(gcf,"light")

fontname('Times New Roman');
fontsize(10,"points");

% Command current for torque rods
figure()
subplot(3,1,1)
plot(t, simOut.dataPacket.I_rod1.Data, '-k')
    grid on
    xlim([t(1) t(end)])
    xlabel('Time [s]')
    ylabel('I_{rod,1} [A]')

subplot(3,1,2)
    plot(t, simOut.dataPacket.I_rod2.Data, '-k')
    grid on
    xlim([t(1) t(end)])
    xlabel('Time [s]')
    ylabel('I_{rod,2} [A]')

subplot(3,1,3)
    plot(t, simOut.dataPacket.I_rod3.Data, '-k')
    grid on
    xlim([t(1) t(end)])
    xlabel('Time [s]')
    ylabel('I_{rod,3} [A]')
theme(gcf,"light")

fontname('Times New Roman');
fontsize(10,"points");

% Torque produced by the rod
figure()
subplot(3,1,1)
plot(t, simOut.dataPacket.T_rod1.Data, '-k')
    grid on
    xlim([t(1) t(end)])
    xlabel('Time [s]')
    ylabel('T_{rod,1} [N·m]')

subplot(3,1,2)
    plot(t, simOut.dataPacket.T_rod2.Data, '-k')
    grid on
    xlim([t(1) t(end)])
    xlabel('Time [s]')
    ylabel('T_{rod,2} [N·m]')

subplot(3,1,3)
    plot(t, simOut.dataPacket.T_rod3.Data, '-k')
    grid on
    xlim([t(1) t(end)])
    xlabel('Time [s]')
    ylabel('T_{rod,3} [N·m]')
theme(gcf,"light")

fontname('Times New Roman');
fontsize(10,"points");

% Plotting TRIAD determination vs. MEKF estimation
figure()
subplot(4,1,1)
    plot(t, simOut.dataPacket.q1_est.Data, '-k')
    hold on
    plot(t, simOut.dataPacket.q1_triad.Data, '--r')
    grid on
    xlim([t(1) t(end)])
    legend('MEKF', 'TRIAD', 'Location','northeast','Orientation','horizontal')
    ylabel('q_1')

subplot(4,1,2)
    plot(t, simOut.dataPacket.q2_est.Data, '-k')
    hold on
    plot(t, simOut.dataPacket.q2_triad.Data, '--r')
    grid on
    xlim([t(1) t(end)])
    ylabel('q_2')
    annotation("textarrow", [0.4047 0.5031], [0.6224 0.5647],...
                "String", "Eclipse", "FontName", "Times New Roman",...
                "FontWeight", "normal")

subplot(4,1,3)
    plot(t, simOut.dataPacket.q3_est.Data, '-k')
    hold on
    plot(t, simOut.dataPacket.q3_triad.Data, '--r')
    grid on
    xlim([t(1) t(end)])
    ylabel('q_3')

subplot(4,1,4)
    plot(t, simOut.dataPacket.q4_est.Data, '-k')
    hold on
    plot(t, simOut.dataPacket.q4_triad.Data, '--r')
    grid on
    xlim([t(1) t(end)])
    xlabel('Time [s]')
    ylabel('q_4')
theme(gcf,"light")

fontname('Times New Roman');
fontsize(10,"points");

% Plotting filter performance - quaternions
figure()
subplot(4,1,1)
    plot(t, squeeze(simOut.dataPacket.dq1.Data), 'k')
    grid on
    xlim([t(1) t(end)])
    ylabel('q_1')

subplot(4,1,2)
    plot(t, squeeze(simOut.dataPacket.dq2.Data), 'k')
    grid on
    xlim([t(1) t(end)])
    ylabel('q_2')

subplot(4,1,3)
    plot(t, squeeze(simOut.dataPacket.dq3.Data), 'k')
    grid on
    xlim([t(1) t(end)])
    ylabel('q_3')

subplot(4,1,4)
    plot(t, squeeze(simOut.dataPacket.dq4.Data), 'k')
    grid on
    xlim([t(1) t(end)])
    xlabel('Time [s]')
    ylabel('q_4')
theme(gcf,"light")

fontname('Times New Roman');
fontsize(10,"points");

% Plotting filter performance - angular velocity
figure()
subplot(3,1,1)
    plot(t, simOut.dataPacket.dw_x.Data, 'k')
    grid on
    xlim([t(1) t(end)])
    ylabel('d\omega_{x}')

subplot(3,1,2)
    plot(t, simOut.dataPacket.dw_y.Data, 'k')
    grid on
    xlim([t(1) t(end)])
    ylabel('d\omega_{y}')

subplot(3,1,3)
    plot(t, simOut.dataPacket.dw_z.Data, 'k')
    grid on
    xlim([t(1) t(end)])
    xlabel('Time [s]')
    ylabel('d\omega_{z}')
theme(gcf,"light")

fontname('Times New Roman');
fontsize(10,"points");

% Plotting perturbation torques
% Torque produced by the rod
figure()
subplot(3,1,1)
plot(t, simOut.dataPacket.TEX_x.Data, '-k')
    grid on
    xlim([t(1) t(end)])
    xlabel('Time [s]')
    ylabel('\tau_{ext,x} [N·m]')

subplot(3,1,2)
    plot(t, simOut.dataPacket.TEX_y.Data, '-k')
    grid on
    xlim([t(1) t(end)])
    xlabel('Time [s]')
    ylabel('\tau_{ext,y} [N·m]')

subplot(3,1,3)
    plot(t, simOut.dataPacket.TEX_z.Data, '-k')
    grid on
    xlim([t(1) t(end)])
    xlabel('Time [s]')
    ylabel('\tau_{ext,z} [N·m]')
theme(gcf,"light")

fontname('Times New Roman');
fontsize(10,"points");

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Display Output
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fprintf('\n--- Orbit Elements ---\n');
fprintf('a      = %.3f km\n', app.AltitudekmEditField.Value+app.rE);
fprintf('e      = %.5f\n', app.EccentricityEditField.Value);
fprintf('i      = %.3f deg\n', app.InclinationdegEditField.Value);
fprintf('w      = %.3f deg\n', app.ArgumentofPergieedegEditField.Value);
fprintf('raan   = %.3f deg\n', app.RAANdegEditField.Value);
fprintf('t      = %.3f sec\n', app.TimeofPerigeePassagesecEditField.Value);

fprintf('\n--- Scenario Epoch ---\n');
fprintf('(YYYY/MM/DD HH:MIN:SEC):\n  %04d/%02d/%02d  %02d:%02d:%02.3f\n', ...
        app.YYYY, app.MM, app.DD, app.HH, app.MIN, app.SEC);


fprintf('\n--- Simulation Parameters ---\n');
fprintf('K_d =\n');
fprintf('  %.6f  %.6f  %.6f\n', app.K_d(1,1), app.K_d(1,2), app.K_d(1,3));
fprintf('  %.6f  %.6f  %.6f\n', app.K_d(2,1), app.K_d(2,2), app.K_d(2,3));
fprintf('  %.6f  %.6f  %.6f\n', app.K_d(3,1), app.K_d(3,2), app.K_d(3,3));

fprintf('K_p =\n');
fprintf('  %.6f  %.6f  %.6f\n', app.K_p(1,1), app.K_p(1,2), app.K_p(1,3));
fprintf('  %.6f  %.6f  %.6f\n', app.K_p(2,1), app.K_p(2,2), app.K_p(2,3));
fprintf('  %.6f  %.6f  %.6f\n', app.K_p(3,1), app.K_p(3,2), app.K_p(3,3));

fprintf('K_w = %.0f\n', app.K_w);

fprintf('\nInitial s/c angular rate   = [%.4f, %.4f, %.4f] deg/s\n',...
        [app.wB_1; app.wB_2; app.wB_3]);

fprintf('Initial quaternion         = [%.4f, %.4f, %.4f, %.4f]\n',...
        [app.q1_ini; app.q2_ini; app.q3_ini; app.q4_ini]);

fprintf('Spacecraft inertia (kg/m2) =\n');
fprintf('  %.4f  %.4f  %.4f\n', app.J_body(1,1), app.J_body(1,2), app.J_body(1,3));
fprintf('  %.4f  %.4f  %.4f\n', app.J_body(2,1), app.J_body(2,2), app.J_body(2,3));
fprintf('  %.4f  %.4f  %.4f\n', app.J_body(3,1), app.J_body(3,2), app.J_body(3,3));


% Helper function to get max magnitude value
maxMag = @(x) max(abs([min(x), max(x)]));

% Angular Momentum (in mN·m·s)
maxMomentum = [maxMag(simOut.dataPacket.h1_wheels.Data), ... 
               maxMag(simOut.dataPacket.h2_wheels.Data), ...
               maxMag(simOut.dataPacket.h3_wheels.Data)] * 1e3;

% Control Torque (in mN·m)
maxTorque = [maxMag(simOut.dataPacket.T1_cmd.Data), ...
             maxMag(simOut.dataPacket.T2_cmd.Data), ...
             maxMag(simOut.dataPacket.T3_cmd.Data)] * 1e3;

% Spin Rate (in RPM)
maxSpeed_w = [maxMag(simOut.dataPacket.w1_wheels.Data), ... 
              maxMag(simOut.dataPacket.w2_wheels.Data), ...
              maxMag(simOut.dataPacket.w3_wheels.Data)] * 10.549297;

% Display results
fprintf('\n--- Wheels Performance ---\n');
fprintf('Maximum Angular Momentum Stored (each wheel)   = [%.4f %.4f %.4f] mN·m·s\n', maxMomentum);
fprintf('Maximum Control Torque Applied (each wheel)    = [%.6f %.6f %.6f] mN·m\n', maxTorque);
fprintf('Maximum Spin Rate (each wheel)                 = [%.3f %.3f %.3f] RPM\n', maxSpeed_w);


end
