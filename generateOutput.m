%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% NIMISH DHAWAN
% generateOutput
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc
close all

% =======================================================================
% ATTITUDE PROFILE

% Actual
q1 = squeeze(simOut.q1);
q2 = squeeze(simOut.q2);
q3 = squeeze(simOut.q3);
q4 = squeeze(simOut.q4);

% Desired
q1_des = squeeze(simOut.q1_des);
q2_des = squeeze(simOut.q2_des);
q3_des = squeeze(simOut.q3_des);
q4_des = squeeze(simOut.q4_des);

% =======================================================================
% ANGULAR RATES

% Body
w1_body = squeeze(simOut.w1_body);
w2_body = squeeze(simOut.w2_body);
w3_body = squeeze(simOut.w3_body);

w1_est = squeeze(simOut.w1_est);
w2_est = squeeze(simOut.w2_est);
w3_est = squeeze(simOut.w3_est);

w1_meas = squeeze(simOut.w1_meas);
w2_meas = squeeze(simOut.w2_meas);
w3_meas = squeeze(simOut.w3_meas);

% Wheels
w1_wheels = squeeze(simOut.w1_wheels);
w2_wheels = squeeze(simOut.w2_wheels);
w3_wheels = squeeze(simOut.w3_wheels);

% =======================================================================
% ANGULAR MOMENTUM
h1_w = squeeze(simOut.h1_w);
h2_w = squeeze(simOut.h2_w);
h3_w = squeeze(simOut.h3_w);

% =======================================================================
% CONTROL TORQUE
Tc_1 = squeeze(simOut.Tc_1);
Tc_2 = squeeze(simOut.Tc_2);
Tc_3 = squeeze(simOut.Tc_3);

% =======================================================================
% EULER ANGLES
roll    = squeeze(simOut.roll);
pitch   = squeeze(simOut.pitch);
yaw     = squeeze(simOut.yaw);

roll_err  = squeeze(simOut.roll_err);
pitch_err = squeeze(simOut.pitch_err);
yaw_err   = squeeze(simOut.yaw_err);

roll_est  = squeeze(simOut.roll_est);
pitch_est = squeeze(simOut.pitch_est);
yaw_est   = squeeze(simOut.yaw_est);

roll_meas  = squeeze(simOut.roll_meas);
pitch_meas = squeeze(simOut.pitch_meas);
yaw_meas   = squeeze(simOut.yaw_meas);

% =======================================================================
% POINTING MODES
mode = squeeze(simOut.mode);

% =======================================================================
% MAGNETIC DIPOLE MOMENT
m1 = squeeze(simOut.m_1);
m2 = squeeze(simOut.m_2);
m3 = squeeze(simOut.m_3);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Logging Simulation Output
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% write_output = 0;

outputName = [location, filename];

% Check if write_output is true
if write_output == 1
    % Open file for writing

    output = [tout, q1, q2, q3 q4, w1_body, w2_body, w3_body];

    fid = fopen(outputName, 'w');
    
    % Write the header block
    fprintf(fid, 'stk.v.12.0\n');
    fprintf(fid, 'BEGIN Attitude\n');
    fprintf(fid, 'ScenarioEpoch           21 Jun 2025 00:00:00.000000000\n'); % Change the Beginning Date
    fprintf(fid, 'NumberOfAttitudePoints  %d\n', size(output,1));
    fprintf(fid, 'BlockingFactor          20\n');
    fprintf(fid, 'InterpolationOrder      1\n');
    fprintf(fid, 'CentralBody             Earth\n');
    fprintf(fid, 'CoordinateAxes          J2000\n');
    fprintf(fid, 'AttitudeTimeQuatAngVels\n');
    
    % Write the matrix data: each row = time q1 q2 q3 q4 w1 w2 w3
    for i = 1:size(output,1)
        fprintf(fid, '%21.13e %21.13e %21.13e %21.13e %21.13e %21.13e %21.13e %21.13e\n', ...
            output(i,1), output(i,2), output(i,3), output(i,4), output(i,5), ...
            output(i,6), output(i,7), output(i,8));
    end
    
    % Close file
    fclose(fid);
    
    fprintf('\nOutput file generated. \n');

else
    fprintf('\nNo output file generated. \n');
end

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plotting Output
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plot_graph = 1;

if plot_graph == 1

    close all
    
    % =======================================================================
    % SPACECRAFT ATTITUDE vs DESIRED ATTITUDE
    
    time = tout/3600;
    xlimit = [time(1), time(end)];

    figure('Name','Spacecraft Attitude')
    subplot(4,1,1)
    plot(time, q1_des, LineStyle=":", LineWidth=1.25, Color='b')
    hold on
    plot(time, q1, LineWidth=0.75, Color='b')
    % xlabel('Hours')
    ylabel('q_1')
    xlim(xlimit);
    title('Spacecraft Attitude')
    legend('Desired','Actual')   
    hold off
    
    subplot(4,1,2)
    plot(time, q2_des, LineStyle=":", LineWidth=1.25, Color='b')
    hold on
    plot(time, q2, LineWidth=0.75, Color='b')
    % xlabel('Hours')
    ylabel('q_2')
    xlim(xlimit);
    % title('Spacecraft Attitude')
    legend('Desired','Actual')   
    hold off
    
    subplot(4,1,3)
    plot(time, q3_des, LineStyle=":", LineWidth=1.25, Color='b')
    hold on
    plot(time, q3, LineWidth=0.75, Color='b')
    % xlabel('Hours')
    ylabel('q_3')
    xlim(xlimit);
    % title('Spacecraft Attitude')
    legend('Desired','Actual')   
    hold off
    
    subplot(4,1,4)
    plot(time, q4_des, LineStyle=":", LineWidth=1.25, Color='b')
    hold on
    plot(time, q4, LineWidth=0.75, Color='b')
    xlabel('Hours')
    xlim(xlimit);
    ylabel('q_4')
    % title('Spacecraft Attitude')
    legend('Desired','Actual')   
    hold off
    
    % =======================================================================
    % WHEELS DATA
    
    % Angular Rates
    figure
    subplot(3,1,1)
    plot(time, w1_wheels*9.549297, LineWidth=1, Color="b")
    % xlabel('Hours')
    xlim(xlimit);
    ylabel('\omega_{W_1} (RPM)')
    title('Wheels Angular Rates')
    
    subplot(3,1,2)
    plot(time, w2_wheels*9.549297, LineWidth=1, Color="b")
    % xlabel('Hours')
    xlim(xlimit);
    ylabel('\omega_{W_2} (RPM)')
    % title('Wheels Angular Rates')
    
    subplot(3,1,3)
    plot(time, w3_wheels*9.549297, LineWidth=1, Color="b")
    xlabel('Hours')
    xlim(xlimit);
    ylabel('\omega_{W_3} (RPM)')
    % title('Wheels Angular Rates')
    
    
    % Angular Momentum
    figure('Name','Wheels Angular Momentum')
    subplot(3,1,1)
    plot(time, h1_w*1e03, LineWidth=1, Color="b")
    % xlabel('Hours')
    xlim(xlimit);
    ylabel('h_{W_1} (mNms)')
    title('Wheels Angular Momentum')
    
    subplot(3,1,2)
    plot(time, h2_w*1e03, LineWidth=1, Color="b")
    % xlabel('Hours')
    xlim(xlimit);
    ylabel('h_{W_2} (mNms)')
    % title('Wheels Angular Momentum')
    
    subplot(3,1,3)
    plot(time, h3_w*1e03, LineWidth=1, Color="b")
    xlabel('Hours')
    xlim(xlimit);
    ylabel('h_{W_3} (mNms)')
    % title('Wheels Angular Momentum')
    
    % Control Torque
    figure('Name','Wheels Control Torque')
    subplot(3,1,1)
    plot(time, Tc_1*1e03, LineWidth=1, Color='b')
    % xlabel('Hours')
    xlim(xlimit);
    ylabel('\tau_{C_1} (mNm)')
    title('Control Torque')
    
    subplot (3,1,2)
    plot(time, Tc_2*1e03, LineWidth=1, Color='b')
    % xlabel('Hours')
    xlim(xlimit);
    ylabel('\tau_{C_2} (mNm)')
    % title('Control Torque')
    
    subplot(3,1,3)
    plot(time, Tc_3*1e03, LineWidth=1, Color='b')
    xlabel('Hours')
    xlim(xlimit);
    ylabel('\tau_{C_3} (mNm)')
    % title('Control Torque')
    
    % =======================================================================
    % POINTING ERROR
    pnt_err = squeeze(simOut.pointing_err);
    
    % figure
    % ax = subplot(2,1,1);
    % plot(ax, time, pnt_err, LineWidth=0.75, Color='b')
    % ylim(ax, [-0.25, 0.25])
    % addModeShading(ax, time, mode);
    % xlabel('Hours')
    % ylabel('\theta_{error} (Deg)')
    % title('Pointing Error')
    % legend('\theta_e', 'Nadir', 'Sun')
    
    figure('Name','Total Pointing Error')
    plot(time, pnt_err, LineWidth=0.75, Color='b')
    yline(5,'--r','5^{\circ} error')
    ylim([0, 10])
    % addModeShading(ax, time, mode);
    xlabel('Hours')
    xlim(xlimit);
    ylabel('\theta_{error} (Deg)')
    title('Pointing Error')
    
    
    % =======================================================================
    % EXTERNAL TORQUE
    T_ext = squeeze(simOut.T_ext);
    
    figure
    plot(time, T_ext, LineWidth=1, Color="b")
    xlabel('Hours')
    xlim(xlimit);
    ylabel('\tau_{ext} (Nm)')
    title('External Torque')
    
    % =======================================================================
    % BODY SPIN RATES
    
    figure('Name','Spacecraft Body Rates')
    subplot(3,1,1)
    plot(time, w1_body*57.2958, LineWidth=1, Color="b")
    % xlabel('Hours')
    xlim(xlimit);
    ylabel('\omega_{B_x} (deg/s)')
    title('Body Angular Rates')
    
    subplot(3,1,2)
    plot(time, w2_body*57.2958, LineWidth=1, Color="b")
    % xlabel('Hours')
    xlim(xlimit);
    ylabel('\omega_{B_y} (deg/s)')
    % title('Body Angular Rates')
    
    subplot(3,1,3)
    plot(time, w3_body*57.2958, LineWidth=1, Color="b")
    xlabel('Hours')
    xlim(xlimit);
    ylabel('\omega_{B_z} (deg/s)')
    % title('Wheels Angular Rates')

    % Estimates vs. True states
    figure('Name','Spacecraft Estimated vs. True Angular Body Rates')
    subplot(3,1,1)
    plot(time, w1_est*57.2958, LineWidth=1, Color="k")
    hold on
    plot(time, w1_body*57.2958, LineWidth=1, Color="b")
    xlim(xlimit);
    ylabel('\omega_{B_x} (deg/s)')
    legend('Estimated State', 'True State')
    title('Spacecraft Estimated vs. True Angular Body Rates')
    
    subplot(3,1,2)
    plot(time, w2_est*57.2958, LineWidth=1, Color="k")
    hold on
    plot(time, w2_body*57.2958, LineWidth=1, Color="b")
    xlim(xlimit);
    ylabel('\omega_{B_y} (deg/s)')
    legend('Estimated State', 'True State')
    
    subplot(3,1,3)
    plot(time, w3_est*57.2958, LineWidth=1, Color="k")
    hold on
    plot(time, w3_body*57.2958, LineWidth=1, Color="b")
    xlabel('Hours')
    xlim(xlimit);
    ylabel('\omega_{B_z} (deg/s)')
    legend('Estimated State', 'True State')
    

    % =======================================================================
    % EULER ANGLES

    % Attitude
    figure('Name','Spacecraft Euler Angles')
    
    ax1 = subplot(3,1,1);
    plot(ax1, time, roll, LineWidth=1, Color='b')
    addModeShading(ax1, time, mode);
    ylabel('Roll (deg)')
    xlim(xlimit);
    title('Spacecraft Attitude')
    legend("\phi", "Nadir", "Sun", Location='northeastoutside')
    
    ax2 = subplot(3,1,2);
    plot(ax2, time, pitch, LineWidth=1, Color='b')
    addModeShading(ax2, time, mode);
    ylabel('Pitch (deg)')
    xlim(xlimit);
    legend("\theta", "Nadir", "Sun", Location='northeastoutside')
    
    ax3 = subplot(3,1,3);
    plot(ax3, time, yaw, LineWidth=1, Color='b')
    addModeShading(ax3, time, mode);
    ylabel('Yaw (deg)')
    xlabel('Hours')
    xlim(xlimit);
    legend("\psi", "Nadir", "Sun", Location='northeastoutside')
    
    
    % Error (zoomed)
    figure('Name','Pointing Error')
    
    ax4 = subplot(3,1,1);
    plot(ax4, time, roll_err, LineWidth=1, Color='b')
    ylim(ax4, [-5 5])
    addModeShading(ax4, time, mode);
    ylabel('Roll (deg)')
    xlim(xlimit);
    title('Error (Zoomed)')
    yline(2,'--r','2^{\circ} error');
    yline(-2,'--r');
    legend("\phi", "Nadir", "Sun", Location='northeastoutside')
    
    ax5 = subplot(3,1,2);
    plot(ax5, time, pitch_err, LineWidth=1, Color='b')
    ylim(ax5, [-5 5])
    addModeShading(ax5, time, mode);
    xlim(xlimit);
    ylabel('Pitch (deg)')
    yline(2,'--r','2^{\circ} error');
    yline(-2,'--r');
    legend("\theta", "Nadir", "Sun", Location='northeastoutside')
    
    ax6 = subplot(3,1,3);
    plot(ax6, time, yaw_err, LineWidth=1, Color='b')
    xlim(xlimit);
    ylim(ax6, [-5 5])
    addModeShading(ax6, time, mode);
    ylabel('Yaw (deg)')
    xlabel('Hours')
    yline(2,'--r','2^{\circ} error');
    yline(-2,'--r');
    legend("\psi", "Nadir", "Sun", Location='northeastoutside')

    % Estimated vs. True Attitude
    figure
    subplot(3,1,1)
    plot(time, roll_est, LineWidth=1, Color='b')
    hold on
    plot(time, roll, '--r', LineWidth=1)
    legend('Estimated State', 'True State')
    ylabel('Roll (deg)')
    title('Spacecraft Estimated vs. True Attitude')

    subplot(3,1,2)
    plot(time, pitch_est, LineWidth=1, Color='b')
    hold on
    plot(time, pitch, '--r', LineWidth=1)
    legend('Estimated State', 'True State')
    ylabel('Pitch (deg)')

    subplot(3,1,3)
    plot(time, yaw_est, LineWidth=1, Color='b')
    hold on
    plot(time, yaw, '--r', LineWidth=1)
    legend('Estimated State', 'True State')
    ylabel('Yaw (deg)')
    xlabel('Hours')

    % =======================================================================
    % MAGNETIC DIPOLE MOMENT
    
    figure('Name','Magnetic Dipole')
    subplot(3,1,1)
    plot(time, m1, Color='b')
    ylabel('m_1 (Am^2)')
    xlim(xlimit);
    title('Command Magnetic Dipole Moment')
    
    subplot(3,1,2)
    plot(time, m2, Color='b')
    xlim(xlimit);
    ylabel('m_2 (Am^2)')
     
    subplot(3,1,3)
    plot(time, m3, Color='b')
    xlim(xlimit);
    ylabel('m_3 (Am^2)')
    xlabel('Hours')

end

    
    
    
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Display Output
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fprintf('\n--- Orbit Elements ---\n');
fprintf('a      = %.3f km\n', app.AltitudekmEditField.Value+rE);
fprintf('e      = %.5f\n', app.EccentricityEditField.Value);
fprintf('i      = %.3f deg\n', app.idegEditField.Value);
fprintf('w      = %.3f deg\n', app.omegadegEditField.Value);
fprintf('raan   = %.3f deg\n', app.omegadegEditField.Value);
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
maxMomentum = [maxMag(h1_w), maxMag(h2_w), maxMag(h3_w)] * 1e3;

% Control Torque (in mN·m)
maxTorque = [maxMag(Tc_1), maxMag(Tc_2), maxMag(Tc_3)] * 1e3;

% Spin Rate (in RPM)
maxSpeed_w = [maxMag(w1_wheels), maxMag(w2_wheels), maxMag(w3_wheels)] * 9.549297;

% Display results
fprintf('\n--- Wheels Performance ---\n');
fprintf('Maximum Angular Momentum Stored (each wheel)   = [%.4f %.4f %.4f] mN·m·s\n', maxMomentum);
fprintf('Maximum Control Torque Applied (each wheel)    = [%.6f %.6f %.6f] mN·m\n', maxTorque);
fprintf('Maximum Spin Rate (each wheel)                 = [%.3f %.3f %.3f] RPM\n', maxSpeed_w);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Helper Function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Helper function to shade based on pointing mode
    function addModeShading(ax, time, mode)
        hold(ax, 'on');
        mode = mode(:); time = time(:);
        changeIdx = [1; find(diff(mode) ~= 0) + 1; length(mode) + 1];
        yLimits = ylim(ax);
    
        for i = 1:length(changeIdx)-1
            idx1 = changeIdx(i);
            idx2 = changeIdx(i+1) - 1;
            xStart = time(idx1);
            xEnd = time(idx2);
    
            if mode(idx1) == 1
                c = [1 0.85 0.4];  % light yellow for sun
            else
                c = [0.4 0.6 0.9];  % light blue for nadir
            end
    
            fill(ax, [xStart xEnd xEnd xStart], ...
                     [yLimits(1) yLimits(1) yLimits(2) yLimits(2)], ...
                     c, 'EdgeColor', 'none', 'FaceAlpha', 0.3);
        end
    end

