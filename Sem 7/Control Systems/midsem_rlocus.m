p = [1 0 6 0 25]
r = roots(p)

real_parts = real(r);
imag_parts = imag(r);

plot(real_parts, imag_parts, 'or');
axis equal;
grid on;
xlabel('Real Part');
ylabel('Imaginary Part');
title('Roots of the Polynomial');
