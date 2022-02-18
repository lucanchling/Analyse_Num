clear variables;
close all;
clc;

Y = [2 -1 1; -1 1 -1; 3 1 0; -2 -4 1; -2 3 -1];
figure()
subplot 221
plot3(Y(:,1),Y(:,2),Y(:,3),'*')
title('Affichage Nuage de Points')
grid('on')

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
subplot 222
plot((1:size(lambda)),lambda)
title('Valeurs Propres')

% Inertie
tau = 1/sum(lambda)*lambda;

% Matrice des composantes principales
Xstar = X*P;

% Nuage de points projetés
subplot 223
plot(Xstar(:,1),Xstar(:,2),'o')
grid('on')

a = P(1,3);
b = P(2,3);
c= P(3,3);

% Affichage du plan 
subplot 221
hold on;
[X,Y] = meshgrid(X,Y);
Z = -(a*X+b*Y)/c;
mesh(X,Y,Z);

