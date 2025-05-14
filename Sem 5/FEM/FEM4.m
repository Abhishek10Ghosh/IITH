% du/dt=-u    u(0)=1

clear all
length=1;
n=100;
dx=length/(n-1);
A=zeros(n,n);
B=zeros(n,1);
B(1,1)=1;
x(1)=0;
x(n)=length;
sol(1)=1;
for i=2:n-1
    x(i)=(i-1)*dx;
    A(i,i+1)=1/(2*dx);
    A(i,i)=1;
    A(i,i-1)=-1/(2*dx);
    B(i,1)=0;
    sol(i)=exp(-x(i));
end
sol(n)=exp(-length);
A(1,1)=1;
% from backward diff
A(n,n)=1/dx;
A(n,n-1)=-1/dx;

%A(n,n)=exp(-1);
sol(n)=exp(-1);

A
B
U=A\B;
U
plot(x,U,'-r')
hold on;
plot(x,sol,'-b')
