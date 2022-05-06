function [root, fx, ea, iter] = falsePosition(func, xl, xu, es, maxit, varargin)
%falsePosition finds the root of a function using false position method
if nargin == 3
    es= 0.0001;
    maxit= 200;
end 
if nargin == 4
    maxit=200;
end
iter=0;
ea=100;

if xl==0
    xr=xu;
else
    xr=xl;
end
while ea>es && iter<maxit
    if func(xl)*func(xu)>= 0
        if func(xl)*func(xu)==0
            if func(xl)==0
                break
                xr=xl;
            else
                break
                xr=xu;
            end
        else
            error('Bounds do not bracket root.')
        end
    end
      xrp=xr;
    xr = xl -(((xu-xl)*func(xl))/(func(xu)-func(xl)));
        ea=abs(((xr-xrp)/(xr))*100);
      
        iter = iter + 1;
    if func(xr)*func(xl)<0
        xu=xr;
    elseif func(xr)*func(xu)<0
        xl=xr;
    else
        if func(xl)==0
            ea = 0;
            break
        else
            ea = 0;
            break
        end

    end
   
end
root=xr;
fx=func(xr);
end