function [h,h1] = drawRobot(theta1,theta2,theta3,theta21,theta22,theta23)
%DRAWROBOT Summary of this function goes here
%   Detailed explanation goes here
%  draw the robot giving it configuration
pause on;
  %axis(gca,'equal');
 axis([-4,8,-4,4]);
l1=2;l2=2.5;l3=1.5;
for i=1:1:size(theta1,1)
    cla;
    q1=theta1(i); q2=theta2(i);
    q3= theta3(i);
    
    q21=theta21(i); q22 =theta22(i); q23 =theta23(i);
    X =[-2,-2+l1*cos(q1),-2+l1*cos(q1)+l2*cos(q1+q2),-2+l1*cos(q1)+l2*cos(q1+q2)+l3*cos(q1+q2+q3)];
    Y = [0,l1*sin(q1), l1*sin(q1)+l2*sin(q1+q2),l1*sin(q1)+l2*sin(q1+q2)+l3*sin(q1+q2+3)];
   
    X1 =[3,3+l1*cos(q21),3+l1*cos(q21)+l2*cos(q21+q22),3+l1*cos(q21)+l2*cos(q21+q22)+l3*cos(q21+q22+q23)];
    Y1 = [0,l1*sin(q21), l1*sin(q21)+l2*sin(q21+q22),l1*sin(q21)+l2*sin(q21+q22)+l3*sin(q21+q22+q23)];
   
    h=line(X,Y,'Marker','o','LineStyle','-','Color','r','LineWidth',2);
     h1=line(X1,Y1,'Marker','o','LineStyle','-','Color','g','LineWidth',2);
    pause(0.01);
end
end

