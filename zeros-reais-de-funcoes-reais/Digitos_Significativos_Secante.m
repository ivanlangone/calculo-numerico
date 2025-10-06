% Exemplo de teste

% Digitos_Significativos_Secante(@(x) (x*log(x) + x^2),0.8,0.5,2)
% Digitos_Significativos_Secante(@(x) (sqrt(x)*exp(x) - 2),0.3,0.4,2)
% Digitos_Significativos_Secante(@(x) (x^3 + x - 100),4.5,5,2)
% Digitos_Significativos_Secante(@(x) (x^2 - 2),1.5,1.8,2)
% Digitos_Significativos_Secante(@(x) (x^2 - 2),-1.5,-1.8,2)
% Digitos_Significativos_Secante(@(x) ((3*x - 5) / (x - 4)),0.5,2,2)
% Digitos_Significativos_Secante(@(x) (2*x - 4),0.5,2,2)

function [] = secante(funcao,chute_inicial_00,chute_inicial_01,digitoSignificativo)
format long;

% Entrada 01: Função
f = @(x) funcao(x);

% Entrada 02: Chute inicial
x0 = chute_inicial_00;
x1 = chute_inicial_01;

% Entrada 03: Tolerancia para N digitos significativos
tolerancia = 0.5*10^-digitoSignificativo;

max_iteracao = 10000;

convergiu = false;

contador = 1;

raiz = "";

for i=1:max_iteracao

    contador = contador + 1;
    fprintf('Iteração %d\n', contador)

    if abs(f(x0)) < tolerancia
        raiz = x0;
        fprintf('Raiz encontrada: %.10f\n', raiz);

    elseif abs(f(x0)) < tolerancia || abs(x1 - x0) < tolerancia
        raiz = x1;
        fprintf('Raiz encontrada: %.10f\n', raiz);
    
    else

        x2 = x1 - ((f(x1) * (x1 - x0)) / (f(x1) - f(x0)))

        if (abs(x2 - x1) / abs(x2)) < tolerancia
            raiz = x2;
            fprintf('Raiz encontrada: %.10f\n', raiz);
            convergiu = true;
            break;
        end
        
        x0 = x1;
        x1 = x2;

    end

end

if ~convergiu
    fprintf('Método não convergiu após %d iterações.\n', max_iteracao);
else
    fprintf('A raiz da função principal é: %.10f\n', raiz);
end

end