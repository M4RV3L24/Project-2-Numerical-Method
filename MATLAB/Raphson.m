function x = Raphson(A, b, n,precision)
    % Fungsi newton_raphson untuk mencari solusi sistem persamaan linear
    % Menggunakan metode Newton-Raphson.
    %
    % Masukan:
    % n - jumlah persamaan/variabel yang tidak diketahui
    % A - matriks koefisien persamaan
    % b - vektor konstanta pada sisi kanan persamaan
    % precision - jumlah digit desimal dari akurasi yang ingin dicapai
    %
    % Keluaran:
    % x - vektor solusi

    % Inisialisasi vektor solusi x dengan nol
    x = zeros(n, 1);

    % Toleransi kesalahan
    es = (0.5 * 10^(2 - precision)) / 100;

    % Inisialisasi penghitung iterasi
    iter_count = 0;

    % Lakukan iterasi sampai konvergen
    while true
        % Salin x untuk menghitung kesalahan (ea)
        x_temp = x;

        % Inisialisasi matriks Jacobian j
        j = zeros(n, n);
        for i = 1:n
            for k = 1:n
                j(i, k) = A(i, k);
            end
        end

        % Hitung f(x), nilai fungsi pada pendekatan saat ini
        fx = zeros(n, 1);
        for i = 1:n
            equation = -b(i);
            for k = 1:n
                equation += (A(i, k) * x(k));
            end
            fx(i) = equation;
        end

        % Perbarui vektor solusi menggunakan rumus Newton-Raphson: x = x - J^-1 * f(x)
        x -= inv(j) * fx;

        % Hitung kesalahan untuk setiap elemen vektor solusi
        ea = abs((x - x_temp) ./ x) * 100;

        % Cetak hasil iterasi
        printf('Iteration %d:\n', iter_count + 1);
        printf('xi = %s\n', mat2str(x, precision));
        printf('ea(%%) = %s\n\n', mat2str(ea, precision));

        % Periksa apakah kriteria penghentian terpenuhi
        if all(ea <= es)
            break;
        end

        iter_count += 1;
    end
end


