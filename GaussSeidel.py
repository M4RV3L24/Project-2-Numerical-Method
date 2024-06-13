import numpy as np
import matplotlib.pyplot as plt
from tabulate import tabulate as tab


def gauss_seidel(A, b, n, tol):

    global table_content, table_header

    # Initialize the solution vector with zeros
    x = np.zeros(n)
    
    # Maximum number of iterations to avoid infinite loops
    max_iter = 1000
    ea = np.zeros(n)

    # Iterative process
    for k in range(max_iter):
        # Store the current solution to compare later
        
        x_old = x.copy()
        
        # Iterate through each variable
        for i in range(n):
            # Calculate the sum of A[i, j] * x[j] for j < i
            sum1 = np.dot(A[i, :i], x[:i])
            
            # Calculate the sum of A[i, j] * x_old[j] for j > i
            sum2 = np.dot(A[i, i+1:], x_old[i+1:])
            
            # Update the value of x[i] using the Gauss-Seidel formula
            x[i] = (b[i] - sum1 - sum2) / A[i, i]

            # Calculate the approximate relative error
            ea[i] = abs((x[i] - x_old[i])/x[i]) * 100
        
        table_content.append([k, np.array2string(x), np.array2string(ea)])
        
        # Check for convergence using Eucledean norm to ensure all x is considered.
        # if np.linalg.norm(x - x_old) < tol:
        #     # If the solution has converged, exit the loop
        #     break

        # Check for convergence using the maximum relative error
        if np.max(ea) <= tol:
            # If the solution has converged, exit the loop
            break
    
    # Return the final solution vector
    print(tab(table_content, headers=table_header, tablefmt="grid"))
    return x

# data for table
table_header = ['iteration', 'xi', 'ea(%)']
table_content = []

# Define the coefficient matrix A
A = np.array([
    [3, -0.1, -0.2],  # Coefficients of the first equation
    [0.1, 7, -0.3],  # Coefficients of the second equation
    [0.3, -0.2, 10]   # Coefficients of the third equation
])

# Define the constant vector b
b = np.array([7.85, -19.3, 71.4])  # Constants on the right-hand side of the equations

# Define the number of unknowns n
n = len(b)  # Number of equations/unknowns

# Define the tolerance for convergence
tol = 1e-6  # Accuracy to be achieved

# Solve the system using the Gauss-Seidel method
x = gauss_seidel(A, b, n, tol) #same as using alpha = 1 for relaxation

# Print the solution
print("Solution:", x)
