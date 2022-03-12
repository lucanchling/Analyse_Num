clear variables;
close all;
clc;


% espace
Lx=15;hx=0.1;x=0:hx:Lx;nx=length(x);
Ly=15;hy=0.1;y=0:hy:Ly;ny=length(y);
% temps
T=input("Temps d'execution (en s) = ");tau=0.002;t=0:tau:T;m=length(t);
% celerité de l'onde
c=7;
% coefficients rx et ry
rx=(c*tau/hx)^2;
ry=(c*tau/hy)^2;
% conditions CFL (non explicitement utilisées, juste pour vérification)
CFL_x=hx/(c*tau);
CFL_y=hy/(c*tau);

% fréquence de la source
nu=8;
% condition initiale (le milieu est au repos à l'instant initial)
f=zeros(nx,ny,m);
clc;
fprintf("Choix du style d'obstacle:\nMode 0 --> Aucun\nMode 1 --> Fentes\nMode 2 --> Autres\n")
style = input("Mode : ");
clc;
switch style
    case 0  % premier cas (sans rien)
    case 1  % Pour des fentes
    % Choix au niveau des fentes
    fprintf("Choix concernant le mode des fentes utilise :\nMode 1 --> Avec 1 Fente\nMode 2 --> Avec 2 fentes\n")

    fente = input("Mode : ") ;  % Choix du nombre de fentes
    switch fente
        
        case 1  % cas avec 1 fente
            i_slit = [floor(nx/2),floor(nx/2)+1];
            j_slit = [1:floor(ny/2)-3,floor(ny/2)+2:ny];
        case 2 % cas 2 fentes
            i_slit = [floor(nx/2),floor(nx/2)+1];
            j_slit = [1:floor(ny/4)-3,floor(ny/4)+2:floor(3*ny/4)-3,floor(3*ny/4)+2:ny];      
    end
    
    case 2  % pour d'autres types d'obtacles
        
    % Choix au niveau des obstacles
    fprintf("Choix concernant le mode des obstacles utilise : \nMode 1 --> Un Mur\nMode 2 --> Un Carrée\n")
    obstacle=input("Mode : ");
    switch obstacle
        case 1  % Un mur simple
            i_slit = [floor(nx/6),floor(nx/6)+1];
            j_slit = (1:ny);
        case 2  % Un carré
            i_slit = [floor(nx/3):floor(nx/3)+35];
            j_slit = [floor(ny/4):floor(ny/4)+35];
    end
end

clc;
% Choix au niveau des sources
fprintf("Choix concernant le mode des sources utilisé : \nMode 1 --> Source fixe\nMode 2 --> 2 sources fixes\nMode 3 --> 1 source qui se téléporte\nMode 4 --> 1 source qui se déplace suivant 1 axe\n")
source = input("Mode : ");
% Temps d'arrêt pour la source 
T_stop = input("Temps d'arret de la/des source(s) (=0 si aucun et < "+num2str(T)+"s) = ");
if (T_stop == 0)
    T_stop = T;
end
switch source
    case 1  % 1 source fixe
        % indices correspondant à la position de la source
        i_s=floor(nx/3);
        j_s=floor(ny/2);
    case 2  % 2 sources fixes
        % indices correspondant à la position de la source
        i_s=[floor(nx/6),floor(nx/2)];
        j_s=floor(ny/2);
    case 3  % source qui BOUGE en se téléportant
        i_s=ones(1,length(t));j_s=ones(1,length(t));
        nb_pos = 5; % Nombre de positions différentes
        % différentes localités des sources
        pos_x = [floor(nx/2),floor(nx/3),floor(nx/6),floor(nx/2+0.5),floor(nx-0.4)];  % en x
        pos_y = [floor(ny/4),floor(ny/2),floor(ny/5),floor(ny/3+0.7),floor(ny/5-0.2)];  % en y
        
        % automatisation par rapport au nombre de positions données du remplissage de la matrice des position de la source
        for pos = 1:nb_pos
            for k = floor((pos-1)*(length(t)/nb_pos))+1:floor(pos*length(t)/nb_pos)  
                i_s(k)=pos_x(pos);
                j_s(k)=pos_y(pos);
            end
        end
    case 4  % Source qui BOUGE de manière smOOOOOOOOth
        i_s=ones(1,length(t));j_s=floor(ny/2)*ones(1,length(t));
        dx=-1;
        for k = 2:length(t)
            if i_s(k-1)==nx
                dx = -1;
            elseif i_s(k-1)==1
                dx = 1;
            end
            i_s(k)=i_s(k-1)+dx;
        end
end


% Partie Calcul
for k=2:m-2
    for i=2:nx-1
        for j=2:ny-1
            f(i,j,k+1) = 2*f(i,j,k) - f(i,j,k-1) + rx*(f(i+1,j,k)-2*f(i,j,k)+f(i-1,j,k)) + ry*(f(i,j+1,k)-2*f(i,j,k)+f(i,j-1,k));
        end
    end
    if (length(i_s) ~= length(t))    % Source fixe
        if t(k)<T_stop % Source active
            f(i_s,j_s,k+1) = f(i_s,j_s,k+1) + tau^2*sin(2*pi*nu*k*tau);
        else    % Source arrêtée
            f(i_s,j_s,k+1) = 0;
        end
    else    % Source mouvante
        if t(k)<T_stop % Source active
            f(i_s(k),j_s(k),k+1) = f(i_s(k),j_s(k),k+1) + tau^2*sin(2*pi*nu*k*tau);
        else    % Source arrêtée
            f(i_s(k),j_s(k),k+1) = 0;
        end        
    end
    if (exist('i_slit','var'))  % Conditions pour savoir si la var i_slit existe (i.e. si il y a ou non des fentes)
        f(i_slit,j_slit,k+1)=0;
    end
end

% partie affichage
figure(1);
f=f/max(max(max(f)));
[X,Y]=meshgrid(y,x);
for k=1:m-1
surf(X,Y,f(:,:,k));
xlabel('$y$','interpreter','latex');
ylabel('$x$','interpreter','latex');
zlb=zlabel('$f(x,y,t)$','interpreter','latex');zlb.Rotation=0;
view(-30,50);
caxis([-1,1]); % échelle des couleurs
zlim([-1,1]);
pause(0.001);
end