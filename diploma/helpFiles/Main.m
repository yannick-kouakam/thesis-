global Time Qd Kd Kp lbr;

%% initialize the robot
lbr = exampleHelperMwIiwa14();
Kd = eye(7,7)*10;
Kp = eye(7,7)*100;
%% generate a time interval for the simulation and the initial configurations
Time = linspace(0,10,100);
init_config = robot.homeConfiguration;
final_config = robot.randomConfiguration;
%% generate a desire joint space trajectory;
Qd = JointPath(init_config',zeros(7,1),zeros(7,1),final_config',zeros(7,1),zeros(7,1),5,100);

%Qt = [Time' Qd'];
Time= [0 Time];
Qt =repmat(Qd,[1 1 length(Time)]);

data.time=Time;
data.signals.values = Qt;
data.signals.dimensions=[7 100];

Qt=data;

%%
robot = importrobot('iiwa14.urdf'); % 14 kg payload version
robot.DataFormat = 'row';
robot2 = importrobot('puma.urdf');
show(robot, qInterp(k,:), 'PreservePlot', false);
q0 = homeConfiguration(robot);
qf = randomConfiguration(robot);
path = JointPath(q0',zeros(7,1),zeros(7,1),qf',zeros(7,1),zeros(7,1),5,10);

qWaypoints =repmat(q0,10,1);
framerate = 15;
r = robotics.Rate(framerate);
tFinal = 10;
tWaypoints = [0,linspace(tFinal/2,tFinal,size(qWaypoints,1)-1)];
numFrames = tFinal*framerate;
qInterp = pchip(tWaypoints,path,linspace(0,tFinal,numFrames))';


hold on
for k = 1:size(qInterp,1)
    show(robot, qInterp(k,:), 'PreservePlot', false);
    waitfor(r);
end
hold off