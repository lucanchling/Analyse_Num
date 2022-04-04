clear variables;
close all;
clc;

t = linspace(0,1,1000);
T = [t.^0;t;t.^2;t.^3];

P = [0 1/3 2/3 1;0 1 -1 0];

Q = [1 -3  3 -1
      0  3 -6  3
      0  0  3 -3
      0  0  0  1];

M = P*Q*T;


figure()
hold on;
plot(M(1,:),M(2,:))
plot(P(1,:),P(2,:))

x = linspace(1,2,1000);
plot(x,-(6*(2-x).^3-9*(2-x).^2+3*(2-x)))
