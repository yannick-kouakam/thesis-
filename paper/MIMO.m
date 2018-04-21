x=-10:0.1:10;
s=size(x);
S= s(2);
T = x.^2.*sin(x/2) -2.*x+4;

%% initialization
pd = fitdist(T','Normal');
CI = paramci(pd);
CI_L = T - CI(1,2);
CI_U = T + CI(2,2);
% plot(x,T,'b',x,CI_L,'r',x,CI_U,'r')

% second set of trajectories
T1=  x.^2.*sin(x) -2.*x.^2 ;
pd = fitdist(T1','Normal');
CI1 = paramci(pd);
CI_L1 = T1 - CI1(1,2);
CI_U1 = T1 + CI1(2,2);
%plot(x,T1,'b',x,CI_L1,'r',x,CI_U1,'r')


%third set of trajectories

T2=  x.^3.*sin(x) +4.*x.^2 ;
pd = fitdist(T2','Normal');
CI2 = paramci(pd);
CI_L2 = T2 - CI2(1,2);
CI_U2 = T2 + CI2(2,2);

%plot(x,T2,'b',x,CI_L2,'r',x,CI_U2,'r')


%%fourth set of trajectories
T4=  x.^3.*cos(x) + x.^2 ;
pd = fitdist(T4','Normal');
CI4 = paramci(pd);
CI_L4 = T4 - CI4(1,2);
CI_U4 = T4 + CI4(2,2);
%plot(x,T4,'b',x,CI_L4,'r',x,CI_U4,'r')
T = [T;T1;T2;T4];
CI_L=[CI_L;CI_L1;CI_L2;CI_L4];
CI_U=[CI_U;CI_U1;CI_U2;CI_U4];
%%
num =200;
n=size(T);
alpha=zeros(10,1);
beta =zeros(10,1);
for k=5:1:num
    A = 0; B = 0; C = 0;D = 0; E = 0; F =0;
     for j=1:1:n
         Tj = T(j,:)';
              Ti = generateTrajectory(Tj,max(CI_L(j,:)),max(CI_U(j,:)),k);
              [m,n1]=size(Ti);
            for i=1:1:m
                [Gi_p ,Gi_s]= deviation(Tj,Ti(i,:),CI_L(j,:),CI_U(j,:));

                %

                 A =A + Gi_p'*Gi_p; B =B + (Gi_p')*Gi_p; C = C + Gi_p'*(Tj -Ti(i,:));

                 D =D +Gi_s'*Gi_p; E =E + Gi_s'*Gi_s; F = F + Gi_s'*(Tj -Ti(i,:))  ;


            end
     end
                beta(k-4) = (F - C*D/A) /(E - B*D/A);
                alpha(k-4) = (C-beta(k-4)*B)/A;

end
 k=5:1:num;
 figure;
 plot(k,alpha,'r');
 figure;
 plot(k,beta,'b');