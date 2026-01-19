% Nimish Dhawan
clc
close all

t = simOut.tout;

if plot_graph == true
%%
% Plotting angular velocity
figure(1)
formatfig()

subplot(3,1,1)
    plot(t, simOut.dataPacket.wsc1_est.Data, '-k')
    hold on
    plot(t, simOut.dataPacket.wsc1.Data, '-r')
    grid on
    xlim([t(1) t(end)])
    legend('Estimate', 'Ground Truth')
    xlabel('Time [s]')
    ylabel('\omega_x [rad/s]')

subplot(3,1,2)
    plot(t, simOut.dataPacket.wsc2_est.Data, '-k')
    hold on
    plot(t, simOut.dataPacket.wsc2.Data, '-r')
    grid on
    xlim([t(1) t(end)])
    xlabel('Time [s]')
    ylabel('\omega_y [rad/s]')

subplot(3,1,3)
    plot(t, simOut.dataPacket.wsc3_est.Data, '-k')
    hold on
    plot(t, simOut.dataPacket.wsc3.Data, '-r')
    grid on
    xlim([t(1) t(end)])
    xlabel('Time [s]')
    ylabel('\omega_z [rad/s]')


% Plotting spacecraft attitude
figure(2)
formatfig()

subplot(4,1,1)
    plot(t, simOut.dataPacket.q1_est.Data, '-k')
    hold on
    plot(t, simOut.dataPacket.q1.Data, '--r')
    grid on
    xlim([t(1) t(end)])
    legend('Estimate', 'Ground Truth')
    xlabel('Time [s]')
    ylabel('q_1')

subplot(4,1,2)
    plot(t, simOut.dataPacket.q2_est.Data, '-k')
    hold on
    plot(t, simOut.dataPacket.q2.Data, '--r')
    grid on
    xlim([t(1) t(end)])
    xlabel('Time [s]')
    ylabel('q_2')

subplot(4,1,3)
    plot(t, simOut.dataPacket.q3_est.Data, '-k')
    hold on
    plot(t, simOut.dataPacket.q3.Data, '--r')
    grid on
    xlim([t(1) t(end)])
    xlabel('Time [s]')
    ylabel('q_3')

subplot(4,1,4)
    plot(t, simOut.dataPacket.q4_est.Data, '-k')
    hold on
    plot(t, simOut.dataPacket.q4.Data, '--r')
    grid on
    xlim([t(1) t(end)])
    xlabel('Time [s]')
    ylabel('q_4')


% Wheels angular momentum
figure(3)
formatfig()

subplot(3,1,1)
    plot(t, simOut.dataPacket.h1_wheels.Data, '-k')
    grid on
    xlim([t(1) t(end)])
    xlabel('Time [s]')
    ylabel('h_{w,1} [N.m.s]')

subplot(3,1,2)
    plot(t, simOut.dataPacket.h2_wheels.Data, '-k')
    grid on
    xlim([t(1) t(end)])
    xlabel('Time [s]')
    ylabel('h_{w,2} [N.m.s]')

subplot(3,1,3)
    plot(t, simOut.dataPacket.h3_wheels.Data, '-k')
    grid on
    xlim([t(1) t(end)])
    xlabel('Time [s]')
    ylabel('h_{w,3} [N.m.s]')


% Wheels angular velocity
figure(4)
formatfig()

subplot(3,1,1)
    plot(t, simOut.dataPacket.w1_wheels.Data, '-k')
    grid on
    xlim([t(1) t(end)])
    xlabel('Time [s]')
    ylabel('\omega_{w,1} [rad/s]')

subplot(3,1,2)
    plot(t, simOut.dataPacket.w2_wheels.Data, '-k')
    grid on
    xlim([t(1) t(end)])
    xlabel('Time [s]')
    ylabel('\omega_{w,2} [rad/s]')

subplot(3,1,3)
    plot(t, simOut.dataPacket.w3_wheels.Data, '-k')
    grid on
    xlim([t(1) t(end)])
    xlabel('Time [s]')
    ylabel('\omega_{w,3} [rad/s]')


% Command torque
figure(5)
formatfig()

subplot(3,1,1)
    plot(t, simOut.dataPacket.T1_cmd.Data, '-k')
    grid on
    xlim([t(1) t(end)])
    xlabel('Time [s]')
    ylabel('T_{w,1} [N·m]')

subplot(3,1,2)
    plot(t, simOut.dataPacket.T2_cmd.Data, '-k')
    grid on
    xlim([t(1) t(end)])
    xlabel('Time [s]')
    ylabel('T_{w,2} [N·m]')

subplot(3,1,3)
    plot(t, simOut.dataPacket.T3_cmd.Data, '-k')
    grid on
    xlim([t(1) t(end)])
    xlabel('Time [s]')
    ylabel('T_{w,3} [N·m]')


end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Display Output
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fprintf('\n--- Orbit Elements ---\n');
fprintf('a      = %.3f km\n', app.AltitudekmEditField.Value+rE);
fprintf('e      = %.5f\n', app.EccentricityEditField.Value);
fprintf('i      = %.3f deg\n', app.idegEditField.Value);
fprintf('w      = %.3f deg\n', app.omegadegEditField.Value);
fprintf('raan   = %.3f deg\n', app.OmegadegEditField.Value);
fprintf('t      = %.3f sec\n', app.t_psecEditField.Value);

fprintf('\n--- Scenario Epoch ---\n');
fprintf('(YYYY/MM/DD HH:MIN:SEC):\n  %04d/%02d/%02d  %02d:%02d:%02.3f\n', ...
        YYYY, MM, DD, HH, MIN, SEC);


fprintf('\n--- Simulation Parameters ---\n');
fprintf('K_d                        = %.4f\n', K_d);
fprintf('K_p                        = %.4f\n', K_p);
fprintf('K_w                        = %.0f\n', K_w);
fprintf('Initial s/c angular rate   = [%.4f, %.4f, %.4f] deg/s\n', [wB_1; wB_2; wB_3]);
fprintf('Initial quaternion         = [%.4f, %.4f, %.4f, %.4f]\n', [q1_ini; q2_ini; q3_ini; q4_ini]);
fprintf('Spacecraft inertia (kg/m2) =\n');
fprintf('  %.4f  %.4f  %.4f\n', J_body(1,1), J_body(1,2), J_body(1,3));
fprintf('  %.4f  %.4f  %.4f\n', J_body(2,1), J_body(2,2), J_body(2,3));
fprintf('  %.4f  %.4f  %.4f\n', J_body(3,1), J_body(3,2), J_body(3,3));


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
              maxMag(simOut.dataPacket.w3_wheels.Data)] * 9.549297;

% Display results
fprintf('\n--- Wheels Performance ---\n');
fprintf('Maximum Angular Momentum Stored (each wheel)   = [%.4f %.4f %.4f] mN·m·s\n', maxMomentum);
fprintf('Maximum Control Torque Applied (each wheel)    = [%.6f %.6f %.6f] mN·m\n', maxTorque);
fprintf('Maximum Spin Rate (each wheel)                 = [%.3f %.3f %.3f] RPM\n', maxSpeed_w);

