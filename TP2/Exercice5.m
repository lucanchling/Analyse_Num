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
%variables = {"r =",r,"\eta =",eta};
%% autres paramètres
tmin=0;     % instant initial
tmax=4*T0;  % instant final
pas=0.001;  % pas de calcul
fprintf('Durée de l''expérience physique : %1.2f\n',tmax-tmin);

%% fonctions Y'=F(Y) avec ici Y=(theta,z) et F(Y)=(f,g)
f=@(t ,theta ,z )( z );
g=@(t ,theta ,z )( -1*(gamma*z + omega*omega*sin(theta)) );

%% Résolution des EDs 
% conditions initiales
theta0=2*pi/3;  % angle initial (rad)
thetap0=0;      % vitesse angulaire initiale (rad/s)

% Résolution par différentes méthodes
methode = 'RK2'; % Choix de la méthode utilisée
switch methode
    case 'Euler'
        [theta,thetap,t] = Euler_2D(theta0,thetap0,tmin,tmax,pas,f,g);
        titre = "Résolution par méthode d'Euler";
    case 'RK2'
        beta = 0.5; % Paramètre pour la résolution par méthode RK2
        [theta,thetap,t] = RK2_2D(theta0,thetap0,tmin,tmax,pas,beta,f,g);
        titre = "Résolution par méthode de Runge-Kutta d'ordre 2";
    case 'RK4'
        [theta,thetap,t] = RK4_2D(theta0,thetap0,tmin,tmax,pas,f,g);
        titre = "Résolution par méthode de Runge-Kutta d'ordre 4";
end 

%% Calcul des différentes Energies
Ec = 0.5*m*l*l*thetap.^2;   % NRJ Cinétique
Ep = m*gr*l*(1 - cos(theta));   % NRJ Potentielle
E = Ec + Ep;    % NRJ Totale

%% Affichage
figure(1)
subplot(1,3,1)
plot(t,theta)
title('Oscillations du Pendule en fonction du temps')
xlabel('temps (en s)')
%legend('\theta(t)')
ylabel('\theta(t)')
set(get(gca,'ylabel'),'rotation',0)

subplot(1,3,2)
plot(theta,thetap, '.')
title('Phase')
xlabel('\theta(t)')
ylabel("\theta'(t)")
set(get(gca,'ylabel'),'rotation',0)

subplot(1,3,3)
hold on;
plot(t,Ec, '.m')
plot(t,Ep, '.c')
plot(t,E, '.r')
legend("Energie Cinetique","Energie potentielle", "Energie totale")
xlabel('temps (en s)')
title('Différentes Energies')

% Affichage des différentes variables
variables = {"r = "+num2str(r)+"m",
            "\eta = "+num2str(eta)+"kg.m^-1.s^-1",
            "\gamma = "+num2str(gamma)+"s^-1",
            "L = "+num2str(l)+"m",
            "m = "+num2str(m)+"kg",
            "pas = "+num2str(pas),
            "g = "+num2str(gr)+"m.s^-2"};
text(1.1*tmax,1.1*max(E),variables)

sgtitle(titre)