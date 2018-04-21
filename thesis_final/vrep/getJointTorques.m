function tau = getJointTorques(clientID,jh,ind)
%GETJOINTTORQUES Summary of this function goes here
%   Detailed explanation goes here
    global vrep;
    tau =zeros(7,1);
    mode=0;
  if ind<=1
      mode = vrep.simx_opmode_streaming;
     
  else
     mode = vrep.simx_opmode_buffer;
  end
%   [ result,data ]=vrep.simxGetStringSignal(clientID,'JointTorques',vrep.simx_opmode_buffer);
%              if (result~=vrep.simx_error_noerror)
%                  error('simxGetStringSignal failed');
%              end
%              if(isempty(data))
%                  error('empty data returned');
%              end
%             tau=vrep.simxUnpackFloats(data);
%            % torques =[tau(1),tau(2),tau(4),tau(5),tau(6),tau(7)]';
% 
%          [ returnCode, tau(i)]=vrep.simxGetJointForce(clientID,jointHandle,operationMode);
      for i=1:7
      [ returnCode, tau(i)]=vrep.simxGetJointForce(clientID,jh(i),mode);
      end
end

