clear variables;
close all;
clc;

I = im2double(imread('ballon.tif'));    % Conversion de l'image en matrice de doubles
[h w c] = size(I);  % Recuperation des informations de taille de l'image
n = h*w;    % Calcul de la taille de l'image 'vectorisee'
I1 = I(:,:,1); I2 = I(:,:,2);I3 = I(:,:,3); % Recuperation des 3 cannaux de l'image (R,G,B)
I1 = I1(:); I2 = I2(:); I3=I3(:);   % Vectorisation  des differentes images pour construction de la matrice Y

Y = [I1,I2,I3]; % Construction de la matrice Y necessaire à l'ACP
% -------------
% Partie ACP :
% -------------

X = Y - mean(Y);    % Matrice centree

% Matrice de covariance
M = 1/n*(X')*X;

% Diagonalisation de la matrice
[P,D] = eig(M);
lambda = sort(diag(D),'descend');   % Tri des valeurs propres dans le sens decroissant
P = [ P(:,1),P(:,3),P(:,2)];    % Changement de la matrice P (probleme tri valeur propres --> reajustement necessaire)

% Affichage valeurs propres
figure()
hold on;
plot((1:size(lambda)),lambda)
for i = 1:length(lambda)
    text(i,lambda(i),num2str(lambda(i)))
end
title('Valeurs Propres')

% Inertie
tau = 1/sum(lambda)*lambda;
tau1=tau(1);

figure()
pie(tau,{"Composante Principale 1 ("+num2str(tau(1))+")","CP 2 ("+num2str(tau(2))+")","CP 3 ("+num2str(tau(3))+")"})

% Matrice des composantes principales
Xstar = X*P;

% Nuage de points projetes

% first = input("premier axe : ");
% second = input("second axe : ");
% figure()
% plot(Xstar(:,first),Xstar(:,second),'o')
% title("Nuage de points projetes (e_"+num2str(first)+",e_"+num2str(second)+")")
% grid('on')


% Reconstruction Irec
Xstar1 = [Xstar(:,1),zeros(n,1),zeros(n,1)];    % Matrice avec seulement la premiere colonne de pleine
Xrec = Xstar1 * inv(P); % Calcul de la reconstruction
Irec = reshape(mean(Xrec,2),[h,w]);   % Pour obtenir le bon formatage de l'image niveau dimension en prenant la moyenne des 3 colonnes

figure()
subplot 121
imshow(rgb2gray(I),[])
subplot 122
imshow(Irec,[])
sgtitle('Par rapport à la 1ere composante principale')


figure()
subplot 221
imshow(rgb2gray(I),[])
subplot 222
imshow(Irec,[])
title('1ere composante principale')
subplot 223
imshow(reshape(mean([zeros(n,1),Xstar(:,2),zeros(n,1)]* inv(P),2),[h,w]),[])
title('2nde composante principale')
subplot 224
imshow(reshape(mean([zeros(n,1),zeros(n,1),Xstar(:,3)]* inv(P),2),[h,w]),[])
title('3eme composante principale')

%% Reconstruction image à partir de 6 images satellitaires
clear variables;
close all;
clc;

% Affichage des 6 images
i1 = im2double(imread('i1.tif'));
i2 = im2double(imread('i2.tif'));
i3 = im2double(imread('i3.tif'));
i4 = im2double(imread('i4.tif'));
i5 = im2double(imread('i5.tif'));
i6 = im2double(imread('i6.tif'));

[h w c] = size(i1);
n = h*w;
figure()
subplot 231
imshow(i1,[])
subplot 232
imshow(i2,[])
subplot 233
imshow(i3,[])
subplot 234
imshow(i4,[])
subplot 235
imshow(i5,[])
subplot 236
imshow(i6,[])

sgtitle('Affichage des 6 images satellitaires')

i1 = i1(:); i2 = i2(:); i3 = i3(:); i4 = i4(:); i5 = i5(:); i6 = i6(:);

Y = [i1,i2,i3,i4,i5,i6];

X = Y - mean(Y);

% Matrice de covariance
M = 1/n*(X')*X;

% DIagonalisation de la matrice
[P,D] = eig(M);
lambda = sort(diag(D),'descend');
% Pour les mettre dans un sens decroissant
P = [ P(:,1),P(:,2),P(:,3),P(:,4),P(:,6),P(:,5)];

% Affichage valeurs propres
figure()
hold on;
plot((1:size(lambda)),lambda)
for i = 1:length(lambda)
    text(i,lambda(i),num2str(lambda(i)))
end
title('Valeurs Propres')

% Inertie
tau = 1/sum(lambda)*lambda;
tau1=tau(1);
% Matrice des composantes principales
Xstar = X*P;

% Nuage de points projetes

% first = input("premier axe : ");
% second = input("second axe : ");
% figure()
% plot(Xstar(:,first),Xstar(:,second),'o')
% title("Nuage de points projetes (e_"+num2str(first)+",e_"+num2str(second)+")")
% grid('on')

% Affichage pie chart
figure()
pie(tau,{"Composante Principale 1 ("+num2str(tau(1))+")","CP 2 ("+num2str(tau(2))+")","CP 3 ("+num2str(tau(3))+")","CP 4",'CP 5','CP 6'})
% Reconstruction Irec
Xstar1 = [Xstar(:,1),zeros(n,1),zeros(n,1),zeros(n,1),zeros(n,1),zeros(n,1)];    % Matrice avec seulement la premiere colonne de pleine
Xrec = Xstar1 * inv(P); % Calcul de la reconstruction
Irec = reshape(mean(Xrec,2),[h,w]);   % Pour obtenir le bon formatage de l'image niveau dimension en prenant la moyenne des 3 colonnes


figure()
subplot 231
imshow(Irec,[])
title('Par rapport à la 1ere composante principale')
subplot 232
imshow(reshape(mean([zeros(n,1),Xstar(:,2),zeros(n,1),zeros(n,1),zeros(n,1),zeros(n,1)]*inv(P),2),[h,w]),[])
title('Par rapport à la 2nde composante principale')
subplot 233
imshow(reshape(mean([zeros(n,1),zeros(n,1),Xstar(:,3),zeros(n,1),zeros(n,1),zeros(n,1)]*inv(P),2),[h,w]),[])
title('Par rapport à la 3eme composante principale')
subplot 234
imshow(reshape(mean([zeros(n,1),zeros(n,1),zeros(n,1),Xstar(:,4),zeros(n,1),zeros(n,1)]*inv(P),2),[h,w]),[])
title('Par rapport à la 4eme composante principale')
subplot 235
imshow(reshape(mean([zeros(n,1),zeros(n,1),zeros(n,1),zeros(n,1),Xstar(:,5),zeros(n,1)]*inv(P),2),[h,w]),[])
title('Par rapport à la 5eme composante principale')
subplot 236
imshow(reshape(mean([zeros(n,1),zeros(n,1),zeros(n,1),zeros(n,1),zeros(n,1),Xstar(:,3)]*inv(P),2),[h,w]),[])
title('Par rapport à la 6eme composante principale')
sgtitle('Reconstruction à partir des composantes principales')

figure()
imshow(Irec,[])
title('Par rapport à la 1ere composante principale')