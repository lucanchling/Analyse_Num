%% exo 1
clear variables;
close all;
clc;

A = [2,3;1,3];
%Différentes normes de A
inverse = inv(A);

norm1A = norm(A,1);

norm2A = norm(A,2);
%Différentes normes de l'inverse de A
norminfA = norm(A,inf);

norm1Ainv = norm(inverse,1);

norm2Ainv = norm(inverse,2);

norminfAinv = norm(inverse,inf);

%Calcul des différents conditionnements pour chaque norme
%On remarque que K1=Kinf alors que K2 est inférieur au 2 autres

K1 = norm1A * norminfA;

K2 = norm2A * norm2Ainv;

Kinf = norminfAinv * norminfA;

%% Exo 2
clear variables;
close all;
clc;

A = [8 10 10 10;1 5 6 1;7 10 4 7;7 8 1 7];
b = [38;13;28;23];

% Question 1
x = A\b;

% Question 2
db = [.1;-.1;.1;-.1];

x1 = A\(b+db); % On ajoute une variation Db

% Question 3
M1 = norm(db)/norm(b);
dx = x1-x;
M2 = norm(dx)/norm(x);

sigma = svd(A);

% Question 4
K2 = max(sigma)/min(sigma);
cond = cond(A);

% Question 5
Test = M2 <= M1*K2; % renvoi 1 --> c'est good

% Question 6
eps = 5*10^(-4);
dA = [eps 0 0 eps;0 eps 0 eps;0 eps eps 0;eps 0 0 eps];

% a)
x2 = (A+dA)\b;

% b)
NdA = norm(dA);
Ndx = norm(x2-x);

Test2 = (Ndx/norm(x+dx))<= K2 * (NdA/norm(A)); % True --> OK

%% Exo 3
clear variables;
close all;
clc;

% Question 1
n = 10;
A = zeros(n,n);
% On construit notre matrice hilbertienne grâce à une double boucle for
% sur les lignes et les colonnes. 
for i = 1:n
    for j = 1:n
        A(i,j) = (1/(i+j-1));
    end
end

condu = cond(A);

proddet = det(A)*det(inv(A));

% Question 2
Cond = zeros(1,9);
ProdDet = zeros(1,9);

for n = 4:12
    for i = 1:n
        for j = 1:n
            A(i,j) = (1/(i+j-1));
        end
    end
    
    Cond(n-3) = cond(A); % Il faut bien faire attention à ne pas nommer Cond partout avant

    ProdDet(n-3) = det(A)*det(inv(A));
end

% Question 3
A = [1 1/2 1/3 1/4 1/5; 1/2 1/3 1/4 1/5 1/6; 1/3 1/4 1/5 1/6 1/7;1/4 1/5 1/6 1/7 1/8;1/5 1/6 1/7 1/8 1/9];
b = [137/60; 29/20; 153/140; 743/840; 1879/2520];
% a)
[U,S,V] = svd(A);
% b)
x = A\b;
% c)
db = 1/1000*[0 1 0 1 0]';
xb = A\(b+db);

% d)
lambda = 0.001;
% première méthode (8)
xtik1 = inv((A'*A+ lambda*eye(5)))*A'*b; % on applique la formule 

% seconde méthode
r = rank(A);
V1 = V(1:r,1:r);
U1 = U(1:r,1:r);
D1inv = S/((S.*S)+lambda*eye(r)); % On décide d'écrire directictement D1 Inv au lieu d'écrire toute la somme
%pour simplifier le code sachant que Matlab préfère les matrices
xtik2 = V1*D1inv*U1'*b;

% On obtient bien les 2 mêmes résultat pour xtik 1 et 2 ce qui est logique
% puisque la 2e  découle de la première 