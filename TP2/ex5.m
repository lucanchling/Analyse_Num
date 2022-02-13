clear variables;
close all;
clc;

%% paramètres physiques
m=0.7;          % masse de la bille (kg)
r=0.035;        % rayon de la bille (m)
eta=0.000018;   % coeff. de viscosité de l'air à 20°C (kg.m^-1.s^-1)
gamma=1e-1;
%gamma=6*pi*r*eta/m; % frottements (s^-1)
gr=9.8;         % accéleration de la pesanteur (m.s^-2)
l=2;            % longueur du fil (m)
omega=sqrt(gr/l); % fréquence propre (rad.s^-1)
T0=2*pi/omega;  % (pseudo-)période du pendule (s)

%% autres paramètres
tmin=0;     % instant initial
tmax=4*T0;  % instant final
pas=0.001;  % pas de calcul
fprintf('Durée de l''expérience physique : %1.2f\n',tmax-tmin);

%% fonctions Y'=F(Y) avec ici Y=(theta,z) et F(Y)=(f,g)
f=@(t ,theta ,z )( z );
g=@(t ,theta ,z )( -1*(gamma*z + omega*omega*sin(theta)) );

%% conditions initiales
theta0=2*pi/3;  % angle initial (rad)
thetap0=0;      % vitesse angulaire initiale (rad/s)

[theta,thetap,t] = RK4_2D(theta0,thetap0,tmin,tmax,pas,f,g);

Ec = 0.5*m*l*l*thetap.^2;
Ep = m*gr*l*(1 - cos(theta));
E = Ec + Ep;

%% Affichage
figure(1)
subplot(1,3,1)
plot(t,theta)

subplot(1,3,2)
plot(theta,thetap, '.')

subplot(1,3,3)
hold on;
plot(t,Ec, '.m')
plot(t,Ep, '.c')
plot(t,E, '.r')
legend("Energie Cinetique","Energie potentielle", "Energie totale")





