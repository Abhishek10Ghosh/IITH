% ME21BTECH11001 Abhishek Ghosh
% ME3180 Assignment 1
% Question 3

% Initial Conditions
E = 30;
I = 120;
q1 = 5400;
F = 7200;
L = 75;
EI = E*I;  

a = 0;
b = L;
n = 1000;
h = (b-a)/(n-1);
x = (a:h:b)';

B = zeros(n,1);
A = zeros(n,n);

% Boundary Conditions
B(1)=0;
B(n)=0;
A(1,1)=1;
A(n,n)=1;

% Roll No = 01;
lambda = 1;
lhl = int32(L/((lambda+2)*h));
rhl = int32(L/((lambda+1)*h));

% Central Difference
for i=2:n-1
    A(i,i+1) = EI/h^2;
    A(i,i) = (-2*EI/h^2 - F);
    A(i,i-1) = EI/h^2;
end

for i=lhl:rhl
    B(i)=0.5*q1*(L*x(i)-x(i)^2);
end

y=A\B;
k = int32(50/h);
% deflection at l=50mm 
y(k)
plot(x,y);





