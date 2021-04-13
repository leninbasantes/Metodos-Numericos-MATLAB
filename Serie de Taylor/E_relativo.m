function [Error_Relativo] = E_relativo(fx,n,p,x,valor_x)
    suma=subs(fx,x,valor_x);
    syms vacio;
    Error_Relativo = [vacio];
    for i=1:1:n
        Pn=diff(fx,i);
        f=factorial(i);
        suma=suma+((subs(Pn,x,p)*((valor_x-p)^i))/f);
        eRelativo=subs(fx,x,valor_x)-suma;
        eRelativo=(eRelativo/subs(fx,x,valor_x))*100;
        Error_Relativo = [Error_Relativo;eRelativo];
    end  
end