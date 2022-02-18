clear variables;
close all;
clc;

I = im2double(imread('ballon.tif'));
[h w c] = size(I);
n = h*w;
I1 = I(:,:,1); I2 = I(:,:,2);I3 = I(:,:,3);
I1 = I1(:); I2 = I2(:); I3=I3(:);

Y = [I1,I2,I3];

X = Y - mean(Y);

% Matrice de covariance
M = 1/n*(X')*X;

% DIagonalisation de la matrice
[P,D] = eig(M);
lambda = sort(diag(D),'descend');
% Parce que ca ne marche pas obligé de faire ca :(
P = [ P(:,1),P(:,3),P(:,2)];

% Affichage valeurs propres
figure()
plot((1:size(lambda)),lambda)
title('Valeurs Propres')

% Inertie
tau = 1/sum(lambda)*lambda;
tau1=tau(1);
% Matrice des composantes principales
Xstar = X*P;

% Nuage de points projetés

% first = input("premier axe : ");
% second = input("second axe : ");
% figure()
% plot(Xstar(:,first),Xstar(:,second),'o')
% title("Nuage de points projetés (e_"+num2str(first)+",e_"+num2str(second)+")")
% grid('on')


% Reconstruction Irec
Irec = reshape(I,[size()])