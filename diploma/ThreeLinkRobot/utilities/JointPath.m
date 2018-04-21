function [path] = JointPath(q0,v0,ac0,qf,vf,acf,tf ,n)
%JOINTPATH Summary of this function goes here
%   Detailed explanation goes here
%    a0 =qi;
%    a1= v0;
%    a2 = ac0;
   
%    a3 =(14*q0 - 14*qf + 8*vf*tf + 6*qdoti*tf - acf*tf^2)/(4*tf^3);
%    a4= (6*q0 - 6*qf + 4*vf*tf + 2*qdoti*tf - acf*tf^2)/(4*tf^4);
%    a5 = -(6*q0 - 6*qf + 4*vf*tf + 2*qdoti*tf - acf*tf^2)/(4*tf^5);
%    t =linspace(0,tf,n);
%    path = zeros(size(qi,1),n);
%    for i=1:1:n
%        path(:,i)= t(i)^5.*a5 + t(i)^4.*a4 + t(i)^3.*a3+ t(i)^2.*a2 + t(i).*a1 + a0;
%    end
   
 t0=0;  
 M=  [1 t0 t0^2 t0^3 t0^4 t0^5;
    0 1   2*t0 3*t0^2  4*t0^3 5*t0^4;
    0 0 2 6*t0 12*t0^2 20*t0^3;
    1 tf tf^2 tf^3 tf^4 tf^5;
    0 1   2*tf 3*tf^2  4*tf^3 5*tf^4;
    0 0 2 6*tf 12*tf^2 20*tf^3];
   
Q =[q0 v0 ac0 qf vf acf]';

A = M^-1 * Q;
  
 t =linspace(0,tf,n);  
 path = zeros(size(q0,1),n);
    for i=1:1:n
        T = [1 t(i) t(i)^2 t(i)^3 t(i)^4 t(i)^5];
       % path(:,i)= t(i)^5.*a5 + t(i)^4.*a4 + t(i)^3.*a3+ t(i)^2.*a2 +
       % t(i).*a1 + a0;
       temp = T*A;
       path(:,i)=temp;
    end   
   
end

