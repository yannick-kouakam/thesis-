function q = getJointAngles(jh)
%GETJOINTANGLES Summary of this function goes here
%   Detailed explanation goes here
global  vrep; 

q= zeros(7,1);
 for iind=1:7
   [code, q(iind)] = vrep.simxGetJointPosition(vrep.clientID,jh(iind),vrep.simx_opmode_oneshot_wait);
 end
end

