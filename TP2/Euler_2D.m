function [x,y,t]=Euler_2D(x0,y0,tmin,tmax,pas,F,G)
t=tmin:pas:tmax;
x=zeros(1,length(t));y=zeros(1,length(t));
x(1)=x0;y(1)=y0;
for k=1:length(t)-1
    x(k+1)= x(k) + pas*F(t(k),x(k),y(k));
    y(k+1)= y(k) + pas*G(t(k),x(k),y(k));
end
end