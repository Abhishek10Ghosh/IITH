clear all
length=1;
n=11;
dx=length/(n-1);
A=zeros(n,n);
B=zeros(n,1);
x=zeros(n);
x(1)=0;
x(n)=length;
sol=zeros(n);
for i=2;n-1
    x(i)=(i-1)*dx
    A(i,i+1)=1/(2*dx);
    A(i,i-1)=-1/(2*dx);
    B(i,1)=x(i);
    sol(i)=0.5*x(i)^2;
end
A(1,1)=1;
% last points
A(n,n)=1/dx;
A(n,n-1)=-1/dx;
B(n,1)=length;
x(n)=length;
sol(n)=0.5*length^2;

U=A\B;

U


