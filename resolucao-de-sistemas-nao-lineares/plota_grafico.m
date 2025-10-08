% ATENÇÃO!!
% APENAS O CÓDIGO ABAIXO FOI CRIADO PELO GEMINI PARA ME AUXILIAR E DAR
% RAPIDEZ NOS CÓDIGOS REFERENTES AOS MODELOS DE CÁLCULO DE RAIZES

function plota_grafico(F)
    % F é o array de strings das equações implícitas (f(x,y) = 0)
    
    % 1. Configurar o Intervalo de Plotagem (Área de desenho)
    x_min = -10;
    x_max = 10;
    y_min = -10;
    y_max = 10;
    limites = [x_min x_max y_min y_max];
    
    % 2. Abrir uma nova figura
    figure;
    
    % 3. Define um array de cores/estilos
    cores = {'-b', '--r', ':g', '-.k', '-m', '--c', ':y'};
    
    % 4. Loop para plotar cada equação
    for i = 1:length(F)
        
        eq_str = F(i); 
        
        try
            eq_str_char = char(eq_str); 
            
            % --- SOLUÇÃO ROBUSTA PARA VETORIZAÇÃO ---
            
            % 1. Constrói a função simbólica
            f_sym = str2sym(eq_str_char);
            
            % 2. Garante que todos os operadores sejam vetorizados (.*, .^)
            f_vect = vectorize(f_sym);
            
            % 3. Constrói a string do handle de função (@(x,y) ...)
            % Convertendo a expressão simbólica vetorizada de volta para string
            handle_str = ['@(x,y) (' char(f_vect) ')'];
            
            % 4. Avalia para criar o handle da função anônima
            f = eval(handle_str); 
            
        catch
            warning('Erro ao converter a equação "%s". Pulando para a próxima.', eq_str);
            continue; 
        end
        
        estilo = cores{mod(i-1, length(cores)) + 1};
        fimplicit(f, limites, estilo, 'LineWidth', 2, 'DisplayName', eq_str);
        
        if i == 1
            hold on; 
        end
    end
    
    % 5. Configurações Finais do Gráfico (Com Graduação de 1)
    
    % Define os limites de visualização (mantendo o intervalo completo de -5 a 5)
    xlim([x_min, x_max]);
    ylim([y_min, y_max]);
    
    % Define as marcações (ticks) de 1 em 1
    xticks(x_min:1:x_max); 
    yticks(y_min:1:y_max);
    
    grid on;
    axis equal; 
    
    title('Gráfico do Sistema de Equações');
    xlabel('Eixo X');
    ylabel('Eixo Y');
    legend('show', 'Location', 'best');
    hold off;
end