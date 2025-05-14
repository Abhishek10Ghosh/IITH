% all firing
% x1 = [.17,.52,.18,.20,.31,.34,.19,.26,.45,.67,.99];
% x2 = [.02,.18,.11,.19,.25,.15,.14,.10,.21,.09,.07];
% y = [504,608,715,821,901,1000,1110,1212,1309,1409,1509];

% 1243
% x1 = [.01,.02,.04,.06,.23,.52,.09,.05,.04,.04,.05];
% x2 = [.02,.01,.05,.02,.03,.14,.06,.16,.13,.06,.04];
% y = [495,592,704,825,921,985,1114,1205,1317,1404,1505];

% % 1234
% x1 = [.01,.02,.03,.05,.16,.37,.10,.05,.04,.04,.03];
% x2 = [.04,.09,.07,.09,.10,.13,.16,.28,.22,.24,.31];
% y = [501,615,700,804,901,1000,1118,1218,1320,1399,1515];

%1324
x1 = [.01,.01,.03,.05,.22,.21,.09,.04,.05,.04,.03];
x2 = [.11,.19,.18,.17,.19,.32,.39,.43,.42,.48,.61];
y = [500,604,697,814,910,1023,1120,1205,1301,1404,1507];

% Plot x1 vs y and x2 vs y
figure;
plot(y, x1, '-o', 'DisplayName', 'Force'); % Line with markers for x1
hold on;
plot(y, x2, '-x', 'DisplayName', 'Moment'); % Line with markers for x2

% Fit a linear model to x1 and x2 data
p1 = polyfit(y, x1, 1); % First-degree polynomial fit for x1
p2 = polyfit(y, x2, 1); % First-degree polynomial fit for x2

% Generate best-fit lines using polyval
y_fit = linspace(min(y), max(y), 100); % Generate a range of y values for smooth fit lines
x1_fit = polyval(p1, y_fit); % Best-fit values for x1
x2_fit = polyval(p2, y_fit); % Best-fit values for x2

% Plot best-fit lines
plot(y_fit, x1_fit, '--','Color', [0.5, 0.5, 1], 'HandleVisibility', 'off');
plot(y_fit, x2_fit, '--','Color', [1, 0.5, 0.5], 'HandleVisibility', 'off');

% Adding labels, title, and legend
xlabel('RPM');
ylabel('x values');
title('Firing Order: 1-3-2-4');
legend;
grid on;
hold off;