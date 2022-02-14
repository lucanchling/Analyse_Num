function [x,y,pas]=Euler_Richardson(x0,y0,xp0,yp0,tmin,tmax,pas,F1,F2,G1,G2)
    %t = tmin:pas:tmax;
    k=1;
    x=[x0];y=[y0];xp=[xp0];yp=[yp0];
    t=tmin;
    % COnstante 
    epsilon = .01;
    
    while (t < tmax)
        
        k1 = [F1(x(k),y(k),xp(k),yp(k));...
            F2(x(k),y(k),xp(k),yp(k));...
            G1(x(k),y(k),xp(k),yp(k));...
            G2(x(k),y(k),xp(k),yp(k))];
        
        k1x=k1(1);        k1y=k1(2);        k1px=k1(3);        k1py=k1(4);
        
        k2 = [F1(x(k) + k1x*pas/2, y(k) + k1y*pas/2 ,xp(k)+k1px*pas/2,yp(k)+k1py*pas/2)
              F2(x(k) + k1x*pas/2, y(k) + k1y*pas/2 ,xp(k)+k1px*pas/2,yp(k)+k1py*pas/2)
        	  G1(x(k) + k1x*pas/2, y(k) + k1y*pas/2 ,xp(k)+k1px*pas/2,yp(k)+k1py*pas/2)
        	  G2(x(k) + k1x*pas/2, y(k) + k1y*pas/2 ,xp(k)+k1px*pas/2,yp(k)+k1py*pas/2)];
        
        k2x=k2(1);        k2y=k2(2);        k2px=k2(3);        k2py=k2(4);
        
        delta = pas/2*abs(norm(k1)-norm(k2));
        
        pas=.9*pas*sqrt(epsilon/delta);
        
        if (delta <= epsilon)
            x =[x , x(k) + k2x*pas];
            y = [y , y(k) + k2y*pas]; 
            xp = [xp , xp(k) + k2px*pas];
            yp = [yp , yp(k) + k2py*pas];
            t=t+pas;
            k = k+1;
        end
        
        
    end
end