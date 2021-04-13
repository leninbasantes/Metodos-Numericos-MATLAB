function Modos(fx,n,valor_c,valor_e,valor_N,valor_x,aux)
syms c;
syms e;
syms n1
syms x;

switch (aux)
    case 1
       [suma,Iteracion,Polinomio]=PolinomioTaylor(fx,n,c,x); 
       [Error_Truncamiento]=E_truncamiento(fx,n,c,x,ep);
       disp('Interacion');
       disp(Iteracion);
       disp('Polinomio');
       disp(Polinomio);
       disp('Error_Truncamiento');
       disp(Error_Truncamiento);
       T = table(Iteracion,Polinomio,Error_Truncamiento);
       disp(T);
       hold on;
       ezplot(fx);
       hold off;
       grid;
    case 2
       [suma,Iteracion,Polinomio]=PolinomioTaylor(fx,n,valor_c,x); 
       [Error_Truncamiento]=E_truncamiento(fx,n,valor_c,x,e);
       disp('Interacion');
       disp(Iteracion);
       disp('Polinomio');
       disp(Polinomio);
       disp('Error_Truncamiento');
       disp(Error_Truncamiento);
       T = table(Iteracion,Polinomio,Error_Truncamiento);
       disp(T);
       hold on;
       ezplot(fx);
       ezplot(suma);
       %aqui va el cirucilo
       hold off;
       grid;
    case 3
       [suma,Iteracion,Polinomio]=PolinomioTaylor(fx,n,valor_c,x); 
       [Error_Truncamiento]=E_truncamiento(fx,n,valor_c,x,valor_e);
       disp('Interacion');
       disp(Iteracion);
       disp('Polinomio');
       disp(Polinomio);
       disp('Error_Truncamiento');
       disp(Error_Truncamiento);
       T = table(Iteracion,Polinomio,Error_Truncamiento);
       disp(T);
       hold on;
       ezplot(fx);
       ezplot(suma);
       %aqui va el cirucilo
       hold off;
       grid;

    case 4
      
    case 5
        [suma2,Iteracion,Polinomio]=PolinomioTaylor(fx,n,c,x); 
       [suma,Iteracion,Polinomio]=PolinomioTaylorTOTAL(fx,n,valor_c,valor_x,x); 
       [Error_Truncamiento]=E_truncamientoTotal(fx,n,valor_c,valor_e,valor_x,x);
       %convergencia
       [Error_Residual]=E_residual(fx,n,valor_c,valor_e,valor_N,valor_x,x);
       [Error_Absoluto] = E_absoluto(fx,n,valor_c,x,valor_x);
       [Error_Relativo] = E_relativo(fx,n,valor_c,x,valor_x);
       disp('Interacion');
       disp(Iteracion);
       disp('Polinomio');
       disp(Polinomio);
       disp('Error_Truncamiento');
       disp(Error_Truncamiento);
       disp('Radio_Convergencia');
       disp('Error_Residual');
       disp(Error_Residual);
       disp('Error_Absoluto');
       disp(Error_Absoluto);
       disp('Error_Relativo');
       disp(Error_Relativo);
       T = table(Iteracion,Polinomio,Error_Truncamiento);
       disp(T);
       hold on;
       ezplot(fx);
       ezplot(suma2);
       %aqui va el cirucilo
       %circulo entrecortado
       hold off;
       grid;

end   
end