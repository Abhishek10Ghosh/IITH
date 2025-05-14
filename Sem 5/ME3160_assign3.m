clc 
clear all

rp = 1:0.5:25;
k = 1.4;
n = (k-1)/k;
e = [0];
n_noreg = 1 - 1./rp.^(n);
plot(rp, n_noreg, 'r');

ratio1 = 1/3; %T1/T3

for i=1:1:1
  n_reg = ((1 - 1./rp.^n) + ratio1.*(1 - rp.^n))./((1 - e(i)./(rp.^n)) - ratio1.*(rp.^n - e(i).*(rp.^n)));
  hold on
  plot(rp, n_reg);
end


title("n vs r_p for e = 0")
xlabel("Pressure Ratio(r_p)");
ylabel("Efficiency");
%legend("0", "0.2","0.4","0.6","0.8","1");