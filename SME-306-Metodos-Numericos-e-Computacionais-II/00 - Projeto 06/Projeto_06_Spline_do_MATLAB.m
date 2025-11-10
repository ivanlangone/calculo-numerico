clear all
clc

%pontosInterpolacao = [2 7.39; 2.2 9.03; 2.4 11.02; 3 7.3; 4 8.9]

disp('Pontos Inseridos: ');
disp('');

Haversine;

massa = 70;
gravidade = 9.8;
h_passo = 1e-6;

quantidadeIntervalosSimpson = 500; % quantidade par de intervalos
quantidadeIntervaloGauss = 500;

fprintf('Massa: %.2f kg\n\n', massa);
fprintf('Gravidade: %.2f m/s²\n\n', gravidade);
fprintf('Tamanho do passo (h): %.2f \n\n', h_passo);
fprintf('Nº de Intervalos para aplicar integração pela Regra de Simpson 1/3: %.2f \n\n', quantidadeIntervalosSimpson);
fprintf('Nº de Intervalos para aplicar integração pela Quadratura Gaussiana: %.2f \n\n', quantidadeIntervaloGauss);


% -------------------------------------------------------------------------

% Item 2(a): Interpolação pela SPLINE CÚBICA do MATLAB
% Método ideal e estável para muitos pontos

% Dados de distância - x
x_i = pontosInterpolacao(:, 1);

% Dados de altitude - h(x)
h_i = pontosInterpolacao(:, 2);

% Polinômio interpolador criado pela função Spline
P = @(x) spline(x_i, h_i, x);

% -------------------------------------------------------------------------

% Item 2(b): Cálculo da derivada por diferenças finitas centradas

D = max(x_i); % Comprimento horizontal total

derivada = (P(x_i + h_passo) - P(x_i - h_passo)) / (2 * h_passo);

disp('Derivada h''(x) em cada ponto:');
disp('');
disp(derivada);

% -------------------------------------------------------------------------

% Item 2(c): Cálculo do seno de theta

seno_theta = derivada ./ sqrt(1 + (derivada.^2));

disp('Seno de Theta');
disp('');
disp(seno_theta)

% -------------------------------------------------------------------------

% Item 2(d): Gráfico de Altitude e Derivada

x_plot = linspace(min(x_i), max(x_i), 1000);

h_plot = P(x_plot);

derivada_plot = (P(x_plot + h_passo) - P(x_plot - h_passo)) / (2 * h_passo);

figure;

colororder({'b', 'r'});

yyaxis left;

plot(x_plot, h_plot, 'b-', 'LineWidth', 2);

ylabel('Altitude h(x)');

hold on;

yyaxis right;

plot(x_plot, derivada_plot, 'r-', 'LineWidth', 2);

ylabel('Derivada h''(x)');

title('Perfil de Elevação h(x) vs Derivada do Perfil h''(x)');

legend('Altitude h(x)', 'Derivada h''(x)', 'Location', 'best');

grid on;

% -------------------------------------------------------------------------

% Item 3(a): Cálculo do integrando f(xi)

integrando_fxi = max(0, seno_theta) .* sqrt(1 + derivada.^2);

disp('Integrando f(x) em cada ponto:');
disp('');
disp(integrando_fxi);

% -------------------------------------------------------------------------

% Item 3(b) e 3(c): Implementação dos 3 métodos de integração

% Método1: Regra dos Trapézios
% Regra de Simpson 1/3
% quadratura Gaussiana

% -------------------------------------------------------------------------

% Método 1: Implementação MANUAL da Regra dos Trapézios
% Consiste em utilizar os dados originais, sem realizar uniformização

disp('Método 1: Implementação MANUAL da Regra dos Trapézios');
disp('');

somaAreaTrapezios = 0;
totalPontos = length(x_i);

for i = 1:(totalPontos - 1)
    
    alturaTrapezio = x_i(i+1) - x_i(i);
   
    altura_media = (integrando_fxi(i) + integrando_fxi(i+1)) / 2;
    
    somaAreaTrapezios = somaAreaTrapezios + (altura_media * alturaTrapezio);
end

trabalhoTrapezioManual = massa*gravidade*somaAreaTrapezios;
fprintf('Trabalho: %.2f Joules\n\n', trabalhoTrapezioManual);

% -------------------------------------------------------------------------

% Método 1: Utilizando a função TRAPZ do MATLAB para a Regra dos Trapézios

disp('Método 1: Utilizando a função TRAPZ dao MATLAB para a Regra dos Trapézios');
disp('');

integralArea = trapz(x_i, integrando_fxi);

trabalhoTrapezioFuncao = massa*gravidade*integralArea;

fprintf('Trabalho: %.2f Joules\n\n', trabalhoTrapezioFuncao);

% -------------------------------------------------------------------------

% Determinação de funções comuns aos Métodos 2 e 3

funcaoDerivada = @(x) (P(x + h_passo) - P(x - h_passo)) / (2 * h_passo);

funcaoSenoTheta = @(x) funcaoDerivada(x) ./ sqrt(1 + funcaoDerivada(x).^2);

funcaoIntegrandoFX = @(x) (funcaoSenoTheta(x) > 0) .* funcaoSenoTheta(x) .* sqrt(1 + funcaoDerivada(x).^2);

% Limites de integração
x_inicial = min(x_i);
x_final = max(x_i);

% -------------------------------------------------------------------------

% Método 1: Implementação MANUAL da Regra de Simpson 1/3
% Precisa realizar a uniformização dos pontos para que eles
% fiquem igualmente espaçados

disp('Método 2: Implementação MANUAL da Regra de Simpson 1/3');
disp('');

tamanhoPasso = (x_final - x_inicial) / quantidadeIntervalosSimpson;

soma = 0;

for i = 1:(quantidadeIntervalosSimpson / 2)

    x_impar = x_inicial + (2*i - 1) * tamanhoPasso;
    
    x_par = x_inicial + (2*i) * tamanhoPasso;
    
    if i == (quantidadeIntervalosSimpson / 2)  % O último ponto (f(b)) fica de fora do loop for
        x_par = x_final;
    end
  
    if i == 1
        soma = soma + funcaoIntegrandoFX(x_inicial);
    end
    
    soma = soma + 4 * funcaoIntegrandoFX(x_impar);
    
    if i < (quantidadeIntervalosSimpson / 2)
        soma = soma + 2 * funcaoIntegrandoFX(x_par);
    end
    
    if i == (quantidadeIntervalosSimpson / 2)
        soma = soma + funcaoIntegrandoFX(x_final);
    end
end

trabalhoSimpsonManual = ((massa*gravidade*tamanhoPasso)/3) * soma;
fprintf('Trabalho: %.2f Joules\n\n', trabalhoSimpsonManual);

% -------------------------------------------------------------------------

% Método 3: Implementação MANUAL da Quadratura Gaussiana
% Precisa realizar a uniformização dos pontos para que eles
% fiquem igualmente espaçados

disp('Método 3: Implementação MANUAL da Quadratura Gaussiana');
disp('');

tamanhoPassoGauss = (x_final - x_inicial) / quantidadeIntervaloGauss;

areaTotalGuass = 0;

% Nós t e pesos tabelados para Gauss-Legendre de n=4 pontos

no_T = [-0.8611363116, -0.3399810436, 0.3399810436, 0.8611363116];
noPeso = [0.3478548451, 0.6521451549, 0.6521451549, 0.3478548451];

for k = 0:(quantidadeIntervaloGauss - 1)
    
    % Limites [a, b] do intervalo

    a = x_inicial + k * tamanhoPassoGauss;
    b = a + tamanhoPassoGauss;
    
    soma_intervalo = 0; 
 
    for j = 1:4

        x = ((b-a)/2) * no_T(j) + ((b+a)/2);

        f = funcaoIntegrandoFX(x);
            
        soma_intervalo = soma_intervalo + noPeso(j) * f;
    end

    areaTotalGuass = areaTotalGuass + ((b-a)/2) * soma_intervalo;

end

trabalhoGaussManual = massa * gravidade * areaTotalGuass;
fprintf('Trabalho: %.2f Joules\n\n', trabalhoGaussManual);

% -------------------------------------------------------------------------

% Método 3: Utilizando a função INTEGRAL do MATLAB para a Quadratura Gaussiana

disp('Método 3: Utilizando a função INTEGRAL do MATLAB para a Quadratura Gaussiana');
disp('');

integralResultado = integral(funcaoIntegrandoFX, x_inicial, x_final);

trabalhoQuadraturaFuncao = (massa * gravidade) * integralResultado;

fprintf('Trabalho: %.2f Joules\n\n', trabalhoQuadraturaFuncao);

% -------------------------------------------------------------------------

% Item 4(a): Cáculo do trabalho líquido total (W) 

trabalhoLiquidoTotal = massa*gravidade*(h_i(end) - h_i(1));

fprintf('O trabalho líquido total (W) é: %.2f Joules\n\n', trabalhoLiquidoTotal);

% -------------------------------------------------------------------------

% Salva os resultados em um arquivo .txt
diary('Resultados_do_Projeto_06_Spline_do_MATLAB.txt');

% Salva a imagem do gráfico
saveas(gcf, 'Grafico_perfil_trajeto_Spline_do_MATLAB.jpg');

% -------------------------------------------------------------------------