% Read the CSV file
data = csvread('Walmart_Sales.csv', 1, 0);

% Extract columns
x = data(:, 8);  % Unemployment
y = data(:, 3);  % Weekly_sales

% Define the nonlinear model function as y = a * (1 - e^(b * x)) + c
function y_model = model(params, x)
    a = params(1);
    b = params(2);
    c = params(3);
    y_model = a * (1 - exp(b * x)) + c;
end

% Define function for SSE
function sse = SSE(params, x, y)
    y_model = model(params, x);
    sse = sum((y - y_model) .^ 2);
end

% Initial guess for a, b, c
initial_params = [1.0, -0.1, 1.0];

% Search the optimal a, b, and c using fminsearch function
result = fminsearch(@(params) SSE(params, x, y), initial_params);

% Get the optimized parameters
a_opt = result(1);
b_opt = result(2);
c_opt = result(3);

% Print final parameters
printf('Optimized parameters: a = %.4f, b = %.4f, c = %.4f\n', a_opt, b_opt, c_opt);

% Calculate fitted values
y_pred = model(result, x);

% Create the plot
figure;
scatter(x, y, 'b', 'DisplayName', 'Data points');
hold on;
plot(x, y_pred, 'r', 'DisplayName', sprintf('Nonlinear regression: y = %.2f * (1 - e^{%.2f * x}) + %.2f', a_opt, b_opt, c_opt));

% Add title & label
title('Weekly Sales vs. Unemployment with Nonlinear Regression');
xlabel('Unemployment');
ylabel('Weekly Sales');
legend('show');
set(gca, 'FontSize', 24);
