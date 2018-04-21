vrep =remApi('remoteApi');
vrep.simxFinish(-1);
clientID=vrep.simxStart('127.0.0.1',19999,true,true,5000,5);

if (clientID >-1)
     disp('Connected to remote API server');
    
    % enable the synchronous mode on the client:
    vrep.simxSynchronous(clientID,true);
    jh = -1*ones(7,1);
    theta = zeros(7,1);
    % start the simulation:
    vrep.simxStartSimulation(clientID,vrep.simx_opmode_blocking);
    [errorCode,IK_target_handle]=vrep.simxGetObjectHandle(clientID,'Target1',vrep.simx_opmode_oneshot_wait);
    [errorCode,EE_pos_handle]=vrep.simxGetObjectHandle(clientID,'Tip',vrep.simx_opmode_oneshot_wait);
    
     % get IK target pos and ori 
   	[errorCode,target_pos]=vrep.simxGetObjectPosition(clientID,IK_target_handle,-1,vrep.simx_opmode_oneshot_wait); 
	[errorCode,target_ori]=vrep.simxGetObjectOrientation(clientID,IK_target_handle,-1,vrep.simx_opmode_oneshot_wait); 
    % get end-effector pos and ori 
	[errorCode,EE_pos]=vrep.simxGetObjectPosition(clientID,EE_pos_handle,-1,vrep.simx_opmode_oneshot_wait); 
	[errorCode,EE_ori]=vrep.simxGetObjectOrientation(clientID,EE_pos_handle,-1,vrep.simx_opmode_oneshot_wait);
   
    for iind=1:7
        [errorCode,jh(iind)]=vrep.simxGetObjectHandle(clientID,strcat('LBR_iiwa_14_R820_joint',num2str(iind)),vrep.simx_opmode_oneshot_wait);
         [code, theta(iind)] = vrep.simxGetJointPosition(clientID,jh(iind),vrep.simx_opmode_oneshot_wait);
    end
    
    disp('End pose ' ) ;disp([EE_pos EE_ori]);
    disp('Target pose ' ) ;disp([target_pos target_ori]);
    disp('Joint ' ) ;disp(theta);
    pos = [target_pos target_ori];
    config =theta';
    joint = InverseKinematic(pos',config);
    disp('joint Velocity ' ) ;
    disp(joint)
    for i =1:7
        code =vrep.simxSetJointTargetPosition(clientID,jh(i),joint(i),vrep.simx_opmode_oneshot_wait);
    end
end
