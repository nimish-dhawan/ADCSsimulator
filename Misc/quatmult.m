% Nimish Dhawan 2025
% QUATERNION MULTIPLICATION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Input(s)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% q1 [4x1] : First quaternion (vector first)
% q2 [4x1] : Second quaternion
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Output(s)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% q  [4x1] : Quaternion quantizing the successive rotations

function q = quatmult(q1,q2)

q = [q1(4)*eye(3)-skew(q1(1:3)), q1(1:3); -q1(1:3)', q1(4)] * q2;

end