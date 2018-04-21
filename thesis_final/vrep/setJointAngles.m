function code = setJointAngles(clientID,jh,q)
%SETJOINTANGLES Summary of this function goes here
%   Detailed explanation goes here
global vrep;
for i=1:7
 %code=vrep.simxSetJointTargetPosition( clientID, jh(i), q(i), vrep.simx_opmode_streaming);
  signalValue=vrep.simxPackFloats(q);
 code= vrep.simxSetStringSignal(clientID,'TargetPosition',signalValue,vrep.simx_opmode_oneshot_wait);
 
end
end

