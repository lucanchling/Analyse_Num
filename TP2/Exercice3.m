clear varaibles;
close all;
clc;

tmin=0;tmax=8;
f=@(t,y,a,b)(a);
g=@(t,y,a,b)(b);
i=@(t,y,a,b)(t*exp(-t^2)-(1/y));

h=.1;
t=tmin:h:tmax;
yEuler=zeros(1,length(t));aEuler=zeros(1,length(t));bEuler=zeros(1,length(t));
yEuler(1)=1;aEuler(1)=0;bEuler(1)=1;

for k=1:length(t)-1
    yEuler(k+1)= yEuler(k) + h*f(t(k),yEuler(k),aEuler(k),bEuler(k));
    aEuler(k+1)= aEuler(k) + h*g(t(k),yEuler(k),aEuler(k),bEuler(k));
    bEuler(k+1)= bEuler(k) + h*i(t(k),yEuler(k),aEuler(k),bEuler(k));
end
figure()
hold on;
plot(t,yEuler)
plot(t,aEuler)
plot(t,bEuler)
legend('y()',"y'()","y''()")