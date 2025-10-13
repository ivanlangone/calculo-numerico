% Exemplos de teste

% bisseccao(@(x) ((3*x - 5)/(x - 4)),1,4,10^-4)
% bisseccao(@(x) ((3*x - 5)/(x - 4)),0,5,10^-4)

function bisseccao(funcao,A,B,E)
format long;

% Entrada 01: Função
f = @(x) funcao(x);

% Entrada 02: Intervalo
a = A;
b = B;

% Entrada 03: Erro/Tolerancia/Precisao
erro = E;

maximoIteracao = 10000;

convergiu = false;

contador = 0;

plota_grafico(f);

% Verifica se f(a)*f(b) < 0

if f(a) * f(b) >= 0
    disp("Introduza novo intervalo tal que f(a) * f(b) < 0")
    return
else 

    if (b - a) < erro
        raiz = (a + b)/2;
        disp("Foi necessária 01 iteração\n\n")
        fprintf('A raiz da função é: %.10f\n\n', raiz)
    else
    
        % Numero minimo de iteracoes (k)
        k = ceil((log10(b - a) - log10(erro))/log10(2));
        fprintf('Numero minimo de iteracoes (k): %d\n\n', k)
    
        for i=1:maximoIteracao
            contador = contador + 1;
            fprintf('Iteração %d\n', contador)
    
            fprintf('a: %.10f\n', a)
            fprintf('f(a): %.10f\n', f(a))
            fprintf('b: %.10f\n', b)
            fprintf('f(b): %.10f\n', f(b))
    
            x = (a + b)/2;
    
            fprintf('RAIZ DA FUNÇÃO ===> x: %.10f\n', x)
            fprintf('f(x): %.10f\n\n', f(x))

            if (b-a) < erro
                convergiu = true;
                break
            end
        
            if f(a) * f(x) < 0
                b = x;
            else
                a = x;
            end
        end        
    end
if ~convergiu
    fprintf("Tolerância não atingida após %d iterações. Aproximação final: %.15e", contador, x)
end
end
end
