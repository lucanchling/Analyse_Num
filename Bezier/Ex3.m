clear variables;
close all;
clc;

t = linspace(0,1,1000);
T = [t.^0;t;t.^2;t.^3];

P = [1 2 3 4 5 6; 0 2 2.75 2.25 1 1.5];
    Q = [1 -3 3 -1
         4 0 -6 3
         1 3 3 -3
         0 0 0 1];
pos = [1 1 1 2
       1 1 2 3
       1 2 3 4
       2 3 4 5
       3 4 5 6
       4 5 6 6
       5 6 6 6];


 
figure()
for i = 1:7
    
    Pp = P(:,pos(i,:));
    M = (1/6)*Pp*Q*T;

    hold on;
    plot(M(1,:),M(2,:))
end
plot(P(1,:),P(2,:),'--')




