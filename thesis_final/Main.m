%% initialize global variables
global jh vrep;
robot = exampleHelperMwIiwa14();

%% ik solver 
IK = robotics.InverseKinematics('RigidBodyTree',robot);
weights = [0.5,0.5,0.5,1,1,1];
%% establish connection to VREP
vrep =remApi('remoteApi');
vrep.simxFinish(-1);
clientID=vrep.simxStart('127.0.0.1',19999,true,true,5000,5);

pause on;
if (clientID >-1)
     disp('Connected to remote API server');
     %% initialize the joint handles for iiwa and the IBR
      jh = getJointHandle(clientID,1);
      irb14jh = getJointHandle(clientID,0);
      vrep.simxSynchronous(clientID,true);
      [err,signal]=vrep.simxGetStringSignal(clientID,'JointTorques',...
        vrep.simx_opmode_streaming);
    
else
    disp('Connection To VREP Failed'); disp(clientID);
end