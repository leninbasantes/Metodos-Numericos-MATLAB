function [primera,Iteracion,Polinomio]= PolinomioTaylor(fx,n,c,x)
    suma=subs(fx,x,c);
    Pn=diff(fx,1);
    f=factorial(1);
    primera=suma+((subs(Pn,x,c)*((x-c)^1))/f);
    Polinomio = [primera];
    Iteracion = [1];
    for i=2:1:n
        j = i;
        Iteracion = [Iteracion;j];
        j = j + 1;
        Pn=diff(fx,i);
        f=factorial(i);
        primera=primera+((subs(Pn,x,c)*((x-c)^i))/f);
        Polinomio = [Polinomio;primera];
    end
end