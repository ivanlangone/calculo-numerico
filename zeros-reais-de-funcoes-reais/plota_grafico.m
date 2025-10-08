function plota_grafico(f)
% PLOTA_GRAFICO Plota uma função f(x) em um intervalo fixo.
%
% INPUT:
%   f        - Function handle da função a ser plotada (deve ser vetorizada, ex: @(x) 1./x)

    % --- CONFIGURAÇÃO DOS LIMITES DE PLOTAGEM ---
    % Limites fixos para visualização ampla
    x_plot_min = -10; 
    x_plot_max = 10;
    y_limite = 10; 
    
    figure;

    % 1. Plota a função na faixa mais ampla 
    fplot(f, [x_plot_min, x_plot_max], 'LineWidth', 2, 'DisplayName', 'f(x)');
    hold on; 

    % 2. Plota a linha de referência do Eixo X em y=0
    plot([x_plot_min, x_plot_max], [0 0], 'k--', 'HandleVisibility', 'off'); 
    
    % O intervalo de busca [A, B] e a raiz final não podem ser marcados 
    % porque A, B e x_final não são fornecidos como entrada.

    % 3. CORREÇÃO DE LIMITES E GRADUAÇÃO
    % Limita o Eixo X na faixa de visualização e define a graduação de 1 em 1
    xlim([x_plot_min, x_plot_max]);
    xticks(x_plot_min:1:x_plot_max);

    % Limita o Eixo Y para evitar assíntotas e define a graduação de 1 em 1
    ylim([-y_limite, y_limite]); 
    yticks(-y_limite:1:y_limite);

    % Configurações do Gráfico
    grid on;
    title('Gráfico da Função');
    xlabel('Eixo X');
    ylabel('f(x)');
    legend('show', 'Location', 'best');
    hold off;
end