function [ output ] = generateTrajectory( initial_trajectory,Ci_l,Ci_u,number )
%GENERATETRAJECTORY Summary of this function goes here
%   Detailed explanation goes here
     if nargin>3
         num = number;
     else
         num=10;
     end
     [n,m]=size(initial_trajectory);
     output = zeros(num,m);
     output(:,1)= Ci_l +(Ci_u-Ci_l)*rand(num,1);
     sigma_0= (Ci_u -10)/100;
     di=initial_trajectory(1)- output(:,1);
     for i=2:1:m
         for j=1:1:num
             output(j,i)= initial_trajectory(i)+  di(j);
             di(j)=di(j)  + normrnd(0,sigma_0);
         end
     end
     
end

