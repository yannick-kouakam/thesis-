function Jd = JacobianD(theta,thetad)
%JACOBIAND Summary of this function goes here
%   Detailed explanation goes here
l1=2;l2=2.5;l3=1.5;
q1=theta(1);q2=theta(2);q3=theta(3);
 q1d=thetad(1);q2d =thetad(2);q3d=thetad(3);
 
Jd =[ - l2*cos(q1 + q2)*(q1d + q2d) - l1*cos(q1)*q1d - l3*cos(q1 + q2 + q3)*(q1d + q2d + q3d), - l2*cos(q1 + q2)*(q1d + q2d) - l3*cos(q1 + q2 + q3)*(q1d + q2d + q3d), -l3*cos(q1 + q2 + q3)*(q1d+ q2d+ q3d);...]
      - sin(q1 + q2 + q3)*(q1d + q2d + q3d) - l2*sin(q1 + q2)*(q1d + q2d) - l1*sin(q1)*q1d,    - sin(q1 + q2 + q3)*(q1d + q2d + q3d) - l2*sin(q1 + q2)*(q1d + q2d),    -sin(q1 + q2 + q3)*(q1d + q2d + q3d);...
     0,0,0];
  


end

