function [tau] = inverseDynamic(theta,theta_d,theta_dd)
%INVERSEDYNAMIC Summary of this function goes here
%   Detailed explanation goes here
l1=2; l2=2.5; l3=1.5; lc1=l1/2;lc2=l2/2;lc3=l3/3;
 I1=2;I2=3.5;I3=2; 
 m1=.6;m2=1.2;m3=0.8;
%% generalize coordinate
q1=theta(1);q2=theta(2);q3=theta(3);
%% velocities components
qd1 =theta_d(1);qd2=theta(2);qd3=theta(3);
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
c11 = 0 ;c22=0 ;c33=0;
c12 = qd2*(m2*(lc2*cos(q1 + q2)*(lc2*sin(q1 + q2) + l1*sin(q1)) - lc2*sin(q1 + q2)*(lc2*cos(q1 + q2) + l1*cos(q1))) - m3*((l2*sin(q1 + q2) + lc3*sin(q1 + q2 + q3))*(l2*cos(q1 + q2) + l1*cos(q1) + lc3*cos(q1 + q2 + q3)) - (l2*cos(q1 + q2) + lc3*cos(q1 + q2 + q3))*(l2*sin(q1 + q2) + l1*sin(q1) + lc3*sin(q1 + q2 + q3)))) - qd3*((m3*(lc3*sin(q1 + q2 + q3)*(l2*cos(q1 + q2) + l1*cos(q1) + lc3*cos(q1 + q2 + q3)) - lc3*cos(q1 + q2 + q3)*(l2*sin(q1 + q2) + l1*sin(q1) + lc3*sin(q1 + q2 + q3)) - lc3*sin(q1 + q2 + q3)*(l2*cos(q1 + q2) + lc3*cos(q1 + q2 + q3)) + lc3*cos(q1 + q2 + q3)*(l2*sin(q1 + q2) + lc3*sin(q1 + q2 + q3))))/2 - (m2*(lc2*cos(q1 + q2)*(lc2*sin(q1 + q2) + l1*sin(q1)) - lc2*sin(q1 + q2)*(lc2*cos(q1 + q2) + l1*cos(q1))))/2 + (m3*((l2*sin(q1 + q2) + lc3*sin(q1 + q2 + q3))*(l2*cos(q1 + q2) + l1*cos(q1) + lc3*cos(q1 + q2 + q3)) - (l2*cos(q1 + q2) + lc3*cos(q1 + q2 + q3))*(l2*sin(q1 + q2) + l1*sin(q1) + lc3*sin(q1 + q2 + q3))))/2) + qd1*((m2*(lc2*cos(q1 + q2)*(lc2*sin(q1 + q2) + l1*sin(q1)) - lc2*sin(q1 + q2)*(lc2*cos(q1 + q2) + l1*cos(q1))))/2 + (m2*(2*lc2*cos(q1 + q2)*(lc2*sin(q1 + q2) + l1*sin(q1)) - 2*lc2*sin(q1 + q2)*(lc2*cos(q1 + q2) + l1*cos(q1))))/2 - (m3*((l2*sin(q1 + q2) + lc3*sin(q1 + q2 + q3))*(l2*cos(q1 + q2) + l1*cos(q1) + lc3*cos(q1 + q2 + q3)) - (l2*cos(q1 + q2) + lc3*cos(q1 + q2 + q3))*(l2*sin(q1 + q2) + l1*sin(q1) + lc3*sin(q1 + q2 + q3))))/2 - (m3*(2*(l2*sin(q1 + q2) + lc3*sin(q1 + q2 + q3))*(l2*cos(q1 + q2) + l1*cos(q1) + lc3*cos(q1 + q2 + q3)) - 2*(l2*cos(q1 + q2) + lc3*cos(q1 + q2 + q3))*(l2*sin(q1 + q2) + l1*sin(q1) + lc3*sin(q1 + q2 + q3))))/2);
c13 =- qd2*((m3*(lc3*sin(q1 + q2 + q3)*(l2*cos(q1 + q2) + l1*cos(q1) + lc3*cos(q1 + q2 + q3)) - lc3*cos(q1 + q2 + q3)*(l2*sin(q1 + q2) + l1*sin(q1) + lc3*sin(q1 + q2 + q3)) + lc3*sin(q1 + q2 + q3)*(l2*cos(q1 + q2) + lc3*cos(q1 + q2 + q3)) - lc3*cos(q1 + q2 + q3)*(l2*sin(q1 + q2) + lc3*sin(q1 + q2 + q3))))/2 + (m3*(lc3*sin(q1 + q2 + q3)*(l2*cos(q1 + q2) + l1*cos(q1) + lc3*cos(q1 + q2 + q3)) - lc3*cos(q1 + q2 + q3)*(l2*sin(q1 + q2) + l1*sin(q1) + lc3*sin(q1 + q2 + q3))))/2) - qd1*((m3*(lc3*sin(q1 + q2 + q3)*(l2*cos(q1 + q2) + l1*cos(q1) + lc3*cos(q1 + q2 + q3)) - lc3*cos(q1 + q2 + q3)*(l2*sin(q1 + q2) + l1*sin(q1) + lc3*sin(q1 + q2 + q3))))/2 + (m3*(2*lc3*sin(q1 + q2 + q3)*(l2*cos(q1 + q2) + l1*cos(q1) + lc3*cos(q1 + q2 + q3)) - 2*lc3*cos(q1 + q2 + q3)*(l2*sin(q1 + q2) + l1*sin(q1) + lc3*sin(q1 + q2 + q3))))/2) - m3*qd3*(lc3*sin(q1 + q2 + q3)*(l2*cos(q1 + q2) + l1*cos(q1) + lc3*cos(q1 + q2 + q3)) - lc3*cos(q1 + q2 + q3)*(l2*sin(q1 + q2) + l1*sin(q1) + lc3*sin(q1 + q2 + q3))); 

c21 = (m3*qd3*(lc3*sin(q1 + q2 + q3)*(l2*cos(q1 + q2) + l1*cos(q1) + lc3*cos(q1 + q2 + q3)) - lc3*cos(q1 + q2 + q3)*(l2*sin(q1 + q2) + l1*sin(q1) + lc3*sin(q1 + q2 + q3)) - lc3*sin(q1 + q2 + q3)*(l2*cos(q1 + q2) + lc3*cos(q1 + q2 + q3)) + lc3*cos(q1 + q2 + q3)*(l2*sin(q1 + q2) + lc3*sin(q1 + q2 + q3))))/2 - qd1*((m2*(2*lc2*cos(q1 + q2)*(lc2*sin(q1 + q2) + l1*sin(q1)) - 2*lc2*sin(q1 + q2)*(lc2*cos(q1 + q2) + l1*cos(q1))))/2 - (m3*(2*(l2*sin(q1 + q2) + lc3*sin(q1 + q2 + q3))*(l2*cos(q1 + q2) + l1*cos(q1) + lc3*cos(q1 + q2 + q3)) - 2*(l2*cos(q1 + q2) + lc3*cos(q1 + q2 + q3))*(l2*sin(q1 + q2) + l1*sin(q1) + lc3*sin(q1 + q2 + q3))))/2) - qd2*((m2*(lc2*cos(q1 + q2)*(lc2*sin(q1 + q2) + l1*sin(q1)) - lc2*sin(q1 + q2)*(lc2*cos(q1 + q2) + l1*cos(q1))))/2 - (m3*((l2*sin(q1 + q2) + lc3*sin(q1 + q2 + q3))*(l2*cos(q1 + q2) + l1*cos(q1) + lc3*cos(q1 + q2 + q3)) - (l2*cos(q1 + q2) + lc3*cos(q1 + q2 + q3))*(l2*sin(q1 + q2) + l1*sin(q1) + lc3*sin(q1 + q2 + q3))))/2);
c23 =- qd1*((m3*(lc3*sin(q1 + q2 + q3)*(l2*cos(q1 + q2) + l1*cos(q1) + lc3*cos(q1 + q2 + q3)) - lc3*cos(q1 + q2 + q3)*(l2*sin(q1 + q2) + l1*sin(q1) + lc3*sin(q1 + q2 + q3)) + lc3*sin(q1 + q2 + q3)*(l2*cos(q1 + q2) + lc3*cos(q1 + q2 + q3)) - lc3*cos(q1 + q2 + q3)*(l2*sin(q1 + q2) + lc3*sin(q1 + q2 + q3))))/2 - (m3*(lc3*sin(q1 + q2 + q3)*(l2*cos(q1 + q2) + l1*cos(q1) + lc3*cos(q1 + q2 + q3)) - lc3*cos(q1 + q2 + q3)*(l2*sin(q1 + q2) + l1*sin(q1) + lc3*sin(q1 + q2 + q3)) - lc3*sin(q1 + q2 + q3)*(l2*cos(q1 + q2) + lc3*cos(q1 + q2 + q3)) + lc3*cos(q1 + q2 + q3)*(l2*sin(q1 + q2) + lc3*sin(q1 + q2 + q3))))/2 + (m3*(lc3*sin(q1 + q2 + q3)*(l2*cos(q1 + q2) + lc3*cos(q1 + q2 + q3)) - lc3*cos(q1 + q2 + q3)*(l2*sin(q1 + q2) + lc3*sin(q1 + q2 + q3))))/2) - qd2*((m3*(lc3*sin(q1 + q2 + q3)*(l2*cos(q1 + q2) + lc3*cos(q1 + q2 + q3)) - lc3*cos(q1 + q2 + q3)*(l2*sin(q1 + q2) + lc3*sin(q1 + q2 + q3))))/2 + (m3*(2*lc3*sin(q1 + q2 + q3)*(l2*cos(q1 + q2) + lc3*cos(q1 + q2 + q3)) - 2*lc3*cos(q1 + q2 + q3)*(l2*sin(q1 + q2) + lc3*sin(q1 + q2 + q3))))/2) - m3*qd3*(lc3*sin(q1 + q2 + q3)*(l2*cos(q1 + q2) + lc3*cos(q1 + q2 + q3)) - lc3*cos(q1 + q2 + q3)*(l2*sin(q1 + q2) + lc3*sin(q1 + q2 + q3)));

c31 =(m3*qd3*(lc3*sin(q1 + q2 + q3)*(l2*cos(q1 + q2) + l1*cos(q1) + lc3*cos(q1 + q2 + q3)) - lc3*cos(q1 + q2 + q3)*(l2*sin(q1 + q2) + l1*sin(q1) + lc3*sin(q1 + q2 + q3))))/2 + (m3*qd1*(2*lc3*sin(q1 + q2 + q3)*(l2*cos(q1 + q2) + l1*cos(q1) + lc3*cos(q1 + q2 + q3)) - 2*lc3*cos(q1 + q2 + q3)*(l2*sin(q1 + q2) + l1*sin(q1) + lc3*sin(q1 + q2 + q3))))/2 + (m3*qd2*(lc3*sin(q1 + q2 + q3)*(l2*cos(q1 + q2) + l1*cos(q1) + lc3*cos(q1 + q2 + q3)) - lc3*cos(q1 + q2 + q3)*(l2*sin(q1 + q2) + l1*sin(q1) + lc3*sin(q1 + q2 + q3)) + lc3*sin(q1 + q2 + q3)*(l2*cos(q1 + q2) + lc3*cos(q1 + q2 + q3)) - lc3*cos(q1 + q2 + q3)*(l2*sin(q1 + q2) + lc3*sin(q1 + q2 + q3))))/2;
c32 = qd1*((m3*(lc3*sin(q1 + q2 + q3)*(l2*cos(q1 + q2) + l1*cos(q1) + lc3*cos(q1 + q2 + q3)) - lc3*cos(q1 + q2 + q3)*(l2*sin(q1 + q2) + l1*sin(q1) + lc3*sin(q1 + q2 + q3)) + lc3*sin(q1 + q2 + q3)*(l2*cos(q1 + q2) + lc3*cos(q1 + q2 + q3)) - lc3*cos(q1 + q2 + q3)*(l2*sin(q1 + q2) + lc3*sin(q1 + q2 + q3))))/2 - (m3*(lc3*sin(q1 + q2 + q3)*(l2*cos(q1 + q2) + l1*cos(q1) + lc3*cos(q1 + q2 + q3)) - lc3*cos(q1 + q2 + q3)*(l2*sin(q1 + q2) + l1*sin(q1) + lc3*sin(q1 + q2 + q3)) - lc3*sin(q1 + q2 + q3)*(l2*cos(q1 + q2) + lc3*cos(q1 + q2 + q3)) + lc3*cos(q1 + q2 + q3)*(l2*sin(q1 + q2) + lc3*sin(q1 + q2 + q3))))/2) + (m3*qd3*(lc3*sin(q1 + q2 + q3)*(l2*cos(q1 + q2) + lc3*cos(q1 + q2 + q3)) - lc3*cos(q1 + q2 + q3)*(l2*sin(q1 + q2) + lc3*sin(q1 + q2 + q3))))/2 + (m3*qd2*(2*lc3*sin(q1 + q2 + q3)*(l2*cos(q1 + q2) + lc3*cos(q1 + q2 + q3)) - 2*lc3*cos(q1 + q2 + q3)*(l2*sin(q1 + q2) + lc3*sin(q1 + q2 + q3))))/2;

C=[ c11 , c12 , c13;...
    c21 , c22 , c23;...
    c31 , c32 , c33];

%% Gravitational component

g1=m3*(l2*cos(q1 + q2) + l1*cos(q1) + lc3*cos(q1 + q2 + q3)) + m2*(lc2*cos(q1 + q2) + l1*cos(q1)) + lc1*m1*cos(q1);
g2 =m3*(l2*cos(q1 + q2) + lc3*cos(q1 + q2 + q3)) + lc2*m2*cos(q1 + q2);
g3 = lc3*m3*cos(q1 + q2 + q3);

G = [g1,g2,g3]*10';

%% Torque component


%% Equation of motion
 tau = M*theta_dd' +C*[qd1,qd2,qd3]'+ G';
end

