%Abhishek Ghosh
%ME21BTECH11001
%Question 2




function B_Spline_Plot()
    % Define control points
    control_points = [0 1; 2 6; 4 8; 5 2];
    n = 3; % n + 1 is the number of control points

    % Plot separately
    figure;
    hold on;
    % a) part
    n = 3;
    k = 4;
    plotBSpline(control_points, n, k, 'r', 'B-Spline: n=3, k=4');
    plot(control_points(:,1), control_points(:,2), 'o--', 'DisplayName', 'Control Points');
    legend;
    title('B-Spline with n = 3');
    xlabel('X-axis');
    ylabel('Y-axis');
    hold off;


    % b) part
    %n = 3 & 4
    figure;
    hold on;
    % n = 3
    control_points = [0 1; 2 6; 4 8; 5 2];
    k = 4;
    n = 3;
    plotBSpline(control_points, n, k, 'r', 'B-Spline: n=3, k=4');

    % n = 4
    control_points = [0 1; 2 6;2 6; 4 8; 5 2];
    k = 4;
    n = 4;
    plotBSpline(control_points, n, k, 'b', 'B-Spline: n=4, k=4');

    plot(control_points(:,1), control_points(:,2), 'o--', 'DisplayName', 'Control Points');

    % Finalize plot
    legend;
    title('B-Splines with Different n');
    xlabel('X-axis');
    ylabel('Y-axis');
    hold off;
    % c) part
    % Plot all together
    figure;
    hold on;
    % n = 3
    control_points = [0 1; 2 6; 4 8; 5 2];
    k = 4;
    n = 3;
    plotBSpline(control_points, n, k, 'r', 'B-Spline: n=3, k=4');

    % n = 4
    control_points = [0 1; 2 6;2 6; 4 8; 5 2];
    k = 4;
    n = 4;
    plotBSpline(control_points, n, k, 'b', 'B-Spline: n=4, k=4');

    % n = 5
    control_points = [0 1; 2 6;2 6;2 6; 4 8; 5 2];
    k = 4;
    n = 5;
    plotBSpline(control_points, n, k, 'g', 'B-Spline: n=5, k=4');

    plot(control_points(:,1), control_points(:,2), 'o--', 'DisplayName', 'Control Points');

    % Finalize plot
    legend;
    title('B-Splines with Different n');
    xlabel('X-axis');
    ylabel('Y-axis');
    hold off;
end

function curve = b_spline_curve(control_points, n, k)
    % Generate knot vector
    knots = [zeros(1, k), linspace(1, n - k + 1, n - k + 1), repmat(n - k + 2, 1, k)];
    
    % Define number of points to plot
    num_points = 100;
    t_values = linspace(0, n - k + 2, num_points);
    curve = zeros(num_points, 2);

    for j = 1:num_points
        t = t_values(j);
        point = [0, 0];
        for i = 1:n + 1
            b = basis_function(i - 1, k, t, knots); % MATLAB is 1-indexed
            point = point + b * control_points(i, :);
        end
        curve(j, :) = point;
    end
end

function b = basis_function(i, k, t, knots)
    if k == 1
        if knots(i + 1) <= t && t < knots(i + 2)
            b = 1.0;
        else
            b = 0.0;
        end
    else
        denom1 = knots(i + k) - knots(i + 1);
        denom2 = knots(i + k + 1) - knots(i + 2);
        
        if denom1 ~= 0
            term1 = ((t - knots(i + 1)) / denom1) * basis_function(i, k - 1, t, knots);
        else
            term1 = 0.0;
        end
        
        if denom2 ~= 0
            term2 = ((knots(i + k + 1) - t) / denom2) * basis_function(i + 1, k - 1, t, knots);
        else
            term2 = 0.0;
        end
        
        b = term1 + term2;
    end
end

function plotBSpline(control_points, n, k, color, label)
    curve = b_spline_curve(control_points, n, k);
    plot(curve(1:end-1,1), curve(1:end-1,2), color, 'DisplayName', label);
end
