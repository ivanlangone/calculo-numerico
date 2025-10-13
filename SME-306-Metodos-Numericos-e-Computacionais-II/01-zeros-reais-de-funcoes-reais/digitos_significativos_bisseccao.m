% Exemplos de teste

% digitos_significativos_bisseccao(@(x) ((3*x - 5)/(x - 4)),0,1,3)
% digitos_significativos_bisseccao(@(x) ((3*x - 5)/(x - 4)),0,5,3)

function digitos_significativos_bisseccao(funcao,A,B,D)
format long;

% Entrada 01: Função
f = @(x) funcao(x);

% Entrada 02: Intervalo
a = A;
b = B;

% Entrada 03: Quantidade de digitos significativos
d = D;

% Tolerancia para N digitos significativos
tolerancia = 0.5 * 10^-d;

maximoIteracao = 10000;

convergiu = false;

contador = 0;

plota_grafico(f);

raiz_old = 0;

% Verifica se f(a)*f(b) < 0

if f(a) * f(b) >= 0
    disp("Introduza novo intervalo tal que f(a) * f(b) < 0")
    return
else 

    if (b - a) < tolerancia
        raiz = (a + b)/2;
        disp("Foi necessária 01 iteração")
        fprintf('A raiz da função é: %.10f \n\n', raiz)
    else
    
        % Numero minimo de iteracoes (k)
        k = ceil((log10(b - a) - log10(tolerancia))/log10(2));
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
        
            if f(a) * f(x) < 0
                b = x;
            else
                a = x;
            end

            raiz_new = (a + b) / 2;
    
            if abs(raiz_new - raiz_old)/abs(raiz_new) < tolerancia
                raiz = raiz_new;
                fprintf('Raiz encontrada: %.10f\n', raiz);
                convergiu = true;
                break
            end
    
            raiz_old = raiz_new;

        end        
    end    
end
end