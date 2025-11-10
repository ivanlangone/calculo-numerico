function [a, b, c, d, x_nodes, n] = calcular_spline_coeficientes(x, y)
    % Entrada:
    % x: vetor dos nós (distância x_i)
    % y: vetor f(x) (altitude h_i)
    %
    % Saída:
    % a,b,c,d: Vetores de coeficientes da spline
    % x_nodes: Os nós originais
    % n: O número de intervalos

    if length(x) ~= length(y)
        warning("x e y de tamanhos distintos");
    end
    
    n = length(x) - 1;
    x_nodes = x;
    
    % 1. Computo de h_k = x_k+1 - x_k
    h = zeros(n, 1);
    for k = 1:n
        h(k) = x(k+1) - x(k);
    end
    
    A = zeros(n-1, n-1);
    A(1, 1:2) = [2*(h(1)+h(2)), h(2)];
    for i = 2:(n-2)
       A(i, (i-1):(i+1)) = [h(i), 2*(h(i)+h(i+1)), h(i+1)];
    end
    A(n-1, (n-2):(n-1)) = [h(n-1), 2*(h(n-1)+h(n))];
    
    b_sistema = zeros(n-1, 1);
    for i = 1:(n-1)
        b_sistema(i) = 6*((y(i+2)-y(i+1))/h(i+1) - (y(i+1)-y(i))/h(i));
    end
    
    g_sol = A \ b_sistema;
        
    M = [0; g_sol; 0];

    a = zeros(n, 1);    
    b = zeros(n, 1);
    c = zeros(n, 1);
    d = zeros(n, 1);
    
    for k = 1:n
        a(k) = (M(k+1) - M(k)) / (6 * h(k));
        b(k) = M(k+1) / 2; 
        d(k) = y(k+1);
        c(k) = (y(k+1)-y(k))/h(k) - (h(k)/6)*(2*M(k) + M(k+1));
    end
    
end