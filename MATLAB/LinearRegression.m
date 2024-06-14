% Read the CSV file
data = csvread('Walmart_Sales.csv', 1, 0);

% Extract columns
x = data(:, 8);  % Unemployment
y = data(:, 3);  % Weekly_sales

% Number of data points
n = length(x);

% Calculate data for linear regression
sum_x = sum(x);
sum_y = sum(y);
sum_xy = sum(x .* y);
sum_x2 = sum(x .^ 2);
mean_x = mean(x);
mean_y = mean(y);

% Calculate a1, a0
a1 = (n * sum_xy - sum_x * sum_y) / (n * sum_x2 - sum_x^2);
a0 = mean_y - a1 * mean_x;

% Calculate the linear regression line
regression_line = a0 + a1 * x;

% Print the coefficients
printf('Slope (a1): %.2f\n', a1);
printf('Intercept (a0): %.2f\n', a0);

% Create the plot
figure;
scatter(x, y, 'b', 'DisplayName', 'Data points');
hold on;
plot(x, regression_line, 'r', 'DisplayName', sprintf('Linear regression: y = %.2f + %.2fx', a0, a1));

% Add title and labels
title('Weekly Sales vs. Unemployment with Linear Regression');
xlabel('Unemployment');
ylabel('Weekly Sales');
legend('show');
set(gca, 'FontSize', 24);
