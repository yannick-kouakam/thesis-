function [g,g1] = correction(f,g_co,ci_l,ci_u)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
  inside = (g_co<=ci_u & g_co>=ci_l);
  g_=zeros(size(f));
  g1_ =zeros(size(f));
  delta_y=g_co-f;
  for i=1:1:size(f')
      %% checks if the trajectory was modified a the given point
      if f(i)==g_co(i) %no correction
          g_(i) =0;
          g1_(i)=0;
      else  % the tracjectory was modified
          if inside(i)==1 % inside the CI
               g_(i) =delta_y(i);
               g1_(i)=0;
          else % outside the CI
              if g_co(1,i)>ci_u(1,i) % above the CI 
                 g_(1,i)= ci_u(1,i);
                 g1_(1,i)= delta_y(1,i)-ci_u(1,i);
              end
              
             if g_co(1,i) < ci_l(1,i) %below the CI
                 g_(1,i)= ci_l(1,i);
                 g1_(1,i)= delta_y(1,i)-ci_l(1,i);
             end
                  
          end
      end
  end    
    g = g_;
    g1 = g1_;
end

