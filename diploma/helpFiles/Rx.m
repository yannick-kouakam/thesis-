function [ R ] = Rx( alpha )
%ROTATIONX Summary of this function goes here
%   Detailed explanation goes here

       R = [  1   ,0            ,0            ,0;... 
              0   ,cos(alpha)  ,-sin(alpha) ,0;...
              0   ,sin(alpha)  ,cos(alpha)  ,0;...
              0   ,0            ,0            ,1];
end

