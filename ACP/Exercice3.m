close all;
clear variables;
clc;

parametre = input('Choisissez vos parametres :');
switch parametre %On fait différents cas pour pouvoir changer les paramètres demandés
    case 1
        phi=0;
        epsilon=1;
        titre='Pour Epsilon = 1 et phi = 0'; 

    case 2
        phi=pi/2;
        epsilon=1;
        titre='Pour Epsilon = 1 et phi = pi/2';
        
    case 3
        phi=pi;
        epsilon=1;
        titre='Pour Epsilon = 1 et phi = pi';
    case 4
        phi=0;
        epsilon=-1;
        titre='Pour Epsilon = -1 et phi = 0';
    case 5
        phi=pi/2;
        epsilon=-1;
        titre='Pour Epsilon = -1 et phi = pi/2';
        
    case 6
        phi=pi;
        epsilon=-1;
        titre='Pour Epsilon = -1 et phi = pi';
end 
    

%Construction des signaux 
        
t=linspace(0,2*pi,100);
sin1=sin(t);
sin2=epsilon*sin(t+phi);

delta1=0.2.*rand(size(sin1));
delta2=0.2.*rand(size(sin2));


s1= sin1 + delta1;
s2= sin2 + delta2;


figure(1)
subplot(1,2,1)
plot(t,s1,'r',t,s2,'b')
grid on
title({'Signaux s1 et s2', titre})
xlabel('t')
subplot(1,2,2)
plot(s1,s2,'o')
title({'Nuage de Points', titre})
xlabel('s1')
ylabel('s2')
grid on

%On construit la matrice Y d'étude grâce aux données des 2 signaux 
%Puis on applique la méthode du cours: Matrice centrée, Matrice M de
%covariance puis de diagonalisation
Y=[s1',s2'];
[n,m] = size(Y);
X=Y- ones(n,1) * mean(Y);
[n,m]=size(X);
M=(1/n)*X'*X;
[V,D]=eig(M);

% On trie nos valeurs propres en ordre décroissant
[lambda,indices]= sort(diag(D),'descend');
P= V(:,indices);% On retrie nos vecteurs propres associés aux valeurs propres qui ont pu être déplacées
Xstar=X*P;

tau=1/sum(lambda)*lambda;% taux d'inertie

%Affichage ACP
figure(2)
plot(Xstar(:,1),Xstar(:,2),'*')
axis equal
title({'Analyse en Composantes Principales', titre})
xlabel(['e1(' , num2str(100*tau(1)),'%)'])
ylabel(['e2( ' , num2str(100*tau(2)),'%)'])
grid on

%Calcul du cercle des corrélations
sigma=ones(n,1)*std(X); % Matrice centrée réduite
z=X./sigma;

figure(3)
hold on
theta=0:0.01:2*pi;
plot(cos(theta),sin(theta),'k') % Affichage du cercle unité 
axis equal;
title({'Cercle de Corrélation' , titre});
xlabel(['e1(' , num2str(100*tau(1)),'%)'])
ylabel(['e2( ' , num2str(100*tau(2)),'%)'])
grid on
for j=1:m
    rho1=(z(:,j)'*Xstar(:,1))./(n*sqrt(lambda(1)));
    rho2=(z(:,j)'*Xstar(:,2))./(n*sqrt(lambda(2)));
    plot(rho1,rho2,'o')  
end



Xrec=Xstar*inv(P);
figure(4)
subplot(1,2,1)
plot(t,s1,t,Xrec(:,1),'--')
title({'Reconstruction du signal s1',titre})
legend('Signal Original','Signal Reconstruit')
xlabel('t')
grid on
subplot(1,2,2)
plot(t,s2,t,Xrec(:,2),'--')
title({'Reconstruction du signal s2', titre})
legend('Signal Original','Signal Reconstruit')
xlabel('t')
grid on

%% chargement des signaux
load Ex3_signaux;
Y=D;
[n,m]=size(Y); % n=768 abscisses, m=20 signaux
% affichage des 20 signaux
figure(5);
for i=1:m
subplot(m,1,i);
title('Signaux originaux','interpreter','latex');
plot(Y(:,i));
axis off;
end


X = Y - mean(Y);
[n,m]=size(X);
M=(1/n)*X'*X;
[P,D]=eig(M);
lambda= sort(diag(D),'descend');
 tau=1/sum(lambda)*lambda;
tau_cumu=zeros(1,m);
for k=1:m
    tau_cumu(k)=sum(tau(1:k));
end
    
figure(6)
subplot(1,2,1)
plot(lambda,'*')
title('Valeurs Propres decroissantes')
xlabel('Nombre de Signaux')
grid on
subplot(1,2,2)
plot(tau_cumu,'*')
title('Taux d intertie cumulé')
xlabel('Nombre de Signaux')
grid on

