function [Error_Absoluto] = E_absoluto(fx,n,p,x,valor_x)
suma=subs(fx,x,p);
syms vacio;
Error_Absoluto = [vacio];
for i=1:1:n
    Pn=diff(fx,i);
    f=factorial(i);
    suma=suma+((subs(Pn,x,p)*((valor_x-p)^i))/f);
    eabsoluto = (subs(fx,x,valor_x)-suma);
    Error_Absoluto = [Error_Absoluto;eabsoluto];
end
end