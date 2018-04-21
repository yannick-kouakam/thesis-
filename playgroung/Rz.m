function [ R ] = Rz(gamma)
%ROTATIONZ Summary of this function goes here
%   Detailed explanation goes here
    R = [  cos(gamma) ,-sin(gamma) ,0  ,0;...
           sin(gamma) ,cos(gamma)  ,0  ,0;...
           0,         0            ,1  ,0;...
           0,         0            ,0  ,1];

end

