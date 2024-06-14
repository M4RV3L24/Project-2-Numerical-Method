import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import scipy.optimize

# Read csv file
df = pd.read_csv('Walmart_Sales.csv')

# Get unemployment and weekly_sales data
x = df['Unemployment'].values
y = df['Weekly_Sales'].values

# Define the nonlinear model function as y = a * (1 - e^(b * x)) + c
def model(params, x):
    a, b, c = params
    return a * (1 - np.exp(b * x)) + c

# Define function for SSE
def SSE(params, x, y):
    y_model = model(params, x)
    return np.sum((y - y_model) ** 2)

# Initial guess for a, b, c
initial_params = [1.0, -0.1, 1.0]

# Search the optimal a, b, and c using fmin function
result = scipy.optimize.fmin(func=SSE, x0=initial_params, args=(x, y), xtol=1e-8, ftol=1e-8)

# Get the optimized parameters
a_opt, b_opt, c_opt = result

# Print final parameters
print(f'Optimized parameters: a = {a_opt:.4f}, b = {b_opt:.4f}, c = {c_opt:.4f}')

# Calculate fitted values
y_pred = model(result, x)

# Create the plot
plt.figure(figsize=(10, 6))
plt.scatter(x, y, color='blue', label='Data points')
plt.plot(x, y_pred, color='red', label=f'Nonlinear regression: y = {a_opt:.2f} * (1 - e^({b_opt:.2f} * x)) + {c_opt:.2f}')

# Add title & label
plt.title('Weekly Sales vs. Unemployment with Nonlinear Regression')
plt.xlabel('Unemployment')
plt.ylabel('Weekly Sales')
plt.legend()

# Show the plot
plt.grid(True)
plt.show()
