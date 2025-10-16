% Exemplo de teste
% newton ([2 7.39; 2.2 9.03; 2.4 11.02], 2.3)
% newton ([473 99.51; 573 93.71; 673 85.50; 773 74.71], 600)


function newton (pontosInterpolacao, pontoAnalisar)

format long

pontoInteresse = pontoAnalisar;

numLinhas = size(pontosInterpolacao,1);

disp('Pontos Inseridos: ');
disp(pontosInterpolacao);

grauPolinomio = numLinhas - 1;

% Inicializa a tabela com NaN (Not-a-Number) para que as células
% não utilizadas fiquem visualmente "vazias".
% A tabela terá N linhas e N+1 colunas (1 para x, 1 para y, e N-1 para as ordens)

tabelaOrdem = nan(numLinhas, numLinhas + 1);

% Coluna 1: Valores de x

tabelaOrdem(:,1) = pontosInterpolacao(:,1);

% Coluna 2: Valores de y (Diferenças de Ordem 0)

tabelaOrdem(:,2) = pontosInterpolacao(:,2);

% Cálculo das diferenças divididas de ordem 1 a ordem n

for j = 3:(numLinhas + 1)
    for i = 1:(numLinhas - j + 2)  

        numerador = tabelaOrdem(i + 1, j - 1) - tabelaOrdem(i, j - 1);            
        denominador = tabelaOrdem(i + j - 2, 1) - tabelaOrdem(i, 1);        
       
        tabelaOrdem(i, j) = numerador / denominador;

    end
end

disp('Tabela de Diferenças Divididas:');

nomesVariaveis = {'x', 'Ordem 0'};

for k = 1:numLinhas-1
    nomesVariaveis{end+1} = sprintf('Ordem %d', k);
end
    
tabelaOrdemFormatada = array2table(tabelaOrdem, 'VariableNames', nomesVariaveis);

disp(tabelaOrdemFormatada);

coeficientesPolinomio = [];

for j = 2:numLinhas + 1
    coeficientesPolinomio = [coeficientesPolinomio;tabelaOrdem(1,j)];

    fprintf('Coeficiente a%d: %f\n',j - 2,tabelaOrdem(1,j));
end

valorInterpolado = coeficientesPolinomio(numLinhas);

for i = (numLinhas-1):-1:1
    valorInterpolado = coeficientesPolinomio(i) + (pontoInteresse - pontosInterpolacao(i,1)) * valorInterpolado;
end

% O trecho das linhas 66 a 70 (cálculo da interpolação no ponto de
% interesse) funciona de trás para frente. Esse trecho poderia ser
% substituído pelo trecho comentado, abaixo, que mais trabalhosa e que não
% está na ordem inversa de realização dos cálculos
%
%
% valorInterpolado = coeficientesPolinomio(1);
% 
% for i = 1:numLinhas-1
% 
%     temporario = 1;
% 
%     for j = 1:i
% 
%         produto = temporario*(pontoInteresse - pontosInterpolacao(j,1));
% 
%         temporario = produto;
% 
%     end
% 
%     valorPolinomioPontoInteresse = valorInterpolado + coeficientesPolinomio(i+1)*temporario;
% 
%     temporario = 1;
% 
% end

fprintf('O polinômio interpolador por Newton (diferenças divididas) é de grau %d e\n', grauPolinomio)
fprintf('o valor interpolado para %f é de: %f\n',pontoInteresse,valorInterpolado)





end