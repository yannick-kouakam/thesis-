function [ R ] = Ry(beta)
%ROTATIONY Summary of this function goes here
%   Detailed explanation goes here
 
   R= [   cos(beta)     ,0    ,sin(beta)    ,0;... 
          0             ,1    ,0            ,0;...
          -sin(beta)   ,0    ,cos(beta)   ,0;...
          0             ,0    ,0            ,1]; 
end

