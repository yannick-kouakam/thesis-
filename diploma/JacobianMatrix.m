function [ Jacobian,Pe ] = JacobianMatrix(theta )
%JACOBIANMATRIX Summary of this function goes here
%   Detailed explanation goes here
d=[0.36,0,.42,0,0.4,0,0.12];
T1 = [cos(theta(1)) , 0 , -sin(theta(1)) ,0;
      sin(theta(1)) , 0 ,cos(theta(1)) , 0;
      0  ,            -1, 0, d(1)         ;
      0 , 0 , 0 ,1          ];
  
  T2 = [cos(theta(2)) , 0 , sin(theta(2)) ,0;
        sin(theta(2)) , 0 ,-cos(theta(2)) , 0;
      0  ,            1, 0, d(2)         ;
      0 , 0 , 0 ,1          ];
  
T3 = [cos(theta(3)) , 0 , sin(theta(3)) ,0;
      sin(theta(3)) , 0 ,-cos(theta(3)) , 0;
      0  ,            1, 0, d(3)         ;
      0 , 0 , 0 ,1          ];
  
T4 = [cos(theta(4)) , 0 , -sin(theta(4)) ,0;
      sin(theta(4)) , 0 ,cos(theta(4)) , 0;
      0  ,            -1, 0, d(4)         ;
      0 , 0 , 0 ,1          ];
T5 = [cos(theta(5)) , 0 , -sin(theta(5)) ,0;
      sin(theta(5)) , 0 ,cos(theta(5)) , 0;
      0  ,            -1, 0, d(5)         ;
      0 , 0 , 0 ,1          ];
  
  T6 = [cos(theta(6)) , 0 , sin(theta(6)) ,0;
      sin(theta(6)) , 0 ,-cos(theta(6)) , 0;
      0  ,            -1, 0, d(6)         ;
      0 , 0 , 0 ,1   ];
  
  T7 = [cos(theta(7)) , -sin(theta(7)),0 ,0;
      sin(theta(1))  ,cos(theta(7)) , 0,0;
      0  ,    0, 0, d(7)         ;
      0 , 0 , 0 ,1          ];

P0=[0 0 0 1]'; Z0=[0,0,1]';
H=T1*T2*T3*T4*T5*T6*T7;
Pe=H*P0; 
Pe = Pe(1:3);
P1=T1*P0; P1=P1(1:3); Z1 = T1(1:3,1:3)*Z0; J1=[cross(Z1,(Pe-P1)) , Z1]; 
P2=T1*T2*P0; P2=P2(1:3); Z2 = T1(1:3,1:3)*T2(1:3,1:3)*Z0; J2=[cross(Z2 ,(Pe-P2)) , Z2]; 
P3=T1*T2*T3*P0; P3=P3(1:3); Z3 = T1(1:3,1:3)*T2(1:3,1:3)*T3(1:3,1:3)*Z0; J3=[cross(Z3,(Pe-P3)) , Z3];
P4=T1*T2*T3*T4*P0; P4=P4(1:3); Z4 = T1(1:3,1:3)*T2(1:3,1:3)*T3(1:3,1:3)*T4(1:3,1:3)*Z0; J4=[cross(Z4 ,(Pe-P4)) , Z4];
P5=T1*T2*T3*T4*T5*P0; P5=P5(1:3); Z5 = T1(1:3,1:3)*T2(1:3,1:3)*T3(1:3,1:3)*T4(1:3,1:3)*T5(1:3,1:3)*Z0; J5=[cross(Z5 ,(Pe-P5)) , Z5];
P6=T1*T2*T3*T4*T5*T7*P0;P6=P6(1:3);  Z6 = T1(1:3,1:3)*T2(1:3,1:3)*T3(1:3,1:3)*T4(1:3,1:3)*T5(1:3,1:3)*T6(1:3,1:3)*Z0; J6=[cross(Z6 ,(Pe-P6)) , Z6];
P7=T1*T2*T3*T4*T5*T7*P0;P7=P7(1:3);  Z7 = T1(1:3,1:3)*T2(1:3,1:3)*T3(1:3,1:3)*T4(1:3,1:3)*T5(1:3,1:3)*T6(1:3,1:3)*T7(1:3,1:3)*Z0; J7=[cross(Z7,(Pe-P7)) , Z7];


Pe =[Pe;0;0;0];
Jacobian = [J1(:) J2(:) J3(:) J4(:) J5(:) J6(:) J7(:)];
