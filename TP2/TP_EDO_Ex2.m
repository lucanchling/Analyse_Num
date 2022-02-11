clear variables;
close all;
clc;

tmin=0;tmax=1;
f=@(t,y)((t^3*exp(-5*t))-(4*t^3+5)*y);
yExact=@(t)(0.25*(exp(t.^4)+3).*exp((-1)*t.*(t.^3+5)));
    
% condition initiale
y0=1;

%% question 1
% 1. méthode d'Euler (h=0.1)
h=0.1;
[yEuler1,t1]=fct_Euler(y0,tmin,tmax,h,f);
eps1=abs(yEuler1-yExact(t1));   % erreur
plot(t1,eps1);

% 2. méthode d'Euler (h=0.05)
h=0.05;
[yEuler2,t2]=fct_Euler(y0,tmin,tmax,h,f);
eps2=abs(yEuler2-yExact(t2));   % erreur

% 3. méthode RK2 (h=0.1 et beta=1)
h=0.1;beta=1;
[yRK,t3]=fct_RK2(y0,tmin,tmax,h,beta,f);
eps3=abs(yRK-yExact(t3));       % erreur

% Partie affichage

figure()
subplot 121
hold on;

subplot 122
hold on;

%% Question 2

maxerrEu = zeros(1,9);
maxerrRK = zeros(1,9);
h = .02:.01:.1;
for k = 1:length(h)
    
    [yEuler1,t1]=fct_Euler(y0,tmin,tmax,h(k),f);
    eps1=abs(yEuler1-yExact(t1));   % erreur
    maxerrEu(k)=max(eps1);
    [yRK,t3]=fct_RK2(y0,tmin,tmax,h(k),beta,f);
    eps3=abs(yRK-yExact(t3));       % erreur
    maxerrRK(k)=max(eps3);
end

figure()
subplot 121
plot(h,maxerrEu)
subplot 122
plot(h,maxerrRK)