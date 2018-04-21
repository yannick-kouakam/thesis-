function [ s ] = taskScalingFactor( a,b )
%TASKSCALINGFACTOR Summary of this function goes here
%   Detailed explanation goes here
 Smin =(Q_dotMin - b)./a;
 Smax = (Q_dotMax - b)./a;
 
 for i=1:1:7
     if Smin(i)>Smax(i)
         temp=Smin(i);
         Smin(i)=Smax(i);
         Smax(i)=temp;
     end
 end
 
   smin =min(Smax);
     smax = max(Smin);
     
     if smin >smax || smax<0 || smin>1
         s =0;
     else
         s=smax;
     end
 

end

