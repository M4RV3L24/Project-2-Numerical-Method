% Nicholas Sindoro      C14220142
% Christophorus Ivan    C14220210
% Marvel Wilbert O      C14220223

function [x, errors] = Jacobi(A, b, n, es, maxit)
    % Jacobi: Solves system of linear equations using Jacobi method
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
    % errors - array of approximation errors at each iteration

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

    % Initialize x vector
    x = zeros(n, 1);

    % Initialize iteration counter and error array
    iter = 0;
    errors = zeros(maxit, 1);

    % Start iteration
    while true
        x_old = x;  % Store the old x values for error calculation

        % Update each element of x
        for i = 1:n
            sigma = A(i, :) * x_old - A(i, i) * x_old(i);
            x(i) = (b(i) - sigma) / A(i, i);

            % Calculate the approximate relative error
            if x(i) ~= 0
                ea(i) = abs((x(i) - x_old(i)) / x(i)) * 100;
            end
        end

        % Increment the iteration counter
        iter = iter + 1;

        % Calculate maximum error and store in errors array
        max_ea = max(ea);
        errors(iter) = max_ea;
        disp(['Iteration ', num2str(iter), ': Approximation error = ', num2str(max_ea)]);

        % Check for convergence or maximum iterations
        if max(ea) <= es || iter >= maxit
            break;
        end
    end

    % Trim errors array to remove excess zeros
    errors = errors(1:iter);
end

