% Nimish Dhawan 2025
% MULTIPLICATIVE EXTENDED KALMAN FILTER
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Input(s)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% q_triad [4x1]: TRIAD attitude determination
% w_meas  [3x1]: Previous step measured rate 
% dt      [1x1]: Discrete time step
% s_I     [3x1]: Calculated Sun direction vector (ECI)
% s_B     [3x1]: Measured Sun direction vector (Body fixed)
% b_I     [3x1]: Calculated magnetic field vector (ECI)
% b_B     [3x1]: Measured magnetic field vector (Body fixed)
% R       [6x6]: Measurement covariance matrix
% sigma_g [1x1]: Random walk covariance
% sigma_b [1x1]: Bias covariance

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Output(s)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% q_est [4x1]: Current step postiori quaternion estimate
% w_est [3x1]: Current step postiori angular rate estimate

function [estimate] = mekf(q_triad, w_meas, dt, s_I, ...
                            b_I, s_B, b_B, R, sigma_g, sigma_b, inEclipse)

persistent bias P q was

estimate = struct;

% Initializing parameters
if isempty(q)
    q    = q_triad;
    bias = 1e-05*ones(3,1);
    P    = 0.000001*eye(6);
    was  = 0; 
end

r = zeros(6,1);
h = zeros(6,1);
H = zeros(6,6);
z = zeros(6,1);
K = zeros(6,6);

% Logic to update attitude after exiting eclipse
if (was == 1) && (inEclipse == 0)
    q = q_triad;
end

% Helper functions
quat2C = @(q) (q(4)^2-q(1:3)'*q(1:3))*eye(3) + 2*(q(1:3)*q(1:3)')...
               - 2*q(4)*skew(q(1:3));

% Forcing unit vectors
s_I = s_I/norm(s_I);
s_B = s_B/norm(s_B);
b_I = b_I/norm(b_I);
b_B = b_B/norm(b_B);

% ========================================================================
% Propagation

% Initializing
w_hat = w_meas - bias;
w_hat = w_hat(:);
w_hat = w_hat(1:3);

wn    = norm(w_hat);
w_sk  = skew(w_hat);

% Priori estimates using Eqs. (7.53)-(7.60) given by Crassidis and Junkins
if wn < 1e-8 % Small angle assumption
    psi = 0.5*dt*w_hat;
    XI = [eye(3)-skew(psi), psi; -psi', 1];
else
    theta = wn*dt;
    psi   = sin(0.5*theta)*w_hat/wn;
    XI = [cos(0.5*theta)*eye(3)-skew(psi), psi; -psi', cos(0.5*theta)];
end

q_minus = XI*q;
q_minus = q_minus/norm(q_minus);
b_minus = bias;

if wn < 1e-8 % Small angle assumption
    Phi11 = eye(3) - w_sk*dt;
    Phi12 = -eye(3)*dt;
else
    theta = wn*dt;
    Phi11 = eye(3) - (w_sk/wn)*sin(theta) + ...
            (w_sk*w_sk/wn^2)*(1-cos(theta));
    Phi12 = -eye(3)*dt - (w_sk*w_sk/wn^3)*(theta-sin(theta)) ...
            + (w_sk/wn^2)*(1-cos(theta));
end

Phi = [Phi11, Phi12; zeros(3,3), eye(3,3)];
Q11 = (sigma_g^2*dt + (sigma_b^2*dt^3)/3) * eye(3);
Q12 = -(sigma_b^2*dt^2/2) * eye(3);
Q22 = sigma_b^2*dt * eye(3);
Q   = [Q11, Q12; Q12, Q22];
G   = [-eye(3), zeros(3); zeros(3), eye(3)];

P_minus = Phi*P*Phi' + G*Q*G';

% ========================================================================
% Correction
C_BI = quat2C(q_minus);

if inEclipse == 0 % When not in eclipse, use both sensor data
    % Predicted Measurement
    h = [C_BI*s_I;
         C_BI*b_I];
    
    % Measurement Jacobian
    H = [skew(C_BI*s_I), zeros(3,3);
         skew(C_BI*b_I), zeros(3,3)];
    
    % Measurement
    z = [s_B;
         b_B];
    
    % Residual
    r = z - h;
    
    % Kalman Gain
    S = H*P_minus*H' + R;
    K = (P_minus * H') / S;
    
    dx_plus     = K*r;
    dth_plus    = dx_plus(1:3);
    db_plus     = dx_plus(4:6);
    
    P = P_minus * (eye(6) - K*H);

    % % Mahalanobis distance (complex sqrt)
    % dM2        = r.'*(S \ r);
    % dM         = sqrt(dM2);
    % isOutlier  = dM > chi2inv(0.997, length(r));
    % 
    % if isOutlier == 1
    %     P        = P_minus;
    %     dth_plus = [0;0;0];
    %     db_plus  = [0;0;0];
    % end

else % When in eclipse, only use magnetometer data
    % Predicted Measurement
    h(4:6) = C_BI*b_I;
    
    % Measurement Jacobian
    H(4:6,:) = [skew(C_BI*b_I), zeros(3,3)];
    
    % Measurement
    z(4:6) = b_B;
    
    % Residual
    r(4:6) = z(4:6) - h(4:6);
    
    % Kalman Gain
    S = H(4:6,:)*P_minus*H(4:6,:)' + R(4:6, 4:6);
    K(:,4:6) = (P_minus * H(4:6,:)') / S;
    
    dx_plus     = K(:,4:6)*r(4:6);
    dth_plus    = dx_plus(1:3);
    db_plus     = dx_plus(4:6);
    
    P = P_minus * (eye(6) - K(:,4:6)*H(4:6,:));

    % % Mahalanobis distance (complex sqrt)
    % dM2        = r.'*(S \ r);
    % dM         = sqrt(dM2);
    % isOutlier  = dM > chi2inv(0.997, length(r));
    % 
    % if isOutlier == 1
    %     P        = P_minus;
    %     dth_plus = [0;0;0];
    %     db_plus  = [0;0;0];
    % end

end


% ========================================================================
% Reset
q     = q_minus + 0.5 *...
        [q_minus(4)*eye(3)+skew(q_minus(1:3));
        -q_minus(1:3)'] * dth_plus;
q     = q / norm(q);
q     = continuity(q);
bias  = b_minus + db_plus;
was   = inEclipse;

estimate.q_est = q;

estimate.w_est = w_meas - bias;


end