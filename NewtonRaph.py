# Nicholas Sindoro      C14220142
# Christophorus Ivan    C14220210
# Marvel Wilbert O      C14220223


import numpy as np
from tabulate import tabulate as tab

def newton_raphson(n, A, b, precision):
    global table_content, table_header

    # Initialize solution vector x with zeros
    x = np.zeros(n)

    # Error tolerance
    es = (0.5 * 10**(2 - precision)) / 100

    # Maximum number of iterations to avoid infinite loops
    max_iter = 1000

    # Initialize the iteration counter
    iter_count = 0

    while iter_count < max_iter:
        # Make a copy of x to calculate the error (ea)
        x_temp = np.copy(x)

        # Initialize Jacobian matrix j
        j = np.zeros((n, n))
        for i in range(n):
            for k in range(n):
                j[i][k] = A[i][k]

        # Calculate f(x), which is the function values at the current approximation
        fx = np.zeros(n)
        for i in range(n):
            equation = -b[i]
            for k in range(n):
                equation += (A[i][k] * x[k])
            fx[i] = equation

        # Update the solution vector using the Newton-Raphson formula: x = x - J^-1 * f(x)
        x -= np.dot(np.linalg.inv(j), fx)

        # Calculate the error for each element of the solution vector
        ea = np.abs((x - x_temp) / x) * 100

        # Add iteration results to the table
        table_content.append([iter_count + 1, np.array2string(x, precision=precision), np.array2string(ea, precision=precision)])

        # Check if the stopping criteria is met
        if np.all(ea <= es):
            break

        iter_count += 1

    # Print the table
    print(tab(table_content, headers=table_header, tablefmt="grid"))

    return x

# data for table
table_header = ['Iteration', 'xi', 'ea(%)']
table_content = []

# Define the coefficient matrix A
A = np.array([
    [3, -0.1, -0.2],  # Coefficients of the first equation
    [0.1, 7, -0.3],   # Coefficients of the second equation
    [0.3, -0.2, 10]   # Coefficients of the third equation
])

# Define the constant vector b
b = np.array([7.85, -19.3, 71.4])  # Constants on the right-hand side of the equations

# Number of unknowns
n = len(b)

# Decimal precision
precision = 5

# Solve the system using the Newton-Raphson method
result = newton_raphson(n, A, b, precision)

# Print the solution
print("Solution vector:")
print(result)
