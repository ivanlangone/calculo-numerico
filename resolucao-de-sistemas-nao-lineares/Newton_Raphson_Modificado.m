% Exemplos de teste

% newton_raphson_modificado(["x + y - 3"; "x^2 + y^2 - 9"],[1; 5],10^-4,10^-4)

% newton_raphson_modificado(["10*(y - x^2)"; "1 - x"],[-1.2; 1],10^-4,10^-4)

% newton_raphson_modificado(["x^3 + 2*(x^2)*y - 2*x*z + 3"; "-2*x*z + 3*(y^2) - 4"; "2*exp(x) + exp(y) - z"],[-1; -1; -1],10^-10,10^-10)

function newton_raphson_modificado (funcoes, X0, epsilon01, epsilon02)

    format long

    F = funcoes;

    plota_grafico(F);
    
    x = X0;

    tolerancia01 = epsilon01;

    tolerancia02 = epsilon02;

    solucao = 0;
    
    maximoIteracao = 10000;
    
    contador = 0;
    
    
    disp('Sistema Não Linear:');
    sistemaNaoLinear = str2sym(F);         % converte strings em expressoes simbolicas
    disp(sistemaNaoLinear);
    quantidadeEquacoes = length(sistemaNaoLinear);
    
    
    incognitas = symvar(sistemaNaoLinear); % Cria uma lista das incognitas do sistema nao linear
    
    n = length(incognitas);    % Determina a quantidade de variaveis do sistema
    
    disp('Variáveis do Sistema Não Linear:');
    
    disp(incognitas);
    
    jacobiano = sym(zeros(n)); % Inicializa a matriz jacobiano como sendo uma matriz de simbolos
    
    for i = 1:quantidadeEquacoes
        for j = 1:n
            jacobiano(i, j) = diff(sistemaNaoLinear(i), incognitas(j));
        end
    end
    
    disp('Jacobiano com as equações:');
    disp(jacobiano);

    % substituindo x na matriz jacobiana
        
    jacobianoSimbolico = subs(jacobiano, incognitas, x');
    
    % jx é o mesmo que F(x)
    
    jx = double(jacobianoSimbolico);
    
    disp('J(x):');
    disp(jx);
        
    for i = 1:maximoIteracao
    
        contador = contador + 1;
    
        fprintf('Iteração %d: \n\n', contador);
    
        disp('Chute:');
        disp(x);
    
        % Substitui os valores da transposta de x nas incognitas das equações do sistema nao linear (F)
        % Cria um sistema simbolico com os valores substituidos
        % OBS: nao eh possivel transpor incognitas
        
        sistemaSimbolico = subs(sistemaNaoLinear, incognitas, x');  % subs faz a substituicao
        
        % Converte o resultado simbólico para um vetor numérico (double)
        % O vetor fx é o valor numerico do sistema simbolico
        % fx é o mesmo que F(x)
        
        fx = double(sistemaSimbolico);
        
        disp('F(x):');
        disp(fx);

        if max(abs(fx)) < tolerancia01
            solucao = x;            
            break
        end        
        
        % Resolvendo o sistema J(x)*h = -F(x)
    
        h = -inv(jx)*fx;
    
        disp('h:');
        disp(h);
    
        xNew = x + h;

        disp('x_k+1 - x_k:');
        xNewMenosX = xNew - x;
        disp(xNewMenosX);

        maiorAbsoluto = max(abs(xNewMenosX));

        if maiorAbsoluto < tolerancia02
            solucao = xNew;
            break                        
        end
            
        x = xNew;  
    
    end

    disp('Solução do Sistema:');
    disp(solucao);
    
end