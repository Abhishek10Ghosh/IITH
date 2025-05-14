% Define grid
[x1, x2] = meshgrid(linspace(-2,2,100), linspace(-3,1,100));

% Original function
f = 10*x1.^2 - 8*x2.^2 - 2*x2;

% Linear model (s = x - x0 = [x1, x2 + 1])
s1 = x1;
s2 = x2 + 1;
m1 = -6 + 14*s2;

% Quadratic model
m2 = -6 + 14*s2 + 10*s1.^2 - 8*s2.^2;

% Plotting
figure;
contour(x1, x2, f, 30, 'LineWidth', 1.2); hold on;
contour(x1, x2, m2, 15, '--r', 'LineWidth', 1.2);
quiver(0, -1, 0, 14, 0.5, 'k', 'LineWidth', 2);
legend('Original f(x)', 'Quadratic model', 'Gradient at x_0');
title('Contours of f(x) and Quadratic Model');
xlabel('x_1'); ylabel('x_2');
grid on;

% Plot linear model as separate figure
figure;
contour(x1, x2, f, 20, 'LineWidth', 1.2); hold on;
contour(x1, x2, m1, 20, '--g', 'LineWidth', 1.2);
contour(x1, x2, m2, 20, '--r', 'LineWidth', 1.2);
legend('Original f(x)', 'Linear model', 'Quadratic model');
title('Contours of f(x), Linear and Quadratic Models');
xlabel('x_1'); ylabel('x_2');
grid on;
