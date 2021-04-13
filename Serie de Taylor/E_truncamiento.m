function [Error_Truncamiento]=E_truncamiento(fx,n,c,x,ep)
%Se crea un arreglo para poder interpretarlos en las tablas
        Rt=diff(fx,2);
        f = factorial(2);
        segundo=(subs(Rt,x,ep)*(x)^(2)/f);
        Error_Truncamiento = [segundo];
    for i=2:1:n
        Rt=diff(fx,i+1);
        f = factorial(i+1);
        truncamiento=(subs(Rt,x,ep)*(x-c)^(i+1)/f);
        Error_Truncamiento = [Error_Truncamiento;truncamiento];
    end