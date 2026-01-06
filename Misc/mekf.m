function [q_plus, b_plus, P_plus] = mekf(q_pre, w_meas, b_pre, dt, s_I, ...
                                b_I, s_B, b_B, R, sigma_g, sigma_b, P_pre)
% Nimish Dhawan 2025

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Input(s)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Output(s)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tilde  = @(E, Eta) [Eta*eye(3)-skew(E), E; -E', Eta];
qBox   = @(E, Eta) [Eta*eye(3)+skew(E), E; -E', Eta];
qDot   = @(q, w) 0.5 * qBox(q(1:3), q(4)) * [w(:); 0];
quat2C = @(E, Eta) (Eta^2-E'*E)*eye(3) + 2*(E*E') - 2*Eta*skew(E);

s_I = s_I/norm(s_I);
s_B = s_B/norm(s_B);
b_I = b_I/norm(b_I);
b_B = b_B/norm(b_B);

% ========================================================================
% Propagation
w_hat = w_meas - b_pre;
w_hat = w_hat(1:3);
db    = zeros(3,1);          % Mean is zero, covariance accounted for in Q

% phi = norm(w_hat)*dt;
% phi = (w_hat)*dt/100;
phi = zeros(3,1);
dq  = [0.5*phi; 1];

% q_minus is quat multipication of q_predicted using q_pre
k1 = qDot(q_pre          , w_hat);
k2 = qDot(q_pre+0.5*k1*dt, w_hat);
k3 = qDot(q_pre+0.5*k2*dt, w_hat);
k4 = qDot(q_pre+k3*dt    , w_hat);

q_pred = q_pre + (dt/6)*(k1+2*k2+2*k3+k4); 
q_pred = q_pred/norm(q_pred);

% Priori Estimates
q_minus = tilde(dq(1:3), dq(4)) * q_pred;
q_minus = q_minus/norm(q_minus);
b_minus = b_pre + db;

theta = norm(w_hat) * dt;

Phi11 = eye(3) - (1/norm(w_hat))*skew(w_hat)*sin(theta) + ...
        (1/norm(w_hat))^2*skew(w_hat)^2*(1-cos(theta));
Phi12 = -eye(3)*dt - (1/norm(w_hat))^2*skew(w_hat)^3*(theta-sin(theta)) + ...
        (1/norm(w_hat))*skew(w_hat)^2*(1-cos(theta));
Phi   = [Phi11, Phi12; zeros(3,3), eye(3,3)];

% Q11 = (sigma_g^2*dt + sigma_b^2*dt^3/3) * eye(3);
% Q12 = -(sigma_b^2*dt^2/2) * eye(3);
% Q22 = sigma_b^2*dt * eye(3);
% Q   = [Q11, Q12; Q12, Q22];

G  = [-eye(3), zeros(3);
      zeros(3), eye(3)];
Qc = blkdiag((sigma_g^2)*eye(3), (sigma_b^2)*eye(3));
Q  = G*Qc*G'*dt; 

% Priori Covariance
P_minus = Phi*P_pre*Phi' + Q;

% ========================================================================
% Correction
C_BI = quat2C(q_minus(1:3), q_minus(4));

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
% r = [skew(z(1:3))*h(1:3);
%      skew(z(4:6))*h(4:6)];
r = z - h;

% Kalman Gain
S = H*P_minus*H' + R;
K = (P_minus * H') / S;

dx_plus     = K*r;
dth_plus    = dx_plus(1:3);
dq_plus     = [0.5*dth_plus; 1];
dq_plus     = dq_plus / norm(dq_plus);
db_plus     = dx_plus(4:6);

P_plus = P_minus * (eye(6) - K*H);
% P_plus = (eye(6) - K*H) * P_minus * (eye(6) - K*H)' + K*R*K';

% Reset
q_plus = tilde(dq_plus(1:3), dq_plus(4)) * q_minus;
q_plus = q_plus / norm(q_plus);
b_plus = b_minus + db_plus;


end