function [g,g1] = deviation(f,corrected,f_ci_l,f_ci_u)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
  inside = (corrected<=f_ci_u & corrected>=f_ci_l);
  g_=zeros(size(f));
  g1_ =zeros(size(f));
  delta_y=corrected-f;
  for i=1:1:size(f')
      %check that we are inside the CI
      if inside(1,i)==1
          g_(1,i)=delta_y(1,i);
          g1_(1,i)=delta_y(1,i);
      else
         if corrected(1,i)>f_ci_u(1,i) 
             g_(1,i)= f_ci_u(1,i);
             g1_(1,i)= delta_y(1,i)-f_ci_u(1,i);
         end
         if corrected(1,i) < f_ci_u(1,i) 
             g_(1,i)= f_ci_l(1,i);
             g1_(1,i)= delta_y(1,i)-f_ci_u(1,i);
         end
      end
  end
g = g_;
g1 = g1_;
end

