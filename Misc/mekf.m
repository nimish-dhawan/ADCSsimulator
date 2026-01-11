% Nimish Dhawan 2025
% MULTIPLICATIVE EXTENDED KALMAN FILTER
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Input(s)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% q_pre   [4x1]: Previous step postiori quaternion estimate
% w_meas  [3x1]: Previous step measured rate (or current??)
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
% q_plus [4x1]: Current step postiori quaternion estimate
% w_plus [3x1]: Current step postiori angular rate estimate

function [q_plus, w_plus] = mekf(q_pre, w_meas, dt, s_I, ...
                                b_I, s_B, b_B, R, sigma_g, sigma_b)

persistent bias P

if isempty(bias)
    bias = 1e-05*ones(3,1);
end

if isempty(P)
    P = 0.000001*eye(6);
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

wn = norm(w_hat);
W  = skew(w_hat);

% Priori estimates using Eqs. (7.53)-(7.60) given by Crassidis and Junkins
if wn < 1e-8
    % Small angle assumption
    psi = 0.5*dt*w_hat;
    OMEGA = [eye(3)-skew(psi), psi;
            -psi',            1];
else
    theta = wn*dt;
    psi   = sin(0.5*theta)*w_hat/wn;
    OMEGA = [cos(0.5*theta)*eye(3)-skew(psi), psi; -psi', cos(0.5*theta)];
end

q_minus = OMEGA*q_pre;
q_minus = q_minus/norm(q_minus);
b_minus = bias;

if wn < 1e-8
    % Small angle assumption
    Phi11 = eye(3) - W*dt;
    Phi12 = -eye(3)*dt;
else
    theta = wn*dt;
    Phi11 = eye(3) - (W/wn)*sin(theta) + (W*W/wn^2)*(1-cos(theta));
    Phi12 = -eye(3)*dt - (W*W/wn^3)*(theta-sin(theta)) + (W/wn^2)*(1-cos(theta));
end

% Phi11 = eye(3) - (1/norm(w_hat))*skew(w_hat)*sin(theta) + ...
%         (1/norm(w_hat))^2*skew(w_hat)^2*(1-cos(theta));
% Phi12 = -eye(3)*dt - (1/norm(w_hat))^3*skew(w_hat)^2*(theta-sin(theta))...
%          + (1/norm(w_hat))^2*skew(w_hat)*(1-cos(theta));

Phi   = [Phi11, Phi12; zeros(3,3), eye(3,3)];

Q11 = (sigma_g^2*dt + (sigma_b^2*dt^3)/3) * eye(3);
Q12 = -(sigma_b^2*dt^2/2) * eye(3);
Q22 = sigma_b^2*dt * eye(3);
Q   = [Q11, Q12; Q12, Q22];
G   = [-eye(3), zeros(3); zeros(3), eye(3)];

P_minus = Phi*P*Phi' + G*Q*G';

% ========================================================================
% Correction
C_BI = quat2C(q_minus);

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
% P = (eye(6) - K*H) * P_minus * (eye(6) - K*H)' + K*R*K';

% ========================================================================
% Reset
q_plus = q_minus + 0.5 *...
    [q_minus(4)*eye(3)+skew(q_minus(1:3)); -q_minus(1:3)'] * dth_plus;
q_plus = q_plus / norm(q_plus);
bias = b_minus + db_plus;
w_plus = w_meas - bias;

end