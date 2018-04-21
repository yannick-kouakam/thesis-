function code = setJointTorque(torque,jh)
%SETJOINTTORQUE Summary of this function goes here
%   Detailed explanation goes here
global vrep ;
   for i=1:7
      code=vrep.simxSetJointForce( vrep.clientID,jh(i), torque(i),  vrep.simx_opmode_oneshot);
   end
end

