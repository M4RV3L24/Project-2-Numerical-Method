n = 3; % Number of equations/unknown variables
A = [3, -0.1, -0.2;0.1, 7, -0.3; 0.3, -0.2, 10]; % Coefficient matrix A
b = [7.85, -19.3, 71.4]; % Right-hand side vector b
es = 1e-6; % Tolerance for accuracy
precision = 5;


x_gs = GaussSeidel(A, b, n, es);
disp('Solusi Gauss Seidel: ');
disp(x_gs);

disp('');

x_jacobi = Jacobi(A, b, n, es);
disp("Solusi Jacobi: ");
disp(x_jacobi);

disp('');

x_raphson = Raphson(A, b, n, precision);
disp("Solusi Newton-Raphson: ");
disp(x_raphson);




