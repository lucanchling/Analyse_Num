clear variables;
close all;

% param�tres physiques
m=0.7; % masse de la bille (kg)
r=0.035; % rayon de la bille (m)
eta=0.000018; % coeff. de viscosit� de l'air � 20�C (kg.m^-1.s^-1)
gamma=6*pi*r*eta/m; % frottements (s^-1)
gr=9.8; % acc�leration de la pesanteur (m.s^-2)
l=2; % longueur du fil (m)
omega=sqrt(gr/l); % fr�quence propre (rad.s^-1)
T0=2*pi/omega; % (pseudo-)p�riode du pendule (s)
% autres param�tres
tmin=0; % instant initial
tmax=4*T0; % instant final
pas=0.001; % pas de calcul
fprintf('Dur�e de l''exp�rience physique : %1.2f\n',tmax-tmin);
% fonctions Y'=F(Y) avec ici Y=(theta,z) et F(Y)=(f,g)
f=@(___,_____,__)(_______________________);
g=@(___,_____,__)(_______________________);
% conditions initiales
theta0=2*pi/3; % angle initial (rad)
thetap0=0; % vitesse angulaire initiale (rad/s)
