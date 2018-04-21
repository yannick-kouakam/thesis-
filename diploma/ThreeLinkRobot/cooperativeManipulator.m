global l1 l2 l3 lc1 lc2 lc3 m1 m2 m3 I1 I2 I3 mo;
l1=2; l2=2.5; l3=1.5; lc1=l1/2;lc2=l2/2;lc3=l3/3; 
 m1=4;m2=2.2;m3=1.8; mo=3;
 I1=(m1*l1^2)/12;I2=(m1*l2^2);I3=(m1*l3^2);

  
  init=[0,0,0,0,0,0];
  tspan=[0,10];
  [T,Q]=ode45(@(t,q)ode3link(t,q,Tau1,Time),Time,init);
   theta1=Q(:,1);theta2=Q(:,2);theta3=Q(:,3);
   
   
  [T1,Q1]=ode45(@(t,q)ode3link(t,q,Tauf1,Time),Time,init); 
  theta21=Q1(:,1);theta22=Q1(:,2);theta23=Q1(:,3);
  
 %drawRobot(theta1,theta2,theta3,theta21,theta22,theta23);
 
%% generate a path to follow by the robot

init = [joint_space(:,1)',0,0,0];
Kp =eye(3)*1000;
Kd = eye(3)*100;
T =zeros(3,m);
qc=[0,0,0]'; qdc = [0,0,0]'; qddc =[0,0,0]';
e=[];ed=[];
for i=2:m
    qe = joint_space(:,i) -qc;
    qde = vel_space(:,i) -qdc;
    u = acc_space(:,i) + Kd*qe + Kp*qde ;
    tau =inverseDynamic(joint_space(:,i),vel_space(:,i),u');
    T(:,i)=tau;
    [time ,sol ] = ode45(@(t,q)ode3link(t,q,T(:,1:i),Time(1:i)),t,init);
    qc= sol(i,1:3);
    qdc= sol(i,4:6);
    e=[e,qe]; ed=[ed,qde];
end
