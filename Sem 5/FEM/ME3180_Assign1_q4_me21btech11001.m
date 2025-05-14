% ME21BTECH11001 Abhishek Ghosh
% ME3180 Assignment 1
% Question 4

clc 
clear all

n = 1000;
length = 1;
h = length/(n-1);

x = (0:h:length)';
A = zeros(n,n);
B = zeros(n,1);
sol(1)=cos(0)+tan(1)*sin(0);

% Central Difference
for i=2 : n-1
    sol(i)=cos(x(i))+tan(1)*sin(x(i));
    A(i,i+1) = 1/(h^2);
    A(i,i-1) = 1/(h^2);
    A(i,i) = 1-2/h^2;
end

%Boundary Conditions:-
A(1,1) = 1;
A(n,n) = 1;
A(n,n-1) = -1;
B(1) = 1;
sol(n)=cos(1)+tan(1)*sin(1);

Y = A\B;

% plot of x vs actual solution
plot(x,sol,color='r')
hold on
% plot of x and solution via Finite difference method 
plot(x, Y,Color='b')
title("Finite Difference for d2y/dx2 = -y")
xlabel("X")
ylabel("Y")
