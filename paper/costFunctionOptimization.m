function [ J ,grad ] = costFunctionOptimization( tj,ti,alpha,beta,g_prime,g_sec )
%COSTFUNCTION Summary of this function goes here
%   Detailed explanation goes here
[mj nj]=size(tj);
[mi ni]=size(ti);
J=0;
grad = zeros(2,1);

cost = 0;
delta_alfa=0;
delta_beta=0;
 for j =1:1:mj
     for i=1:1:mi
         temp = tj(j,:)-(ti(i,:) + alpha*g_prime(i,:) + beta*g_sec(i,:));
         cost = cost + temp*temp';
         delta_alfa = delta_alfa + g_prime(i,:)*temp' + temp*g_prime(i,:)';
         delta_beta = delta_beta + g_sec(i,:)*temp' + temp*g_sec(i,:)';
     end
 end
 


J = sum(sum(cost));
grad = [delta_alfa,delta_beta];
end

