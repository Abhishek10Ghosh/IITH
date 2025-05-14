


nx = 3;
ny = 2;
conn = connectivity2D(nx, ny);
disp(conn);

% 2D

% Define the scalar function
f = @(x, y) x.^2 + y.^2;

% Generate a grid
[x, y] = meshgrid(-2:0.2:2, -2:0.2:2);

% Compute gradients
[fx, fy] = gradient(f(x, y), 0.2, 0.2);

% Plot the scalar field
contour(x, y, f(x, y), 20); hold on;
quiver(x, y, fx, fy, 'r'); % Gradient vectors
title('Gradient vectors of f(x,y) = x^2 + y^2');
xlabel('x'); ylabel('y');
axis equal; grid on;

% 3D
% Define grid
[x, y] = meshgrid(-2:0.4:2, -2:0.4:2);

% Define scalar function
f = x.^2 + y.^2;

% Compute gradients
[fx, fy] = gradient(f, 0.4, 0.4);

% Plot 3D surface
figure;
surf(x, y, f);
shading interp
colormap jet
hold on;

% Plot gradient vectors
quiver3(x, y, f, fx, fy, zeros(size(f)), 0.8, 'k');  % Arrows lie on surface

title('3D Surface and Gradient Vectors of f(x, y) = x^2 + y^2');
xlabel('x'); ylabel('y'); zlabel('f(x,y)');
axis tight;
grid on;
view(45, 30);



function conn = connectivity2D(nx, ny)
    % Generates the connectivity matrix for a nx × ny grid of quadrilateral elements
    conn = zeros(nx * ny, 4);  % Each quad has 4 nodes
    element_index = 1;

    for j = 1:ny
        for i = 1:nx
            node1 = (j - 1) * (nx + 1) + i;
            node2 = node1 + 1;
            node3 = node2 + (nx + 1);
            node4 = node3 - 1;

            conn(element_index, :) = [node1, node2, node3, node4];
            element_index = element_index + 1;
        end
    end
end


