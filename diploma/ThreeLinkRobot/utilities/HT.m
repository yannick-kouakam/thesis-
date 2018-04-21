function [H] = HT(theta,l)
%HT Summary of this function goes here
%   Detailed explanation goes here
% return the homogenoues transformation givent the angle and the link lenght an the 
  H=[ cos(theta) , -1*sin(theta) , 0 , l*cos(theta);...
      sin(theta) , cos(theta)    , 0 , l*sin(theta);...
      0,           0             , 1 , 0           ;...
      0          ,0              , 0 , 1           ];
end

