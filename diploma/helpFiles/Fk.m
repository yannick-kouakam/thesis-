function pos = Fk(robot,config)
%FK Summary of this function goes here
%   Detailed explanation goes here
pos = zeros(6,1);
H= getTransform(robot ,config','iiwa_link_ee');
pos(1:3)=H(1:3,3);
pos(4) =asin(H(3,1));
if H(3,3)~=0
 pos(5) =atan2(H(3,3),H(3,2));
end
if H(2,1)~=0
 pos(6) =atan2(H(2,1),H(1,1));
end
end

