% Exemplos de teste

% ponto_fixo(@(x) (x^3 - 9*x + 3),@(x) ((x^3)/9 + 1/3),0.5,5*10^-4,5*10^-4)


function ponto_fixo(funcao_encontrar_raiz,funcao_iteracao,chute_inicial,epsilon01,epsilon02)
format long;

% Entrada 00: Função a ser encontrada a raiz
f = @(x) funcao_encontrar_raiz(x);
plota_grafico(f)

% Entrada 01: Função de iteração
F = @(x) funcao_iteracao(x);

% Entrada 02: Chute inicial
x0 = chute_inicial;

% Entrada 03: Tolerancias
tolerancia_01 = epsilon01;
tolerancia_02 = epsilon02;

raiz = "";

max_iteracao = 10000;

convergiu = false;

contador = 0;

if abs(F(x0)) < tolerancia_01
    raiz = x0;
    fprintf('Raiz encontrada: %.10f\n', raiz);

else
    for i=1:max_iteracao

        contador = contador + 1;
        fprintf('Iteração %d\n', contador)
    
        y_funcao_iteracao = F(x0);    
        x1 = y_funcao_iteracao;

        if abs(F(x1)) < tolerancia_01 || abs(x1 - x0) < tolerancia_02
            raiz = x1;
            fprintf('Raiz encontrada: %.10f\n', raiz);
            fprintf('f(x): %.10f\n', f(raiz));
            convergiu = true;
            break
        end

        raiz = x1;
        fprintf('Raiz encontrada: %.10f\n', raiz);
        fprintf('f(x): %.10f\n', f(raiz));

        x0 = x1;

    end

    if ~convergiu
        warning('Não convergiu após %d iterações. Última aproxim: %.12f', max_iteracao, x1);
    else
        fprintf('A raiz da função principal é: %.10f\n', raiz);
    end

end

end
