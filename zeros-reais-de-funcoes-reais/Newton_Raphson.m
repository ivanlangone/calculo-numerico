% Exemplo de teste

% Newton_Raphson(@(x) (x^3 - 9*x + 3),1.5,10^-6,10^-6)

function [] = newtonRaphson(funcao,chute_inicial,epsilon01,epsilon02)
format long;

% Entrada 01: Função
f = @(x) funcao(x);

% apenas para facilitar o cálculo da derivada
syms x; % Definir variável simbólica
f_sym = funcao(x); % Converter a função handle para simbólica

% Entrada 02: Chute inicial
x0 = chute_inicial;

% Entrada 03: Tolerancias
tolerancia_01 = epsilon01;
tolerancia_02 = epsilon02;

% Derivada da funcao
derivada = diff(f_sym,x)

raiz = "";

max_iteracao = 100;

convergiu = false;

contador = 0;

if abs(f(x0)) < tolerancia_01
    raiz = x0;
    fprintf('Raiz encontrada: %.10f\n', raiz);

else
    for i=1:max_iteracao

        contador = contador + 1;
        fprintf('Iteração %d\n', contador)
        
        % subs: substitui x por x0 na derivada
        % double: transforma em um numero o resultado da substituicao (subs)

        x1 = x0 - ((f(x0))/double(subs(derivada,x,x0)))

        if abs(f(x1)) < tolerancia_01 || abs(x1 - x0) < tolerancia_02
            raiz = x1;
            fprintf('Raiz encontrada: %.10f\n', raiz);
            convergiu = true;
            break
        end

        x0 = x1;
    end

    if ~convergiu
        fprintf('Método não convergiu após %d iterações.\n', max_iteracao);
    else
        fprintf('A raiz da função principal é: %.10f\n', raiz);
    end
end

end