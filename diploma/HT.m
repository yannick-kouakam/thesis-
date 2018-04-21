function [ H ] = HT( theta,alpha,a,d )
%HOMOGEOUSMATRIX Summary of this function goes here
% this funstion computes the homogenous transfromation matrix given the DH parameter. 
%   Detailed explanation goes here

    
H=  [cos(theta) -sin(theta)*cos(alpha) sin(theta)*sin(alpha) a*cos(theta);
     sin(theta) cos(theta)*cos(alpha)  -cos(theta)*sin(alpha) a*sin(theta);
     0,sin(alpha),cos(alpha),d;
     0,0,0,1];


end

