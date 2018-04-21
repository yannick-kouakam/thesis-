function state = ode3link(t,q,Tau,Time)
%ODE3LINK Summary of this function goes here
%   Detailed explanation goes here

%% initialization
state= zeros(6,1);
global l1 l2 l3 lc1 lc2 lc3 m1 m2 m3 I1 I2 I3;
%% generalize coordinate
q1=q(1);q2=q(2);q3=q(3);
%% velocities components
qd1 =q(4);qd2=q(5);qd3=q(6);
%% Inertia matrice components
m11 = I1 + I2 + I3 + m3*((l2*cos(q1 + q2) + l1*cos(q1) + lc3*cos(q1 + q2 + q3))^2 + (l2*sin(q1 + q2) + l1*sin(q1) + lc3*sin(q1 + q2 + q3))^2) + m2*((lc2*cos(q1 + q2) + l1*cos(q1))^2 + (lc2*sin(q1 + q2) + l1*sin(q1))^2) + m1*(lc1^2*cos(q1)^2 + lc1^2*sin(q1)^2); 
m12 = I2 + I3 + m2*(lc2*sin(q1 + q2)*(lc2*sin(q1 + q2) + l1*sin(q1)) + lc2*cos(q1 + q2)*(lc2*cos(q1 + q2) + l1*cos(q1))) + m3*((l2*cos(q1 + q2) + lc3*cos(q1 + q2 + q3))*(l2*cos(q1 + q2) + l1*cos(q1) + lc3*cos(q1 + q2 + q3)) + (l2*sin(q1 + q2) + lc3*sin(q1 + q2 + q3))*(l2*sin(q1 + q2) + l1*sin(q1) + lc3*sin(q1 + q2 + q3)));
m13=I3 + m3*(lc3*cos(q1 + q2 + q3)*(l2*cos(q1 + q2) + l1*cos(q1) + lc3*cos(q1 + q2 + q3)) + lc3*sin(q1 + q2 + q3)*(l2*sin(q1 + q2) + l1*sin(q1) + lc3*sin(q1 + q2 + q3)));

m21 =I2 + I3 + m2*(lc2*sin(q1 + q2)*(lc2*sin(q1 + q2) + l1*sin(q1)) + lc2*cos(q1 + q2)*(lc2*cos(q1 + q2) + l1*cos(q1))) + m3*((l2*cos(q1 + q2) + lc3*cos(q1 + q2 + q3))*(l2*cos(q1 + q2) + l1*cos(q1) + lc3*cos(q1 + q2 + q3)) + (l2*sin(q1 + q2) + lc3*sin(q1 + q2 + q3))*(l2*sin(q1 + q2) + l1*sin(q1) + lc3*sin(q1 + q2 + q3)));
m22 =I2 + I3 + m3*((l2*cos(q1 + q2) + lc3*cos(q1 + q2 + q3))^2 + (l2*sin(q1 + q2) + lc3*sin(q1 + q2 + q3))^2) + m2*(lc2^2*cos(q1 + q2)^2 + lc2^2*sin(q1 + q2)^2);
m23 =I3 + m3*(lc3*cos(q1 + q2 + q3)*(l2*cos(q1 + q2) + lc3*cos(q1 + q2 + q3)) + lc3*sin(q1 + q2 + q3)*(l2*sin(q1 + q2) + lc3*sin(q1 + q2 + q3)));

m31 =I3 + m3*(lc3*cos(q1 + q2 + q3)*(l2*cos(q1 + q2) + l1*cos(q1) + lc3*cos(q1 + q2 + q3)) + lc3*sin(q1 + q2 + q3)*(l2*sin(q1 + q2) + l1*sin(q1) + lc3*sin(q1 + q2 + q3)));
m32 =I3 + m3*(lc3*cos(q1 + q2 + q3)*(l2*cos(q1 + q2) + lc3*cos(q1 + q2 + q3)) + lc3*sin(q1 + q2 + q3)*(l2*sin(q1 + q2) + lc3*sin(q1 + q2 + q3)));
m33 =I3 + m3*(lc3^2*cos(q1 + q2 + q3)^2 + lc3^2*sin(q1 + q2 + q3)^2);

M=[ m11 , m12 , m13;...
    m21 , m22 , m23;...
    m31 , m32 , m33];

%%Coriollis and Centrifugal components
C = CoriolisMatrix(q(1:3),q(4:6));

%% Gravitational component

g1=m3*(l2*cos(q1 + q2) + l1*cos(q1) + lc3*cos(q1 + q2 + q3)) + m2*(lc2*cos(q1 + q2) + l1*cos(q1)) + lc1*m1*cos(q1);
g2 =m3*(l2*cos(q1 + q2) + lc3*cos(q1 + q2 + q3)) + lc2*m2*cos(q1 + q2);
g3 = lc3*m3*cos(q1 + q2 + q3);

G = [g1,g2,g3]'*10;

%% Torque component
n = size(Tau,2);
f1= interp1(Tau(1,:),Time,t);
f2=interp1(Tau(2,:),Time,t);
f3= interp1(Tau(3,:),Time,t);
F =[f1,f2,f3]';

%% Equation of motion
 Qdd = pinv(M)*(F-(C*[qd1,qd2,qd3]'+G));

  
  %% solution of the ode
  state(1)=q(4);
  state(2)=q(5);
  state(3)=q(6);
  state(4)=Qdd(1);
  state(5)=Qdd(2);
  state(6)=Qdd(3);

 
end

