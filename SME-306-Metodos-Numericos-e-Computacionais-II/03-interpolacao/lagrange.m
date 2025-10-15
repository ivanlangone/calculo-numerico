% Exemplo de teste
% lagrange ([2 7.39; 2.2 9.03; 2.4 11.02], 2.3)


function lagrange (pontosInterpolacao, pontoAnalisar)

pontoInteresse = pontoAnalisar;

[numLinhas, numColunas] = size(pontosInterpolacao);

disp('Pontos Inseridos: ');
disp(pontosInterpolacao);

grauPolinomio = numLinhas - 1;

Lix = [];

LixTemporario = 1;

% calculando os polinomios de base de Lagrange - Li(x)

for i = 1:(grauPolinomio + 1)
    for j = 1:numLinhas
        if j ~= i
            LixTemporario = LixTemporario * ((pontoInteresse - pontosInterpolacao(j,1))/(pontosInterpolacao(i,1) - pontosInterpolacao(j,1)));
        end
    end

    Lix = [Lix;LixTemporario];

    LixTemporario = 1;

end

disp('Polinômios de Base de Lagrange')
contador = 0;
for i = 1:length(Lix)
    fprintf('L%d(x): %f\n', i-1, Lix(i))
end

valorInterpolado = 0;
for i = 1:length(Lix)
    valorInterpolado = valorInterpolado + Lix(i)*(pontosInterpolacao(i,2));
end

fprintf('O polinômio interpolador por Lagrange é de grau %d e\n', grauPolinomio)
fprintf('o valor interpolado para %f é de: %f\n',pontoInteresse,valorInterpolado)

end