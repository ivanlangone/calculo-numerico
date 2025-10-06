% Exemplos de teste

% Regula_Falsi(@(x) (exp(-x^2) - cos(x) + 0.5),1,6,10^-4,10^-4)

function [] = regula_falsi(funcao,A,B,epsilon01,epsilon02)
format long;

% Entrada 01: Função
f = @(x) funcao(x);

% Entrada 02: Intervalo
a = A;
b = B; 

% Entrada 03: Tolerancias
tolerancia_01 = epsilon01;
tolerancia_02 = epsilon02;

maximoIteracao = 10000;

convergiu = false;

contador = 0;

raiz_old = 0;

if f(a) * f(b) >= 0
    disp("Introduza novo intervalo tal que f(a) * f(b) < 0")
else
    if (b - a) < tolerancia_01
    raiz = (a + b)/2;
    disp("Foi necessária 01 iteração\n\n")
    fprintf('A raiz da função é: %.10f\n\n', raiz)

    elseif abs(f(a)) < tolerancia_02
        raiz = a;
        fprintf('A raiz da função é: %.10f\n\n', raiz)

    elseif abs(f(b)) < tolerancia_02
        raiz = b;
        fprintf('A raiz da função é: %.10f\n\n', raiz)
        
    else
        
        for i=1:maximoIteracao

            contador = contador + 1;
            fprintf('Iteração %d\n', contador)

            fprintf('a: %.10f\n', a)
            fprintf('f(a): %.10f\n', f(a))
            fprintf('b: %.10f\n', b)
            fprintf('f(b): %.10f\n', f(b))
    
            x = (a*(f(b)) - b*(f(a))) / (f(b) - f(a));
    
            fprintf('RAIZ DA FUNÇÃO ===> x: %.10f\n', x)
            fprintf('f(x): %.10f\n\n', f(x))

            if (b - a) < tolerancia_01 || abs(f(x)) < tolerancia_02
                raiz = x;
                convergiu = true;
                break
            end

            if f(a) * f(x) < 0
                b = x;
            else
                a = x;
            end
    
            raiz_new = (a*(f(b)) - b*(f(a))) / (f(b) - f(a));        
    
            raiz_old = raiz_new;

        end
    end
end

if ~convergiu
    fprintf("Tolerância não atingida após %d iterações. Aproximação final: %.15e", contador, x)
end

end




    