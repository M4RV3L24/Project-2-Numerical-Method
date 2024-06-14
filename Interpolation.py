import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import scipy.optimize

# Read csv file
df = pd.read_csv('Walmart_Sales.csv')

# Get unemployment and weekly_sales data
x = df['Unemployment'].values
y = df['Weekly_Sales'].values

# Function to do linear interpolation
def linearInterpolate(x_search):
    # Find the closest 2 point
    for i in range(0, len(x)-1):
        if x[i] <= x_search and x_search <= x[i+1]:
            return y[i] + (y[i+1] - y[i]) * (x_search - x[i]) / (x[i+1] - x[i])

# Generate 10,000 new x point to show the interpolation result
x_interpolate = np.linspace(x.min(), x.max(), 10000)

# Interpolate to find corresponding weekly_sales values using Linear Interpolation
y_interpolate = np.array([])
for x_search in x_interpolate:
    y_interpolate = np.append(y_interpolate, linearInterpolate(x_search))

# Create the plot
plt.figure(figsize=(10, 6))
plt.scatter(x, y, color='blue', label='Data points')
plt.plot(x_interpolate, y_interpolate, color='red', label=f'Linear Interpolation')

# Add title & label
plt.title('Weekly Sales vs. Unemployment with Linear Interpolation')
plt.xlabel('Unemployment')
plt.ylabel('Weekly Sales')
plt.legend()

# Show the plot
plt.grid(True)
plt.show()
