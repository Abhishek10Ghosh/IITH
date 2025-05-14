% du/dt=-u    u(0)=1 FD

clear all
length=1;
n=10;
dx=length/(n-1);
A=zeros(n,n);
B=zeros(n,1);
B(1,1)=1;
x(1)=0;
x(n)=length;
sol(1)=1;
A(1,1)=1;
delta = 0.1;
for i=2:n-1
    x(i)=(i-1)*dx;
    A(i,i)=1-1/dx;
    A(i,i+1)=1/dx;
    B(i,1)=0;
    sol(i)=exp(-x(i));
end
A(1,1)=1;
sol(n)=exp(-length);
% from backward diff
A(n,n)=1+ 1/dx;
B(1,1)=1;
%A(n,n)=exp(-1);
sol(n)=exp(-1);

A
B
U=A\B;
U(1)=1;
for i=1:n-1
    U(i+1)=(delta+1)*U(i);
end
U
plot(x,U,'-r')
hold on;
plot(x,sol,'-b')
