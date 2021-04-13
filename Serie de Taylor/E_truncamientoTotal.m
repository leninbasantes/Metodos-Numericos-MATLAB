function [Error_Truncamiento]=E_truncamientoTotal(fx,n,valor_c,valor_e,valor_x,x)
syms vacio;
Error_Truncamiento = [vacio];
    for i=1:1:n
        Rt=diff(fx,i+1);
        f = factorial(i+1);
        truncamiento=(subs(Rt,x,valor_e)*(valor_x-valor_c)^(i+1)/f);
        Error_Truncamiento = [Error_Truncamiento;truncamiento];
    end
end