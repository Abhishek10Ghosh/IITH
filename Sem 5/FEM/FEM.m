clc
clear all

n=5;
x0=0;
xn=1;
h=(xn-x0)/(n-1);
x=(x0:h:xn);

Y=zeros(n,1);
Y(1)=1;
Y(n)=exp(2);

A=zeros(n);
A(1,1)=1;
A(n,n)=1;

for i=2:n-1
    A(i,i)=-2/h^2  +1;
        A(i,i-1)=1/h^2 + 2*(x(i)/h);
        A(i,i+1)=1/h^2 - x(i)/h;
end 

A
x=A\Y;
x
