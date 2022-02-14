function [x,y,t]=RK4_2D_bis(x0,y0,xp0,yp0,tmin,tmax,pas,F1,F2,G1,G2)
    t = tmin:pas:tmax;
    x = zeros(size(t));
    y = zeros(size(t));
    xp = zeros(size(t));
    yp = zeros(size(t));
    x(1) = x0;
    y(1) = y0;
    xp(1) = xp0;
    yp(1) = yp0;
    for k=1: (tmax-tmin)/pas
        k1x = F1(x(k),y(k),xp(k),yp(k));
        k1y = F2(x(k),y(k),xp(k),yp(k));
        k1px = G1(x(k),y(k),xp(k),yp(k));
        k1py = G2(x(k),y(k),xp(k),yp(k));
        
        k2x = F1(x(k) + k1x*pas/2, y(k) + k1y*pas/2 ,xp(k)+k1px*pas/2,yp(k)+k1py*pas/2);
        k2y = F2(x(k) + k1x*pas/2, y(k) + k1y*pas/2 ,xp(k)+k1px*pas/2,yp(k)+k1py*pas/2);
        k2px = G1(x(k) + k1x*pas/2, y(k) + k1y*pas/2 ,xp(k)+k1px*pas/2,yp(k)+k1py*pas/2);
        k2py = G2(x(k) + k1x*pas/2, y(k) + k1y*pas/2 ,xp(k)+k1px*pas/2,yp(k)+k1py*pas/2);
        
        k3x = F1(x(k) + k2x*pas/2, y(k) + k2y*pas/2 ,xp(k)+k2px*pas/2,yp(k)+k2py*pas/2);
        k3y = F2(x(k) + k2x*pas/2, y(k) + k2y*pas/2 ,xp(k)+k2px*pas/2,yp(k)+k2py*pas/2);
        k3px = G1(x(k) + k2x*pas/2, y(k) + k2y*pas/2 ,xp(k)+k2px*pas/2,yp(k)+k2py*pas/2);
        k3py = G2(x(k) + k2x*pas/2, y(k) + k2y*pas/2 ,xp(k)+k2px*pas/2,yp(k)+k2py*pas/2);
        
        k4x = F1(x(k) + k3x*pas, y(k) + k3y*pas,xp(k)+k3px*pas,yp(k)+k3py*pas );
        k4y = F2(x(k) + k3x*pas, y(k) + k3y*pas,xp(k)+k3px*pas,yp(k)+k3py*pas );
        k4px = G1(x(k) + k3x*pas, y(k) + k3y*pas,xp(k)+k3px*pas,yp(k)+k3py*pas );
        k4py = G2(x(k) + k3x*pas, y(k) + k3y*pas,xp(k)+k3px*pas,yp(k)+k3py*pas );
        
        x(k+1) = x(k) + (pas/6)*( k1x + 2*k2x + 2*k3x + k4x );
        y(k+1) = y(k) + (pas/6)*( k1y + 2*k2y + 2*k3y + k4y );       
        xp(k+1) = xp(k) + (pas/6)*( k1px + 2*k2px + 2*k3px + k4px );
        yp(k+1) = yp(k) + (pas/6)*( k1py + 2*k2py + 2*k3py + k4py );
    end
end