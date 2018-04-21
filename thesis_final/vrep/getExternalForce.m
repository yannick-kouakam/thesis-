function F = getExternalForce(clientID)
%GETEXTERNALFORCE Summary of this function goes here
%   Detailed explanation goes here
global vrep;
[code1, fh11] =  vrep.simxGetObjectHandle(clientID,'MicoHand_force_Sens1_finger1#0',vrep.simx_opmode_oneshot_wait);
[code2, fh12] =  vrep.simxGetObjectHandle(clientID,'MicoHand_force_Sens2_finger1#0',vrep.simx_opmode_oneshot_wait);
[code3, fh21] =  vrep.simxGetObjectHandle(clientID,'MicoHand_force_Sens1_finger3#0',vrep.simx_opmode_oneshot_wait);
[code4, fh22] =  vrep.simxGetObjectHandle(clientID,'MicoHand_force_Sens2_finger3#0',vrep.simx_opmode_oneshot_wait);

 [ returnCode, f11]=vrep.simxGetJointForce(clientID,fh11,mode);
 [ returnCode, f12]=vrep.simxGetJointForce(clientID,fh12,mode);
 [ returnCode, f21]=vrep.simxGetJointForce(clientID,fh21,mode);
 [ returnCode, f22]=vrep.simxGetJointForce(clientID,fh22,mode);
    
   f  = f11+f12+f21+f22;
   F=f;
end

