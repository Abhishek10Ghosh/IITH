% Given parameters
F = 1.0;    % Force per unit length (N/m)
N = 10.0;   % Normal force at the tip (N)
EI = 0.1;   % Bending stiffness (N·m²)
k0 = 0.0;   % Initial curvature (1/m)
L = 1.0;    % Length of the gripper (m)

% Governing equations for Cosserat rod (planar case)


% Initial conditions at s = 0 (base of gripper)
theta_0 = 0.0;   % Initial angle
x_0 = 0.0;       % Initial x-position
y_0 = 0.0;       % Initial y-position
m_0 = 0.0;       % No initial moment

% Solve the system
s_span = linspace(0, L, 100);
y0 = [theta_0; x_0; y_0; m_0];

sol = ode45(@cosserat_rod, [0 L], y0);
sol_values = deval(sol, s_span);

theta_sol = sol_values(1, :);
x_sol = sol_values(2, :);
y_sol = -sol_values(3, :); % Flip y-coordinates to make it upside down

% Plot the deformed shape
figure;
plot(x_sol, y_sol, 'b', 'LineWidth', 2);
hold on;
scatter(0, 0, 'r', 'filled');
xlabel('X Position (m)');
ylabel('Y Position (m)');
title('Deformed Shape of Soft Gripper (Cosserat Rod) (Upside Down)');
grid on;
legend('Deformed Shape', 'Base');
hold off;


function dyds = cosserat_rod(s, y)
    theta = y(1);
    x = y(2);
    y_pos = y(3);
    m = y(4);
    
    dtheta_ds = m / EI;
    dx_ds = cos(theta);
    dy_ds = sin(theta);
    dm_ds = -F * (L - s);  % Moment due to distributed force
    
    dyds = [dtheta_ds; dx_ds; dy_ds; dm_ds];
end