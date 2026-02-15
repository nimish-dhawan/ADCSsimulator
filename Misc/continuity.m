function q_smooth = continuity(q, q_ini)

persistent q_prev

if nargin <2
    q_ini = [0; 0; 0; 1];
end

if isempty(q_prev)
    q_prev = q_ini;
end

if dot(q, q_prev) < 0
    q_smooth = -q;
else
    q_smooth = q;
end

q_prev = q_smooth;

end