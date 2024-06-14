function x = Raphson(A, b, n, precision)
    % Newton-Raphson function to find the solution of a system of linear equations
    % Using the Newton-Raphson method.
    %
    % Inputs:
    % n - number of equations/unknown variables
    % A - matrix of equation coefficients
    % b - vector of constants on the right side of the equations
    % precision - number of decimal digits for the desired accuracy
    %
    % Outputs:
    % x - solution vector

    % Initialize the solution vector x with zeros
    x = zeros(n, 1);

    % Error tolerance
    es = (0.5 * 10^(2 - precision)) / 100;

    % Initialize iteration counter
    iter_count = 0;

    % Perform iterations until convergence
    while true
        % Copy x to calculate the error (ea)
        x_temp = x;

        % Initialize the Jacobian matrix j
        j = zeros(n, n);
        for i = 1:n
            for k = 1:n
                j(i, k) = A(i, k);
            end
        end

        % Calculate f(x), the function value at the current approximation
        fx = zeros(n, 1);
        for i = 1:n
            equation = -b(i);
            for k = 1:n
                equation += (A(i, k) * x(k));
            end
            fx(i) = equation;
        end

        % Update the solution vector using the Newton-Raphson formula: x = x - J^-1 * f(x)
        x -= inv(j) * fx;

        % Calculate the error for each element of the solution vector
        ea = abs((x - x_temp) ./ x) * 100;

        % Print the results of the iteration
        printf('Iteration %d:\n', iter_count + 1);
        printf('xi = %s\n', mat2str(x, precision));
        printf('ea(%%) = %s\n\n', mat2str(ea, precision));

        % Check if the stopping criterion is met
        if all(ea <= es)
            break;
        end

        iter_count += 1;
    end
end
