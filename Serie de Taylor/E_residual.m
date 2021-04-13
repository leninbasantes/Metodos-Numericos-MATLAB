function [Error_Residual]=E_residual(fx,n,valor_c,valor_e,valor_N,valor_x,x)
syms vacio;
    Error_Residual = [vacio];
    for i=1:1:n+valor_N
        Rt=diff(fx,i+1);
        eResidual=(subs(Rt,x,valor_e)/factorial(i+1))*(valor_x-valor_c)^(i+1);
        Error_Residual = [Error_Residual;eResidual];
    end
end