function [ M ] = InertiaMatrix( theta,links,mass ,I)
%INERTIAMATRIX Summary of this function goes here
%   Detailed explanation goes here 
% compute the inertia matrix given the joints angles and  links length 
alpha=[-pi/2,pi/2,-pi/2,pi/2,-pi/2,pi/2,0];
l1=links(1); lc1=l1/2;q1=theta(1);
l2=links(2); lc2=l2/2;q2=theta(2);
l3=links(3); lc3=l3/2;q3=theta(3);
l4=links(4); lc4=l4/2;q4=theta(4);
l5=links(5); lc5=l5/2;q5=theta(5);
l6=links(6); lc6=l6/2;q6=theta(6);
l7=links(7); lc7=l7/2;q7=theta(7);
nil = zeros(1,3);
  %% J_l1_P the jacobian fo the link center of mass
  
  Z0=[0,0,1]'; %rotational axis of the joint 1
  P0 =[0,0,0]; % position of the origin of the link 1
  Pc1 =[0,0 lc1]; %position of the mass center of the link 1
  J_l1_P = [cross(Z0,(Pc1-P0)'),nil,nil,nil,nil,nil,nil];
  J_l1_0 =[Z0,nil,nil,nil,nil,nil,nil];
 %% J_l2_P the jacobian fo the link center of mass
 H0 =HT(q1,alpha(1),0,(l1));
 R1=H0(1:3,1:3);
 H1 = HT(q2,alpha(2),0,(l2));
 H = H0*H1; P1=H(1:3,4);Pc2 =P1+[0,0,lc2]';
 R2=H(1:3,13);
 Z1= H(1:3,3);
 J_l2_P =[cross(Z0,(Pc2-P0)'),cross(Z1,(Pc2-P1)'),nil,nil,nil,nil,nil];
 J_l2_O =[Z0,Z1,nil,nil,nil,nil,nil];
 
 %% Jacobian for the link 3
 H3 =HT(q3,alpha(3),0,(l3));
 H = H*H3;R3=H(1:3,13);
 P2=H(1:3,4); Z2=H(1:3,3);Pc3 =P2+[0,0,lc3]';
 J_l3_P =[cross(Z2,(Pc3-P0)'),cross(Z2,(Pc3-P2)'),cross(Z2,(Pc3-P2)'),nil,nil,nil,nil];
 J_l3_O =[Z0,Z1,Z2,nil,nil,nil,nil];
 
  %% Jacobian for the link 4
 H4 =HT(q4,alpha(4),0,(l4));
 H = H*H4;R4=H(1:3,13);
 P3=H(1:3,4); Z3=H(1:3,3);Pc4 =P3+[0,0,lc4]';
 J_l4_P =[cross(Z3,(Pc4-P0)'),cross(Z2,(Pc4-P1)'),cross(Z3,(Pc4-P2)'),cross(Z3,(Pc4-P3)'),nil,nil,nil];
 J_l4_O =[Z0,Z1,Z2,Z3,nil,nil,nil];
 
   %% Jacobian for the link 5
 H5 =HT(q5,alpha(5),0,(l5));
 H = H*H5;R5=H(1:3,13);
 P4=H(1:3,4); Z4=H(1:3,3);Pc5 =P4+[0,0,lc5]';
 J_l5_P =[cross(Z4,(Pc5-P0)'),cross(Z4,(Pc5-P1)'),cross(Z4,(Pc5-P2)'),cross(Z4,(Pc5-P3)'),cross(Z4,(Pc5-P4)'),nil,nil];
 J_l5_O =[Z0,Z1,Z2,Z3,Z4,nil,nil];
 
   %% Jacobian for the link 6
 H6 =HT(q6,alpha(6),0,(l6));
 H = H*H6;R6=H(1:3,13);
 P5=H(1:3,4); Z5=H(1:3,3);Pc6 =P5+[0,0,lc6]';
 J_l6_p =[cross(Z5,(Pc6-P0)'),cross(Z5,(Pc6-P1)'),cross(Z5,(Pc6-P2)'),cross(Z5,(Pc6-P3)'),cross(Z5,(Pc6-P4)'),cross(Z5,(Pc6-P5)'),nil];
 J_l6_O =[Z0,Z1,Z2,Z3,Z4,Z5,nil];
 
  %% Jacobian for the link 7
 H7 =HT(q7,alpha(7),0,(l7));
 H = H*H7;R7=H(1:3,13);
 P6=H(1:3,4); Z6=H(1:3,3);Pc7 =P6+[0,0,lc7]';
 J_l7_p =[cross(Z6,(Pc7-P0)'),cross(Z6,(Pc7-P1)'),cross(Z6,(Pc7-P2)'),cross(Z6,(Pc7-P3)'),cross(Z6,(Pc7-P4)'),cross(Z6,(Pc7-P5)'),cross(Z6,(Pc7-P6)')];
 J_l7_0 =[Z0,Z1,Z2,Z3,Z4,Z5,Z6];
 
 
 M1 = J_l1_P'*J_l1_P +J_l1_0'*R1*I1*R1'*J_l1_0;
 M2 = J_l2_P'*J_l2_P +J_l2_O'*R2*I2*R2'*J_l2_O;
 M3 = J_l3_P'*J_l3_P +J_l3_O'*R3*I3*R3'*J_l3_O;
 M4 = J_l4_P'*J_l4_P +J_l4_O'*R4*I4*R4'*J_l4_O;
 M5 = J_l5_P'*J_l5_P +J_l5_O'*R5*I5*R5'*J_l5_O;
 M6 = J_l6_p'*J_l6_p +J_l6_O'*R6*I6*R6'*J_l6_O;
 M7 = J_l7_p'*J_l7_p +J_l7_0'*R7*I7*R7'*J_l7_0;
 
 M =mass(1).*M1+mass(2).*M2 + mass(3).*M3 + mass(3).*M4 + mass.*M5(5) + mass(6).*M6 + mass(7).*M7;
end

