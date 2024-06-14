% Nicholas Sindoro      C14220142
% Christophorus Ivan    C14220210
% Marvel Wilbert O      C14220223

function x = GaussSeidel(A, b, n, es, maxit)
    % GaussSeidel: Solves system of linear equations using Gauss-Seidel method
    %
    % Inputs:
    % A - coefficient matrix
    % b - constant vector
    % n - number of equations
    % es - desired relative error (default: 0.00001)
    % maxit - maximum number of iterations (default: 50)
    %
    % Output:
    % x - solution vector

    % Check if at least 3 input arguments are provided
    if nargin < 3
        error('At least 3 input arguments required');
    end

    % Set default maximum iterations if not provided
    if nargin < 5 || isempty(maxit)
        maxit = 50;
    end

    % Set default tolerance if not provided
    if nargin < 4 || isempty(es)
        es = 0.00001;
    end

    % Get the size of matrix A
    [m, n_A] = size(A);

    % Check if A is a square matrix and matches the number of equations n
    if m ~= n_A || m ~= n
        error('Matrix A must be square and match the number of equations n');
    end

    % Initialize C matrix and x vector
    C = A;
    x = zeros(n, 1);

    % Set the diagonal elements of C to zero
    for i = 1:n
        C(i, i) = 0;
    end

    % Normalize the rows of C and calculate the d vector
    for i = 1:n
        C(i, :) = C(i, :) / A(i, i);
        d(i) = b(i) / A(i, i);
    end

    % Initialize iteration counter and error array
    iter = 0;
    ea = zeros(n, 1);
    errors = zeros(maxit, 1);


    % Start iteration
    while (1)
        x_old = x;  % Store the old x values for error calculation

        % Update each element of x
        for i = 1:n
            x(i) = d(i) - C(i, :) * x;

            % Calculate the approximate relative error
            if x(i) ~= 0
                ea(i) = abs((x(i) - x_old(i)) / x(i)) * 100;
            end
        end

        % Increment the iteration counter
        iter = iter + 1;

        max_ea = max(ea);
        errors(iter) = max_ea;
        disp(['Iteration ', num2str(iter), ': Approximation error = ', num2str(max_ea)]);

        % Check for convergence or maximum iterations
        if max(ea) <= es || iter >= maxit
            break;
        end
    end



end

