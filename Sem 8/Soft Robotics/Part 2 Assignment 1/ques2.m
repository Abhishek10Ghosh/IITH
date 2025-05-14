clc; clear;

% Grid for contour plots
[x1, x2] = meshgrid(0:0.1:8, 0:0.1:20);
f = x1.^2 + x2.^2;

% Constraints (original and perturbed)
g1 = 25 - x1 .* x2;
g2 = 2 - x1;

g1_pert = 25.1 - x1 .* x2;
g2_pert = 1.9 - x1;

% Feasible region masks
feasible_orig = double((g1 <= 0) & (g2 <= 0));
feasible_pert = double((g1_pert <= 0) & (g2_pert <= 0));

% Plot
figure;
hold on;

% Contours of the objective function
contour(x1, x2, f, 50, 'LineWidth', 1);

% Shade feasible regions
contourf(x1, x2, feasible_orig, [1 1], 'FaceColor', [0.8 1 0.8], 'LineColor', 'none');
contourf(x1, x2, feasible_pert, [1 1], 'FaceColor', [1 0.9 0.9], 'LineColor', 'none');

% Constraints (boundaries)
contour(x1, x2, g1, [0 0], 'r', 'LineWidth', 2);         % g1 = 0
contour(x1, x2, g2, [0 0], 'b--', 'LineWidth', 2);       % g2 = 0
contour(x1, x2, g1_pert, [0 0], 'm', 'LineWidth', 2);    % g1 pert = 0
contour(x1, x2, g2_pert, [0 0], 'c--', 'LineWidth', 2);  % g2 pert = 0

% Optimal points
plot(5, 5, 'ko', 'MarkerSize', 8, 'MarkerFaceColor', 'k'); 
text(5.2, 5, 'Original Optimum (50)', 'FontSize', 9);

x_opt = sqrt(25.1);
plot(x_opt, x_opt, 'mo', 'MarkerSize', 8, 'MarkerFaceColor', 'm'); 
text(x_opt + 0.2, x_opt, sprintf('Perturbed Optimum (%.1f)', 2*x_opt^2), 'FontSize', 9);

% Labels and legend
xlabel('x_1'); ylabel('x_2');
title('Feasible Regions and Objective Function Contours');

legend({'Objective contours', ...
        'g_1 = 25 - x_1x_2 = 0', ...
        'g_2 = 2 - x_1 = 0', ...
        'g_1 = 25.1 - x_1x_2 = 0', ...
        'g_2 = 1.9 - x_1 = 0', ...
        'Original Optimum', ...
        'Perturbed Optimum'}, ...
        'Location', 'northwest');

grid on;
axis([0 8 0 20]);
