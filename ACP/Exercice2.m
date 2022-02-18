clear variables;
close all;
clc;

Ex2_data;

Y = data;

[n,m] = size(Y);

% Données Centrées
X = Y - mean(Y);

% Matrice de covariance
M = 1/n*X'*X;

% DIagonalisation de la matrice
[P,D] = eig(M);
lambda = diag(flip(flip(D)'));
P = flip(P')';

% Affichage valeurs propres
subplot 221
plot((1:size(lambda)),lambda)
title('Valeurs Propres')
xlabel('k')
ylabel('\lambda_k')
% Inertie
tau = 1/sum(lambda)*lambda;
subplot 222
plot((1:size(lambda)),tau)
title('Taux d''inertie pour chaque \lambda')
xlabel('vecteur k')
% Matrice des composantes principales
Xstar = X*P;

% Nuage de points projetés
subplot 223
plot(Xstar(:,1),Xstar(:,2),'o')
grid('on')
title('projection sur (e_1,e_2)')

% Nuage de points projetés
subplot 224
plot(Xstar(:,2),Xstar(:,7),'o')
grid('on')
title('projection sur (e_2,e_7)')

% Cercle de corélation
S = std(Y);
Z = X./S;

figure()
hold on;
r=1;
t = linspace(0,2*pi,1000);
x = r*sin(t);
y = r*cos(t);
Rho1 = (Z')*Xstar(:,1)/(n*sqrt(lambda));
Rho2 = (Z')*Xstar(:,2)/(n*sqrt(lambda));

plot(x,y)
plot(Rho1,Rho2,'x')
axis('equal')