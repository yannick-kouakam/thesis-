function [J] = JacobianThreeLink(theta)
%JACOBIANTHREELINK Summary of this function goes here
%   Detailed explanation goes here
l1=2;l2=2.5;l3=1.5;
q1 =theta(1);q2=theta(2);q3=theta(3);
J =[ - l2*sin(q1 + q2) - l1*sin(q1) - l3*sin(q1 + q2 + q3), - l2*sin(q1 + q2) - l3*sin(q1 + q2 + q3), -l3*sin(q1 + q2 + q3) ;...
     l2*cos(q1 + q2) + l1*cos(q1) + l3*cos(q1 + q2 + q3),             l2*cos(q1 + q2) + l3*cos(q1 + q2 + q3),  l3*cos(q1 + q2 + q3);...
     0,                                0, 0];
end

