clear variables
close all;
clc;

P = [-2 -1 2 4 2 -1 -2;1 3 4 2 0 -1 1];
t = linspace(0,1,1000);
T = [t.^0;t;t.^2;t.^3];

B = zeros(2,6);
C = zeros(2,6);
A = zeros(2,6);

Q = [1 -3 3 -1
     0 3 -6 3
     0 0 3 -3
     0 0 0 1];

for i = 1:length(P)-1;
    B(:,i) = (1/3)*(2*P(:,i)+P(:,i+1));
    C(:,i) = (1/3)*(P(:,i)+2*P(:,i+1));

end

for i = 1:length(C)-1
    A(:,i) = (1/2)*(C(:,i)+B(:,i+1));
end
A(:,6) = (1/2)*(C(:,length(C))+B(:,1));

for i = 1:6
    j=i+1;
    if j > length(A)
       j=1;
    end
    
    Pp = [A(:,i) B(:,j) C(:,j) A(:,j)];
    M = Pp*Q*T;
    figure(1)
    hold on;
    plot(M(1,:),M(2,:))
end


figure(1)
hold on;
plot(P(1,:),P(2,:),'--')
plot(B(1,:),B(2,:),'v')
plot(C(1,:),C(2,:),'^')
plot(A(1,:),A(2,:),'*')

axis([-3 8 -2 5])