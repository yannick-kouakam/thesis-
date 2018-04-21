function q = interpolate(t)
%INTEPOLATE Summary of this function goes here
%   Detailed explanation goes here
%   give the interpolation of the desire trajecrory in the joint space ate time t
%   joint_space_path : the desired joint space trajectory
%   time the discrete time interval

global Time Qd ;

q1 = interp1(double(Time),double(Qd(1,:)),t,'nearest');
q2 = interp1(double(Time),double(Qd(2,:)),t,'nearest');
q3 = interp1(double(Time),double(Qd(3,:)),t,'nearest');
q4 = interp1(double(Time),double(Qd(4,:)),t,'nearest');
q5 = interp1(double(Time),double(Qd(5,:)),t,'nearest');
q6 = interp1(double(Time),double(Qd(6,:)),t,'nearest');
q7 = interp1(double(Time),double(Qd(7,:)),t,'nearest');

q =[q1,q2,q3,q4,q5,q6,q7];

end

