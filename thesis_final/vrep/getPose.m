function position = getPose(clientID,handle)
%GETPOSE Summary of this function goes here
%   Detailed explanation goes here
global vrep ;

%tipHandle = vrep.simxGetObjectHandle(clientID,'MasterTip', vrep.simx_opmode_oneshot_wait);
pos = vrep.simxGetPosition(clientID,handle,-1,vrep.simx_opmode_streaming);
orien = vrep.simxGetOrientation(clientID,handle,-1,vrep.simx_opmode_streaming);
position =[pos(:), orien(:)]';
end

