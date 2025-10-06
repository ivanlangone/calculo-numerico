% Exemplo de teste

% Digitos_Significativos_Newton_Raphson(@(x) (x*log(x) + x^2),0.5,2)
% Digitos_Significativos_Newton_Raphson(@(x) (sqrt(x)*exp(x) - 2),0.6,2)
% Digitos_Significativos_Newton_Raphson(@(x) (x^3 + x - 100),5,2)
% Digitos_Significativos_Newton_Raphson(@(x) (x^2 - 2),1.5,2)
% Digitos_Significativos_Newton_Raphson(@(x) (x^2 - 2),-1.5,2)
% Digitos_Significativos_Newton_Raphson(@(x) ((3*x - 5) / (x - 4)),2,2)
% Digitos_Significativos_Newton_Raphson(@(x) (2*x - 4),2,2)

function [] = newtonRaphson(funcao,chute_inicial,digitoSignificativo)
format long;

% Entrada 01: Função
f = @(x) funcao(x);

% apenas para facilitar o cálculo da derivada
syms x; % Definir variável simbólica
f_sym = funcao(x); % Converter a função handle para simbólica

% Entrada 02: Chute inicial
x0 = chute_inicial;

% Entrada 03: Tolerancia para N digitos significativos
tolerancia = 0.5*10^-digitoSignificativo;

% Derivada da funcao
derivada = diff(f_sym,x)

raiz = "";

max_iteracao = 100;

convergiu = false;

contador = 0;

if abs(f(x0)) < tolerancia
    raiz = x0;
    fprintf('Raiz encontrada: %.10f\n', raiz);

else
    for i=1:max_iteracao
    
        contador = contador + 1;
        fprintf('Iteração %d\n', contador)
        
        % subs: substitui x por x0 na derivada
        % double: transforma em um numero o resultado da substituicao (subs)
    
        x1 = x0 - ((f(x0))/double(subs(derivada,x,x0)))
    
        if (abs(x1 - x0) / abs(x1)) < tolerancia
            raiz = x1;
            fprintf('Raiz encontrada: %.10f\n', raiz);
            convergiu = true;
            break
        end
    
        x0 = x1;
    end     
end
end
