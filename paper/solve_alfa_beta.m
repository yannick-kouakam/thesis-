clear ;
x=-10:0.1:10;
s=size(x);
S= s(2);
f = x.^2.*sin(x/2) -2.*x+4;

pd = fitdist(f','Normal');
ci = paramci(pd);
f_ci_l = f - ci(1,2);
f_ci_u = f + ci(2,2);
%figure ;
%plot(x,f,'b',x,f_ci_l,'r',x,f_ci_u,'r');
%% generate a set of trajectory
t=f;
g_modified= f;
y = x(26:129);


gi_prime=zeros(10,S);
gi_sec=zeros(10,S);
ti = [];

for i=1:1:10
    ran = ci(1,2) + (ci(2,2)-ci(1,2))*rand -5;
    g_modified(26:129) =y.^2+t(26:129) ;
    ti(i,:)= g_modified;
    [gi_prime(i,:),gi_sec(i,:)]= correction(t,g_modified,f_ci_l,f_ci_u);
   
end
K= 0;
K_prime = 0;
A = 0;
B = 0;
C=0;
D=0;
% 
% for i=1:1:10
%     K = K + gi_prime(i,:)*gi_prime(i,:)';
%     K_prime = K_prime + gi_sec(i,:)*gi_sec(i,:)';
%     A = A +  (ti(i,:)-t)*gi_prime(i,:)';
%     B = B +  (ti(i,:)-t)*gi_sec(i,:)';
%      C = C + gi_sec(i,:)*gi_prime(i,:)';
%     D = D +  gi_prime(i,:)*gi_sec(i,:)';
% end
% beta = ((B-A*C)/(10*K_prime + C*D));
% alfa = (A -beta*C)/(10*K);

for i=1:1:10
    K = K + gi_prime(i,:)*gi_prime(i,:)';
    K_prime = K_prime + gi_sec(i,:)*gi_sec(i,:)';
    A = A +  (ti(i,:)-t)*gi_prime(i,:)';
    B = B +  (ti(i,:)-t)*gi_sec(i,:)';
     C = C + gi_sec(i,:)*gi_prime(i,:)';
    D = D +  gi_prime(i,:)*gi_sec(i,:)';
end
beta = (B- A*(K^-1)*D)/(K_prime + C*(K^-1)*D);
alfa = (A -beta*C)*K^-1;

f_sum = 0;
for i=1:1:10
    f_sum = f_sum + (ti(i,:)-(t +gi_prime(i,:) + gi_sec(i,:)))*(ti(i,:)-(t +gi_prime(i,:) + gi_sec(i,:)))';
end