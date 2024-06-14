import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

# Read csv file
df = pd.read_csv('Walmart_Sales.csv')

# Get unemployment and weekly_sales data
x = df['Unemployment']
y = df['Weekly_Sales']

# Number of data
n = len(x)

# Calculate data for linear regression
sum_x = np.sum(x)
sum_y = np.sum(y)
sum_xy = np.sum(x * y)
sum_x2 = np.sum(x ** 2)
mean_x = np.mean(x)
mean_y = np.mean(y)

# Calculate a1, a0
a1 = (n * sum_xy - sum_x * sum_y) / (n * sum_x2 - sum_x ** 2)
a0 = mean_y - a1 * mean_x

# Calculate the linear regression
regression_line = a0 + a1 * x

# Print the coefficients
print(f'Slope (a1): {a1}')
print(f'Intercept (a0): {a0}')

# Create the plot
plt.figure(figsize=(10, 6))
plt.scatter(x, y, color='blue', label='Data points')
plt.plot(x, regression_line, color='red', label=f'Linear regression: y = {a0:.2f} + {a1:.2f}x')

# Add title & label
plt.title('Weekly Sales vs. Unemployment with Linear Regression')
plt.xlabel('Unemployment')
plt.ylabel('Weekly Sales')
plt.legend()

# Show the plot
plt.grid(True)
plt.show()
