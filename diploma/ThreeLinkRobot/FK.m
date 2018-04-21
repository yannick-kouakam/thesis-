function pos = FK(joints)
%FK Summary of this function goes here
%   Detailed explanation goes here
% computer the forward kinematic of a 3 link manipulator
H0= HT(joints(1),2);
H1=  HT(joints(2),2.5);
H2 =  HT(joints(3),1.5);

H =H0*H1*H2;
pos =H(1:3,4);
end

