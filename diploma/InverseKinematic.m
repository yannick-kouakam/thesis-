function [ joints, error] = InverseKinematic( pos ,config)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    %dtheta = zeros(7,1);
    theta=config; error = zeros(50,1);
    t=1;
    while t <200 
     [J ,Pe] = JacobianMatrix(theta);
     J_inv =pinv(J);
     x_dot = (pos-Pe);
     dtheta = J_inv*x_dot; 
     theta = theta + dtheta'*0.01;
     error(t)= sqrt(sum(x_dot.^2));
     t=t+1;
%      if error <0.02
%          t=1;
%      end
      
    end
     
     
     joints =theta;

end

