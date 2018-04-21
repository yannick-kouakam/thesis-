function [path] = JointPath(qi,qdoti,qddoti,qf,qdotf,qddotf,tf ,n)
%JOINTPATH Summary of this function goes here
%   Detailed explanation goes here
   a0 =qi;
   a1= qdoti;
   a2 = qddoti;
   
   a3 =(14*qi - 14*qf + 8*qdotf*tf + 6*qdoti*tf - qddotf*tf^2)/(4*tf^3);
   a4= (6*qi - 6*qf + 4*qdotf*tf + 2*qdoti*tf - qddotf*tf^2)/(4*tf^4);
   a5 = -(6*qi - 6*qf + 4*qdotf*tf + 2*qdoti*tf - qddotf*tf^2)/(4*tf^5);
   t =linspace(0,tf,n);
   path = zeros(7,n);
   for i=1:1:n
       path(:,i)= t(i)^5.*a5 + t(i)^4.*a4 + t(i)^3.*a3+ t(i)^2.*a2 + t(i).*a1 + a0;
   end
end

