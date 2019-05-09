function w=LuDebSinha2016b(x,y,keyf,keyxy)
% This file provides all functions defining LuDebSinha16a problem 
% and their first and second order derivatives.
% [dim_x dim_y dim_G dim_g] = [1 1 4 0]


if nargin<4 || isempty(keyxy)
    switch keyf
    case 'F'; w = (x-0.5)^2+(y-1)^2;
    case 'G'; w = [-x; x-1; -y; y-2];
    case 'f'; a = (1.5*y-x)/0.055;
              w = 2-exp(-a^0.4 )-0.8*exp(-( (2*y+x-3)/0.5 )^2 );         
    case 'g'; w = [];  
    end    
else
    switch keyf        
    case 'F'
        switch keyxy
        case 'x' ; w = 2*(x-0.5);         
        case 'y' ; w = 2*(y-1);   
        case 'xx'; w = 2;
        case 'xy'; w = 0;
        case 'yy'; w = 2;
        end 
    case 'G'  
        switch keyxy            
        case 'x' ; w = [-1;1;0;0];    
        case 'y' ; w = [ 0;0;-1;1];       
        case 'xx'; w = zeros(4,1);
        case 'xy'; w = zeros(4,1);
        case 'yy'; w = zeros(4,1);
        end           
	case 'f'
        p1 = [-1 1.5 0 0.055 0.4]; 
        p2 = [ 1 2 -3 0.5 2]; 
        switch keyxy
        case 'x' ; w =-Df(x,y,p1,'x') -0.8*Df(x,y,p2,'x');        
        case 'y' ; w =-Df(x,y,p1,'y') -0.8*Df(x,y,p2,'y');     
        case 'xx'; w =-Df(x,y,p1,'xx')-0.8*Df(x,y,p2,'xx');
        case 'xy'; w =-Df(x,y,p1,'xy')-0.8*Df(x,y,p2,'xy');
        case 'yy'; w =-Df(x,y,p1,'yy')-0.8*Df(x,y,p2,'yy');
        end            
	case 'g'   
        switch keyxy
        case 'x' ; w = [];    
        case 'y' ; w = [];       
        case 'xx'; w = [];
        case 'xy'; w = [];
        case 'yy'; w = [];
        end        
   end   
end
w = real(w);
end

function [w]=Df(x,y,par,keyxy )

a   = par(1);
b   = par(2);
c   = par(3);
d   = par(4);
k   = par(5);
g   = (a*x+b*y+c)/d;


gk  = g^k;
gk1 = (g+1e-14)^(k-1);
gk2 = (g+1e-14)^(k-2);


gx  = a/d; 
gy  = b/d;
f   = exp( -gk );

switch keyxy 
case 'x' ; w   = (-k*gx)*f*gk1;
case 'y' ; w   = (-k*gy)*f*gk1;
case 'xx'; fx  = (-k*gx)*f*gk1;
           w   = (-k*gx)*( fx*gk1+(k-1)*gx*f*gk2 )';
case 'xy'; fy  = (-k*gy)*f*gk1;
           w   = (-k*gx)*( fy*gk1+(k-1)*gy*f*gk2 );
case 'yy'; fy  = (-k*gy)*f*gk1;
           w   = (-k*gy)*( fy*gk1+(k-1)*gy*f*gk2)';
end 
end
