function trans = getTransform(pos)
%GETTRANSFORM Summary of this function goes here
%   Detailed explanation goes here
  R = Rx(pos(4))*Ry(pos(5))*Rz(pos(6));
  R(1:3,4) = pos(1:3);
  trans = R;
end

