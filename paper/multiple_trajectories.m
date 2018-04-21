x=-10:0.1:10;
s=size(x);
S= s(2);
f = x.^2.*sin(x/2) -2.*x+4;

pd = fitdist(f','Normal');
ci = paramci(pd);
f_ci_l = f - ci(1,2);
f_ci_u = f + ci(2,2);
%figure ;
%plot(x,f,'*b',x,f_ci_l,'.r',x,f_ci_u,'.r');
%% generate a set of trajectory
ci_u=max(f_ci_u);
ci_l=max(f_ci_l);
t=f;
g_modified= f;
y = x(26:89);

gi_prime=zeros(10,S);
gi_sec=zeros(10,S);
ti = generateTrajectory(t,ci_l,ci_u);

for i=1:1:10
%     ran = ci(1,2) + (ci(2,2)-ci(1,2))*rand -5;
%     g_modified(26:89) =y.^2.*sin(y) - 2*y +ran;
%     ti(i,:)= g_modified;
    [gi_prime(i,:),gi_sec(i,:)]= deviation(t,ti(i,:),f_ci_l,f_ci_u);
   
end
K= 0;
K_prime = 0;
A = 0;
B = 0;
C=0;
D=0;

for i=1:1:10
    K = K + gi_prime(i,:)*gi_prime(i,:)';
    K_prime = K_prime + gi_sec(i,:)*gi_sec(i,:)';
    A = A + (gi_prime(i,:)*(ti(i,:)-t)' + (ti(i,:)-t)*gi_prime(i,:)');
    D = D + (gi_sec(i,:)*(ti(i,:)-t)' + (ti(i,:)-t)*gi_sec(i,:)');
    B = B + (gi_prime(i,:)*gi_sec(i,:)' + gi_sec(i,:)*gi_prime(i,:)');
    C = C + (gi_sec(i,:)*gi_prime(i,:)' + gi_prime(i,:)*gi_sec(i,:)');
end

alfa = (D - 2*A*(B^-1)*K_prime)*( C - 4*K*(B^-1)*K_prime)^-1; 
beta = (A -2*K*alfa)*B^-1;

syms a b;

eqn1 = 2*K*a + b*B ==A;
eqn2 = 2*K_prime*b +a*C == D;

sol = solve([eqn1,eqn2],[a,b]);
