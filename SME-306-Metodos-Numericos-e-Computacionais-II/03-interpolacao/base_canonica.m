% Exemplo de teste
% base_canonica ([2 7.39; 2.2 9.03; 2.4 11.02], 2.3


function base_canonica (pontosInterpolacao, pontoAnalisar)

pontoInteresse = pontoAnalisar;

[numLinhas, numColunas] = size(pontosInterpolacao);

disp('Pontos Inseridos: ');
disp(pontosInterpolacao);

grauPolinomio = numLinhas - 1;

A = zeros(numLinhas); % matriz dos coeficientes

for j = 1:numLinhas
    for i = 1:numLinhas
        if j == 1
            A(i,j) = 1;
        else
            A(i,j) = pontosInterpolacao(i,1)^(j-1);
        end
    end
end

disp('Matriz dos Coeficientes: ');
disp(A);

% determinando b para resolver A*x = b
% x representa os coeficientes do polinomio interpolador

b = zeros(numLinhas,1);

for i = 1:numLinhas
    b(i,1) = pontosInterpolacao(i,2);
end

% x = inv(A)*b 
% coeficientes = x

coeficientes = inv(A)*b;

contador = 0;
fprintf('Coeficientes do Polinomio Interpolador de Grau %d:\n', grauPolinomio)
for i = 1:length(coeficientes)
    fprintf('Coeficiente a%d: %f\n', i-1, coeficientes(i))
end

valorInterpolado = 0;
for i = 1:length(coeficientes)
    valorInterpolado = valorInterpolado + coeficientes(i)*(pontoInteresse^(i-1));
end

fprintf('O valor interpolado para %f pela base canônica é: %f\n',pontoInteresse,valorInterpolado)

end