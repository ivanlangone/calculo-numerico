function y_eval = avalia_funcao_spline(x_eval_vec, x_nodes, n, a, b, c, d)

% Esta função avalia a spline (definida pelos coeficientes a,b,c,d)
% para um vetor de pontos de entrada x_eval_vec.

% A forma do polinômio é:
% S_k(x) = a(k)(x-x(k+1))^3 + b(k)(x-x(k+1))^2 + c(k)(x-x(k+1)) + d(k)
% Onde 'k' é o intervalo tal que x_nodes(k) <= x_val < x_nodes(k+1)


[~, ~, bins] = histcounts(x_eval_vec, x_nodes);

bins(x_eval_vec == x_nodes(end)) = n;
bins(bins == 0 & x_eval_vec == x_nodes(1)) = 1;
bins(bins == 0) = 1;

a_k = a(bins);
b_k = b(bins);
c_k = c(bins);
d_k = d(bins);

x_k_plus_1 = x_nodes(bins + 1);

dx = x_eval_vec - x_k_plus_1;

y_eval = a_k.*(dx.^3) + b_k.*(dx.^2) + c_k.*dx + d_k;

end