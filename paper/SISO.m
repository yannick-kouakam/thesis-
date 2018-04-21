x=-10:0.1:10;
s=size(x);
S= s(2);
T = x.^2.*sin(x/2) -2.*x+4;

%% create the confidence interval
pd = fitdist(T','Normal');
CI = paramci(pd);
CI_L = T - CI(1,2);
CI_U = T + CI(2,2);

alpha = zeros(50,1);
beta = zeros(50,1);
%%
num =100;
for k=1:1:num
Ti = generateTrajectory(T,min(CI_L),max(CI_U),k);
[m,n]=size(Ti);

A=0;B=0;C=0;D=0;E=0;F=0;
for i=1:1:m
    [Gi_p,Gi_s]= deviation(T,Ti(i,:),CI_L,CI_U);
    A =A + Gi_p*Gi_p'; B= B  + Gi_s*Gi_p'; C = C + (Ti(i,:)-T)*Gi_p';
    D =D + Gi_p*Gi_s'; E= E + Gi_s*Gi_s'; F = F + (Ti(i,:)-T)*Gi_s';
   
end

%A = sum(sum(Gi_prime*Gi_prime')); B = sum(sum(Gi_sec*Gi_prime')); C = sum(sum((Ti-T)*Gi_prime'));
%D = sum(sum(Gi_prime*Gi_sec')); E = sum(sum(Gi_sec*Gi_sec')); F = sum(sum((Ti-T)*Gi_sec'));

beta(k) = (F - C*D/A) /(E - B*D/A);
alpha(k) = (C-beta(k)*B)/A;

end
k=1:1:num;
figure;
plot(k,alpha,'r');
figure;
plot(k,beta,'b');