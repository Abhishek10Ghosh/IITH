% % ME21BTECH11001
% % Abhishek Ghosh
% 
% 
% t = linspace(0, 6*pi, 1000);  % parameter t
% r = 5;  % radius
% c = (4/3)/(2*pi); % pitch = 4/3
% 
% x = -r * sin(t);
% y = r * cos(t);
% z = c * t;
% 
% % Front view (x-z plane)
% figure;
% plot(x, z, 'b');
% title('Front View (x-z plane)');
% xlabel('x');
% ylabel('z');
% xlim([-5, 5]);
% ylim([0, max(z)]);
% axis equal;
% grid on;
% set(gca, 'FontSize', 12);
% set(gcf, 'Color', 'w');
% set(gcf, 'Position', [100, 100, 500, 400]);
% 
% % Isometric view (3D plot)
% figure;
% plot3(x, y, z, 'b');
% title('Isometric View (3D)');
% xlabel('x');
% ylabel('y');
% zlabel('z');
% xlim([-5, 5]);
% ylim([-5, 5]);
% zlim([0, max(z)]);
% axis equal;
% grid on;
% set(gca, 'FontSize', 12);
% set(gcf, 'Color', 'w');
% set(gcf, 'Position', [650, 100, 500, 400]);
% view([45, 20]);
% 
% % Top view (x-y plane)
% figure;
% plot(x, y, 'b');
% title('Top View (x-y plane)');
% xlabel('x');
% ylabel('y');
% xlim([-5, 5]);
% ylim([-5, 5]);
% axis equal;
% grid on;
% set(gca, 'FontSize', 12);
% set(gcf, 'Color', 'w');
% set(gcf, 'Position', [1200, 100, 500, 400]);

% Define the points
P1 = [3, 1.5, 2, 1];
P2 = [2.5, 2, 2, 1];
P3 = [3, 2, 1.5, 1];

% Calculate the centroid
C = (P1 + P2 + P3) / 3;

% Calculate vectors along the edges of the triangle
v1 = P2(1:3) - P1(1:3);
v2 = P3(1:3) - P1(1:3);

% Calculate the normal vector of the triangle
normal = cross(v1, v2);
normal = normal / norm(normal);
normal = [normal, 1]; % Append 1 to make it homogeneous

% Calculate the angle alpha for rotation around the x-axis
alpha = atan2(normal(1), normal(2));
Rx = [
    1, 0, 0, 0;
    0, cos(alpha), sin(alpha), 0;
    0, -sin(alpha), cos(alpha), 0;
    0, 0, 0, 1
];

% Rotate the normal vector around the x-axis
normal_Rx = normal * Rx;

% Calculate the angle beta for rotation around the y-axis
beta = atan2(normal_Rx(1), normal_Rx(3));
Ry = [
    cos(beta), 0, sin(beta), 0;
    0, 1, 0, 0;
    -sin(beta), 0, cos(beta), 0;
    0, 0, 0, 1
];

% Rotate the normal vector around the y-axis
normal_z = normal_Rx * Ry;

% Apply the combined rotation matrix to the points
transform = Rx * Ry;
P1_rot = P1 * transform;
P2_rot = P2 * transform;
P3_rot = P3 * transform;
C_rot = (P1_rot + P2_rot + P3_rot) / 3;

% Projection matrix for x-y plane
xy_proj = [
    1, 0, 0, 0;
    0, 1, 0, 0;
    0, 0, 0, 0;
    0, 0, 0, 1
];

% Project the rotated points onto the x-y plane
P1_proj = P1_rot * xy_proj;
P2_proj = P2_rot * xy_proj;
P3_proj = P3_rot * xy_proj;
C_proj = (P1_proj + P2_proj + P3_proj) / 3;

% Display the final position vectors
disp('Final position vectors:');
disp(['P1: ', mat2str(P1_proj)]);
disp(['P2: ', mat2str(P2_proj)]);
disp(['P3: ', mat2str(P3_proj)]);

% Define edge color
edgeColor = 'b'; % Blue for all edges

% Plot the original triangle
figure('Position', [100, 100, 1500, 600]);
% subplot(1, 2, 1);
plot3([P1(1), P2(1)], [P1(2), P2(2)], [P1(3), P2(3)], [edgeColor, 'o-'], 'LineWidth', 2); 
hold on;
plot3([P2(1), P3(1)], [P2(2), P3(2)], [P2(3), P3(3)], [edgeColor, 'o-'], 'LineWidth', 2);
plot3([P3(1), P1(1)], [P3(2), P1(2)], [P3(3), P1(3)], [edgeColor, 'o-'], 'LineWidth', 2);
scatter3(C(1), C(2), C(3), 100, 'r', 'filled'); % Red centroid
title('Original Triangle');
xlabel('X');
ylabel('Y');
zlabel('Z');
legend('P1','P2','P3', 'Centroid');
grid on;
axis equal;

% Plot the rotated triangle
figure('Position', [100, 100, 1500, 600]);
% subplot(1, 2, 2);
plot3([P1_rot(1), P2_rot(1)], [P1_rot(2), P2_rot(2)], [P1_rot(3), P2_rot(3)], [edgeColor, 'o-'], 'LineWidth', 2);
hold on;
plot3([P2_rot(1), P3_rot(1)], [P2_rot(2), P3_rot(2)], [P2_rot(3), P3_rot(3)], [edgeColor, 'o-'], 'LineWidth', 2);
plot3([P3_rot(1), P1_rot(1)], [P3_rot(2), P1_rot(2)], [P3_rot(3), P1_rot(3)], [edgeColor, 'o-'], 'LineWidth', 2);
scatter3(C_rot(1), C_rot(2), C_rot(3), 100, 'r', 'filled'); % Red centroid
title('Rotated Triangle');
xlabel('X');
ylabel('Y');
zlabel('Z');
legend('P1','P2','P3', 'Centroid');
grid on;
axis equal;

% Plot the projected triangle on the x-y plane
figure('Position', [700, 100, 600, 600]);
plot([P1_proj(1), P2_proj(1)], [P1_proj(2), P2_proj(2)], [edgeColor, 'o-'], 'LineWidth', 2);
hold on;
plot([P2_proj(1), P3_proj(1)], [P2_proj(2), P3_proj(2)], [edgeColor, 'o-'], 'LineWidth', 2);
plot([P3_proj(1), P1_proj(1)], [P3_proj(2), P1_proj(2)], [edgeColor, 'o-'], 'LineWidth', 2);
scatter(C_proj(1), C_proj(2), 100, 'r', 'filled'); % Red centroid
title('Projected Triangle on the x-y Plane');
xlabel('X');
ylabel('Y');
grid on;
axis equal;
legend('P1','P2','P3', 'Centroid');




