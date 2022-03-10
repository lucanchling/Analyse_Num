clear variables;
close all;
clc;

I = make_your_image();
figure()
subplot 131
imshow(I,[])
title('Image de Base')
I = I + 7*randn(size(I));
subplot 132
imshow(I,[])
title('Image bruitee')

% Equation de la chaleur
% Différents paramètres
h = 1; % Pas spatial (1 pixel)
tau = 0.2; % Pas temporel
Tmax = 2;
I1 = I(:,:);
for t = 0:tau:Tmax
    Iu = I1;
    for i = 2:length(I1)-1
        for j = 2:length(I1)-1
            Iu(i,j) = I1(i,j) + tau*((I1(i+h,j)-I1(i,j))+(I1(i-h,j)-I1(i,j))+(I1(i,j+h)-I1(i,j))+(I1(i,j-h)-I1(i,j)));
        end
    end
    I1 = Iu;
end

subplot 133
imshow(I1,[])
title('Image debruitee par equation de la chaleur')

% Peronna Malik
% Différents paramètres
h = 1; % Pas spatial (1 pixel)
tau = 0.2; % Pas temporel
Tmax = 2;
type = 'Lorentzienne';
alpha = 5;
I2 = I(:,:);
for t = 0:tau:Tmax
    IU = I2;
    for i = 2:length(I)-1
        for j = 2:length(I)-1
            switch type
            case 'Gaussienne'
                Dux = exp(-((I2(i,j)-I2(i-1,j))^2/(sqrt(2)*alpha)^2));
                Duy = exp(-((I2(i,j)-I2(i,j-1))^2/(sqrt(2)*alpha)^2));
            case 'Lorentzienne'
                Dux = (1/(1+((I2(i,j)-I2(i-1,j))^2/alpha^2)));
                Duy = (1/(1+((I2(i,j)-I2(i,j-1))^2/alpha^2)));
            end
            IU(i,j) = I2(i,j) + tau*(Dux*(I2(i+h,j)-I2(i,j))+Dux*(I2(i-h,j)-I2(i,j))+Duy*(I2(i,j+h)-I2(i,j))+Duy*(I2(i,j-h)-I2(i,j)));
        end
    end
    I2 = IU;
end

figure()
subplot 122
imshow(IU,[])
title('Image debruitee')
subplot 121
imshow(I,[])
title('Image bruitee')
% Gestion affichage a faire car cet exo srera à rendre --> tu verras Eliot
% jen suis sur