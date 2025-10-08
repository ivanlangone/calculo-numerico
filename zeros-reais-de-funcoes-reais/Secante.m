% Exemplo de teste

% secante(@(x) (x^3 - 9*x + 3),0,1,5*10^-4,5*10^-4)

function secante(funcao,chute_inicial_00,chute_inicial_01,epsilon01,epsilon02)

format long;

% Entrada 01: Função
f = @(x) funcao(x);

% Entrada 02: Chute inicial
x0 = chute_inicial_00;
x1 = chute_inicial_01;

% Entrada 03: Tolerancias
tolerancia_01 = epsilon01;
tolerancia_02 = epsilon02;

max_iteracao = 10000;

convergiu = false;

contador = 0;

plota_grafico(f);

raiz = "";

for i=1:max_iteracao

    contador = contador + 1;
    fprintf('Iteração %d\n', contador);

    if abs(f(x0)) < tolerancia_01
        raiz = x0;
        fprintf('Raiz encontrada: %.10f\n', raiz);

    elseif abs(f(x0)) < tolerancia_01 || abs(x1 - x0) < tolerancia_02
        raiz = x1;
        fprintf('Raiz encontrada: %.10f\n', raiz);
    
    else

        x2 = x1 - ((f(x1) * (x1 - x0)) / (f(x1) - f(x0)));
        raiz = x2;
        fprintf('Raiz encontrada: %.10f\n', raiz);

        if abs(f(x2)) < tolerancia_01 || abs(x2 - x1) < tolerancia_02
            raiz = x2;
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