function q = quatmult(q1,q2)

q = [q1(4)*eye(3)-skew(q1(1:3)), q1(1:3); -q1(1:3)', q1(4)] * q2;

end