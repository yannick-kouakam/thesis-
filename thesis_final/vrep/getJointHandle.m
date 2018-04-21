function jh = getJointHandle(clientID, robotID)
%GETROBOTJOINTHANDLE Summary of this function goes here
%   Detailed explanation goes here
     global vrep;
     if robotID==1
      jh = zeros(7,1);
      for iind=1:7
        [errorCode,jh(iind)]=vrep.simxGetObjectHandle(clientID,strcat('LBR_iiwa_14_R820_joint',num2str(iind)),...
                                                      vrep.simx_opmode_oneshot_wait);
      end
     else 
         jh = zeros(6,1);
         for iind=1:7
              [errorCode,jh(iind)]=vrep.simxGetObjectHandle(clientID,strcat('IRB140_joint',num2str(iind)),...
                                                      vrep.simx_opmode_oneshot_wait);
         end
     end
end

