% ME21BTECH11001 Abhishek Ghosh

% Design of machine elements ME3180 assignment
% Problem Statement: MATLAB code that intakes a stress state (biaxial stress state) then finds eigenvalues, and outputs failure envelope for a material.
% use material properties of mild steel for reference. 

clear
clc
% stress state matrix
x=zeros(2,2);

% input values
prompt="Sigma XX: ";
x(1,1)=input(prompt);
prompt="Sigma yy: ";
x(2,2)=input(prompt);
prompt="Tau xy: ";
x(1,2)=input(prompt);
x(2,1)=x(1,2);

% solving for eigen values
lambda= eig(x);
sigma1 = lambda(1,1);
sigma2 = lambda(2,1);
% maximum shear stress
mss=(abs(lambda(1,1)-lambda(2,1)))/2;     
syt= max(sigma1,sigma2);

% plot the failure envelope
%Tresca
hold on
xlabel("sigma_1");
ylabel("sigma_2");
title("Failure Envelope");
plot([0,syt],[syt,syt],"b");
plot([syt,syt],[syt,0],"b");

plot([syt,0],[0,-syt],"b");
plot([0,-syt],[-syt,-syt],"b");

plot([-syt,-syt],[-syt,0],"b");
plot([-syt,0],[0,syt],"b");
hold on;

% Von Mises
degree=0:0.01:2*pi;
a=(2)^(0.5)*(syt);
b=(2/3)^(0.5)*(syt);
x = a*cos(degree)*cos(pi/4) - b*sin(degree)*sin(pi/4);
y = a*cos(degree)*sin(pi/4) + b*sin(degree)*cos(pi/4);
plot(x,y,"r");
hold on;
title("Failure envelope")
xlabel("sigma_1")
ylabel("sigma_2")
legend("Tresca","","","","","","Von Mises");
hold off;