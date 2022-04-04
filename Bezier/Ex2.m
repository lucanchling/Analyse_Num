clear variables;
close all;
clc;

t = linspace(0,1,1000);
T = [t.^0;t;t.^2;t.^3];
figure()
for a = [-3,-2,-1,0,1]

    P = [0 0 a -1;1 0 0 1];

    Q = [1 -3  3 -1
          0  3 -6  3
          0  0  3 -3
          0  0  0  1];

    M = P*Q*T;

    hold on;
    plot(M(1,:),M(2,:))
end




