%format long 

DadosPontos;

[numLinhas, ~] = size(pontos);

pontosRadianos = zeros(numLinhas,2);

for i=1:numLinhas
    for j=1:2
        pontosRadianos(i,j) = deg2rad(pontos(i,j));
    end
end

pontosInterpolacao = zeros(numLinhas,2);

pontosInterpolacao(:,2) = pontos(:,3);

distanciaAcumulada = 0;

raioTerra = 6371000; % em metros

for i=2:numLinhas
    
    phi_1 = pontosRadianos(i - 1,1);
    phi_2 = pontosRadianos(i,1);
    delta_phi = phi_2 - phi_1;
    delta_lambda = pontosRadianos(i,2) - pontosRadianos(i - 1,2);

    a = ((sin(delta_phi/2))^2) + ((cos(phi_1))*(cos(phi_2))*((sin(delta_lambda/2))^2));

    c = 2*asin(sqrt(a));

    d2p = raioTerra*c; % distância em metros entre 2 pontos na superfíce da Terra

    distanciaAcumulada = distanciaAcumulada + d2p;

    pontosInterpolacao(i,1) = distanciaAcumulada;

end


%fprintf('Pontos Finais para Interpolação: %d',pontosInterpolacao);