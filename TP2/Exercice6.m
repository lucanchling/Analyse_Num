clear variables;
close all;
clc;

% Différentes constantes
G = 4*pi^2; % Constante de gravitation universelle
%a = 1.5e11;  % demi grand axe
a=1;
%T = 365*3600;   % période de révolution (en seconde)
T=1;
%M = 1.98892e30; % Masse du soleil
M=1;
% COnditions initiales
x0=.5;
x0p=0;
y0=0;
y0p=11.5;

tmin=0;
tmax=4*T;

% Différentes fonctions   avec xp = z  &  yp = w
f1=@(x,y,z,w)(z);
f2=@(x,y,z,w)(w);
g1=@(x,y,z,w)(-1*(G*M*(x./(x.^2+y.^2).^(3/2))));
g2=@(x,y,z,w)(-1*(G*M*(y./(x.^2+y.^2).^(3/2))));

% Paramètre de résolution
h = .01;
t = tmin:h:tmax;
% Résolution par méthode d'EULER
xEuler = zeros(1,length(t));yEuler=zeros(1,length(t));xpEuler = zeros(1,length(t));ypEuler = zeros(1,length(t));
xEuler(1)=x0;yEuler(1)=y0;xpEuler(1)=x0p;ypEuler(1)=y0p;

for k=1:length(t)-1
   xEuler(k+1) = xEuler(k) + h*f1(xEuler(k),yEuler(k),xpEuler(k),ypEuler(k));
   yEuler(k+1) = yEuler(k) + h*f2(xEuler(k),yEuler(k),xpEuler(k),ypEuler(k));
   xpEuler(k+1) = xpEuler(k) + h*g1(xEuler(k),yEuler(k),xpEuler(k),ypEuler(k));
   ypEuler(k+1) = ypEuler(k) + h*g2(xEuler(k),yEuler(k),xpEuler(k),ypEuler(k));
end


% affichage de la méthode d'Euler
figure()
hold on;
plot(xEuler,yEuler);
grid('on')
plot(0,0,'*')
title('euler')
% hold on;
% for i = 1:length(xEuler)
%     h = plot(xEuler(i),yEuler(i),'or');
%     pause(0.05)
%     delete(h)
% end

%Résolution par méthode de Runge-Kutta
axis('equal')
[xRK,yRK,t]=RK4_2D_bis(x0,y0,x0p,y0p,tmin,tmax,h,f1,f2,g1,g2);
plot(xRK,yRK,'r')
grid('on')
plot(0,0,'*')

% Méthode de Euler-Richardson
[xER,yER,pas]=Euler_Richardson(x0,y0,x0p,y0p,tmin,tmax,h,f1,f2,g1,g2);
plot(xER,yER,'b')

% for i = 1:length(xEuler)
%     h1 = plot(xRK(i),yRK(i),'or');
%     h2 = plot(xEuler(i),yEuler(i),'ob');
%     h3 = plot(xER(i),yER(i),'ok');
%     pause(0.05)
%     delete(h1)
%     delete(h2)
%     delete(h3)
% end
