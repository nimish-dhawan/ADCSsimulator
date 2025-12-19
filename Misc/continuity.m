function q_smooth = continuity(q, q_prev)

    if dot(q, q_prev) < 0
        q_smooth = -q;
    else
        q_smooth = q;
    end
end