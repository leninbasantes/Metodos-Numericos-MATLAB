function [suma,Iteracion,Polinomio] = PolinomioTaylorTOTAL(fx,n,valor_c,x,valor_x)
        suma=subs(fx,x,valor_c);
        Iteracion = [0];
Polinomio = [fx];
    for i=1:1:n
        Iteracion = [Iteracion;i];
        Pn=diff(fx,i);
        f=factorial(i);
        suma=suma+((subs(Pn,x,valor_c)*((valor_x-valor_c)^i))/f);
        Polinomio = [Polinomio;suma];
    end 
end