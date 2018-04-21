alfa= sym('alfa');
beta = sym('beta');
x=-10:0.5:10;
f = x.^2.*sin(x/2) -2.*x+4;

pd = fitdist(f','Normal');
ci = paramci(pd);
f_ci_l = f - ci(1,2);
f_ci_u = f + ci(2,2);
%figure ;
plot(x,f,'b',x,f_ci_l,'r',x,f_ci_u,'r');
%% generate a set of trajectory
t=f;
g_modified= f;
y = x(6:16);


gi_prime=zeros(10,41);
gi_sec=zeros(10,41);
ti_prime = [];

for i=1:1:10
    ran = ci(1,2) + (ci(2,2)-ci(1,2))*rand -5;
    g_modified(6:16) =y.^2.*sin(y) - 2*y +ran;
    ti_prime(i,:)= g_modified;
    [gi_prime(i,:),gi_sec(i,:)]= deviation(t,g_modified,f_ci_l,f_ci_u);
   
end
