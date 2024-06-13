import numpy as np

def newton_raphson(n, matrix, precision):
    # Initialize solution vector x with zeros
    x = np.zeros(n)

    # Calculate the stopping criteria es based on the given precision
    es = (0.5 * 10**(2 - precision)) / 100

    while True:
        # Make a copy of x to calculate the error (ea)
        x_temp = np.copy(x)

        # Initialize Jacobian matrix j
        j = np.zeros((n, n))
        for i in range(n):
            for k in range(n):
                j[i][k] = matrix[i][k]

        # Calculate f(x), which is the function values at the current approximation
        fx = np.zeros(n)
        for i in range(n):
            equation = - matrix[i][n]
            for k in range(n):
                equation += (matrix[i][k] * x[k])
            fx[i] = equation

        # Update the solution vector using the Newton-Raphson formula: x = x - J^-1 * f(x)
        x -= np.dot(np.linalg.inv(j), fx)

        # Calculate the error for each element of the solution vector
        e = np.abs(x - x_temp)

        # print data
        print("x: ", x)

        # Check if the stopping criteria is met
        if np.all(e <= es):
            return x

# Input the value of n (size of the matrix)
n = int(input("Input n: "))
matrix = []

# Loop to take the matrix inputs from the user
for i in range(n):
    temp = []
    for j in range(n + 1):
        # Input the value for each element in the matrix
        x = float(input(f'Input matrix[{i}][{j}]: '))
        temp.append(x)
    matrix.append(temp)

# Input the precision for the solution
precision = int(input('Input precision: '))


# Print the input matrix
print("Input matrix:")
for i in range(n):
    for j in range(n + 1):
        print(matrix[i][j], end=" ")
    print("")

# Call the newton_raphson function and print the result
result = newton_raphson(n, matrix, precision)
print("Solution vector:")
print(result)
