clear all
length=1;
n=100
dx=length/(n-1);
A=zeros(n,n);
B=zeros(n,1);
x(1)=0;
x(n)=length;
sol(1)=0;
for i=2:n-1
    x(i)=(i-1)*dx;
    xi=(i-1)*dx;
    A(i,i+1)=1/dx^2;
    A(i,i)=-2/dx^2;
    A(i,i-1)=1/dx^2;
    B(i,1)=xi+2;
    sol(i)=(xi^3/6)+(xi^2)-(7*xi/6);
end
A(1,1)=1;
A(n,n)=1;
sol(n)=length^3/6+(length^2)-(7*length/6);
% B(1,1)=2;
% B(n,1)=length+2;
A
B
U=A\B;
U
plot(x,U,'r')
hold on
plot(x,sol,'b')