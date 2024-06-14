% Read the CSV file
data = csvread('Walmart_Sales.csv', 1, 0);

% Extract unemployment and weekly_sales data
x = data(:, 8); % Assuming 'Unemployment' is the 8th column
y = data(:, 3); % Assuming 'Weekly_Sales' is the 3rd column

% Function to do linear interpolation
function y_search = linearInterpolate(x, y, x_search)
    % Find the closest 2 points
    for i = 1:length(x) - 1
        if x(i) <= x_search && x_search <= x(i+1)
            y_search = y(i) + (y(i+1) - y(i)) * (x_search - x(i)) / (x(i+1) - x(i));
            return;
        end
    end
end

% Generate 10,000 new x points to show the interpolation result
x_interpolate = linspace(min(x), max(x), 10000);

% Interpolate to find corresponding weekly_sales values using Linear Interpolation
y_interpolate = zeros(size(x_interpolate));
for i = 1:length(x_interpolate)
    y_interpolate(i) = linearInterpolate(x, y, x_interpolate(i));
end

% Create the plot
figure;
hold on;
scatter(x, y, 'b', 'DisplayName', 'Data points');
plot(x_interpolate, y_interpolate, 'r', 'DisplayName', 'Linear Interpolation');

% Add title & label
title('Weekly Sales vs. Unemployment with Linear Interpolation');
xlabel('Unemployment');
ylabel('Weekly Sales');
legend('show');
set(gca, 'FontSize', 24);
grid on;

hold off;

