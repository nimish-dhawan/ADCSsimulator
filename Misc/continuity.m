% Nimish Dhawan 2025
% QUATERNION CONTINUITY
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Input(s)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% q     [4x1] : Computed quaternion (vector first)
% q_ini [4x1] : Initial condition (default if not provided - [0;0;0;1];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Output(s)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% q_smooth [4x1] : Continuous quaternion profile

function q_smooth = continuity(q, q_ini)

%% Initializing
persistent q_prev

if nargin <2
    q_ini = [0; 0; 0; 1];
end

if isempty(q_prev)
    q_prev = q_ini;
end

%% Checking for discontinuity
if dot(q, q_prev) < 0
    q_smooth = -q;
else
    q_smooth = q;
end

q_prev = q_smooth;

end