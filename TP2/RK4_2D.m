function [x,y,t]=RK4_2D(x0,y0,tmin,tmax,pas,F,G)
    t = tmin:pas:tmax;
    x = zeros(size(t));
    y = zeros(size(t));
    x(1) = x0;
    y(1) = y0;
    for k=1: (tmax-tmin)/pas
        k1x = F(t(k),x(k),y(k));
        k1y = G(t(k),x(k),y(k));
        k2x = F(t(k) + pas/2, x(k) + k1x*pas/2, y(k) + k1y*pas/2 );
        k2y = G(t(k) + pas/2, x(k) + k1x*pas/2, y(k) + k1y*pas/2 );
        k3x = F(t(k) + pas/2, x(k) + k2x*pas/2, y(k) + k2y*pas/2 );
        k3y = G(t(k) + pas/2, x(k) + k2x*pas/2, y(k) + k2y*pas/2 );
        k4x = F(t(k) + pas, x(k) + k3x*pas, y(k) + k3y*pas );
        k4y = G(t(k) + pas, x(k) + k3x*pas, y(k) + k3y*pas );
        x(k+1) = x(k) + (pas/6)*( k1x + 2*k2x + 2*k3x + k4x );
        y(k+1) = y(k) + (pas/6)*( k1y + 2*k2y + 2*k3y + k4y );
    end
end