vrep =remApi('remoteApi');
vrep.simxFinish(-1);
clientID=vrep.simxStart('127.0.0.1',19999,true,true,5000,5);
%%

%%
if (clientID >-1)
    if (clientID>-1)
    disp('Connected to remote API server');
    
    % enable the synchronous mode on the client:
    vrep.simxSynchronous(clientID,true);
    
    % start the simulation:
    vrep.simxStartSimulation(clientID,vrep.simx_opmode_blocking);
    [errorCode,IK_target_handle]=vrep.simxGetObjectHandle(clientID,'Target',vrep.simx_opmode_oneshot_wait);
    [errorCode,EE_pos_handle]=vrep.simxGetObjectHandle(clientID,'Tip',vrep.simx_opmode_oneshot_wait);

    % one vrep tick
    vrep.simxSynchronousTrigger(clientID);
    
    % get IK target pos and ori 
   	[errorCode,target_pos]=vrep.simxGetObjectPosition(clientID,IK_target_handle,-1,vrep.simx_opmode_oneshot_wait); 
	[errorCode,target_ori]=vrep.simxGetObjectOrientation(clientID,IK_target_handle,-1,vrep.simx_opmode_oneshot_wait); 
    % get end-effector pos and ori 
	[errorCode,EE_pos]=vrep.simxGetObjectPosition(clientID,EE_pos_handle,-1,vrep.simx_opmode_oneshot_wait); 
	[errorCode,EE_ori]=vrep.simxGetObjectOrientation(clientID,EE_pos_handle,-1,vrep.simx_opmode_oneshot_wait);
	% save initial 
    init_pos = target_pos;
    init_ori= target_ori;
	vrep.simxSynchronousTrigger(clientID);
    
    % change target pos (Z position)
    target_pos(3) = target_pos(3)-0.3;
	vrep.simxSetObjectPosition(clientID,IK_target_handle,-1,target_pos,vrep.simx_opmode_oneshot_wait);
	vrep.simxSetObjectOrientation(clientID,IK_target_handle,-1,target_ori,vrep.simx_opmode_oneshot_wait);
	vrep.simxSynchronousTrigger(clientID);
	
    % lazy delay for 50 vrep cycles for robot to move
	for i=1:50
        vrep.simxSynchronousTrigger(clientID);
    end

    % new position and orientation
    target_ori(2) = target_ori(2)-pi/2;
	target_pos(2) = target_pos(2)+0.2;
    
    % send new target
	vrep.simxSetObjectPosition(clientID,IK_target_handle,-1,target_pos,vrep.simx_opmode_oneshot_wait);
	vrep.simxSetObjectOrientation(clientID,IK_target_handle,-1,target_ori,vrep.simx_opmode_oneshot_wait);
	vrep.simxSynchronousTrigger(clientID);
	
    % wait
    for i=1:100
        vrep.simxSynchronousTrigger(clientID);
    end


    % go back to initial position
	vrep.simxSetObjectPosition(clientID,IK_target_handle,-1,init_pos,vrep.simx_opmode_oneshot_wait);
	vrep.simxSetObjectOrientation(clientID,IK_target_handle,-1,init_ori,vrep.simx_opmode_oneshot_wait);
	vrep.simxSynchronousTrigger(clientID);
	
    for i=1:100
        vrep.simxSynchronousTrigger(clientID);
    end

    pause(1);
    % stop the simulation:
    vrep.simxStopSimulation(clientID,vrep.simx_opmode_blocking);
    
    end
 end