function [theta,theta_dot,theta_dd,error] = IK(config,pos)
%IK Summary of this function goes here
%   Detailed explanation goes here
theta = config';

J = JacobianThreeLink(theta);
t=0;
xerr =2;
yerr =2;
error=zeros(50,1);
x_dc=[0,0,0]';
    while (xerr>0.02 || xerr< -.02) && (yerr>0.02 || yerr<-.02)
        pe = FK(theta);
        x_dot = pos-pe;
        xerr=x_dot(1);
        yerr=x_dot(2);
       %% velocity component
        Jinv = pinv(J);
        theta_dot =Jinv*x_dot;
        theta=theta+theta_dot*0.01;
        
        %% acceleration component
        x_dd = x_dot-x_dc;
        Jd = JacobianD(theta,theta_dot);
        
        theta_dd = Jinv*(x_dd -Jd*theta);
        
        %% update variables
        J =JacobianThreeLink(theta);
        x_dc=x_dot;

        t=t+1;
         error(t)=sqrt(sum(x_dot.^2));
    end

end

