% ME21BTECH11001 Abhishek Ghosh
% ME3180 Assignment 1
% Question 2


clc
clear all

E = 1;
b = 1;
f = 0;
L = 1;
h0 = 0;
h1 = 1;


n=101;
h=(h1-h0)/(n-1);

A = zeros(n,n);
B = zeros(n,1);
B(1)=0;
B(n)=0.01;
A(1,1)=1;
A(n,n)=1;
A(n,n-1)=-1;
x=(h0:h:h1)';

sol = zeros(n,1);
c1 = -0.01/log(2) + 0.5;
c2 = c1*log(2);
c3 = 0.5;
c4 = 0.01 - 0.5*log(2);

sol(1) = c1*log(0.5) + c1*log(2);

% Central Difference
for i=2:n-1
    if(x(i)<=L/2)
        A(i,i+1)=1/(2*h) +(x(i)+0.5)/h^2;
        A(i,i)=-2*(x(i)+0.5)/h^2;
        A(i,i-1)=(x(i)+0.5)/h^2 -1/(2*h);
        sol(i)=c1*log(x(i)+0.5) + c1*log(2);
    else
        A(i,i+1)=-1/(2*h)+(1.5-x(i))/h^2;
        A(i,i)=-2*(1.5-x(i))/h^2;
        A(i,i-1)=1/(2*h)+(1.5-x(i))/h^2;;
        sol(i)=0.5*log(1.5-x(i)) + 0.01 -0.5*log(2);
    end
end

sol(n)=0.5*log(1.5-x(n))+0.01 - 0.5*log(2);

y = A\B;
plot(x,y,color='r')
hold on
plot(x, sol,Color='b');



