function S = skew(v)
%SKEW Construct the cross-product matrix for a three-component vector.
%   SKEW(v) * w equals cross(v, w) for column vectors v and w.
    v = v(:);
    S = [0, -v(3), v(2); ...
         v(3), 0, -v(1); ...
         -v(2), v(1), 0];
end
