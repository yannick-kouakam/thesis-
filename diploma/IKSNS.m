function [ joint ] = IKSNS( x )
%IKSNS Summary of this function goes here
%   Detailed explanation goes here
%% initialization
W = eye(7,7); Qn_dot=zeros(7,1); s=1; ss=0; limit =0;

while limit==0 
    Jd =pinv(J*W);
 Q_b_dot = Qn_dot + Jd*(x_dot - J*Qn_dot);
 temp = Q_b_dot<Q_dot_min ||  Q_b_dot>Q_dot_max;

 for i=1:1:7
     if temp(i) 
         limit=1;
     end
 end
 a = Jd*x_dot;
 b = Q_b_dot - a;
 scalar = taskScalingFactor(a,d);
 
 if scalar > ss
   ss = scalar;
   Ws = W; Qdots = Qn_dot;
 end
 
 if rank(J*W) < 7 
     s= ss ; W =Ws; 
end
end

