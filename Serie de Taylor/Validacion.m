function [contador,fx,n,p,e,n1,x]= Validacion()
syms contador;
syms e;
syms n1;
syms x;
disp('____________________________________________________________________________');
disp('METODOS NUMERICOS PARA INGENIERIA DE SOFTWARE');
disp('NRC: 2797');
disp('SERIE DE TAYLOR');
disp('ELABORADO POR: LENIN BASANTES');
disp('____________________________________________________________________________');
disp('                               INGRESO DE DATOS                             ');
fx=input('->Ingrese la funcion:  ');
while(isempty(fx))
    disp('No ha ingresado el valor de f(x)');
    fx=input('Ingrese la funcion: ');
end

n=input('->Ingrese el orden  :  ');
while(isempty(n))
    disp('No ha ingresado el valor de n');
    n=input('Ingrese la n: ');
end

contador = 1;

if (contador == 1)
   p=input('->Ingrese el punto c:  ');
   if(isempty(p))
       contador=1;
   else
          while(p<0)
          disp('No ha ingresado el valor de c');
          p=input('Ingrese la c: ');
          end
          if(isempty(p))
              contador=1;
          else
          contador=contador+1;
          end
   end
end


if (contador == 2)
   e=input('->Ingrese epcilon:  ');
   if(isempty(e))
       contador=2;
   else
          while(e<p)
          disp('Epsilon debe ser mayor que C');
          e=input('Ingrese la e: ');
          end
          if(isempty(e))
              contador=2;
          else
          contador=contador+1;
          end
   end
end

if (contador == 3)
   n1=input('->Ingrese n:  ');
   if(isempty(n1))
       contador=3;
   else
          while(n1<0)
          disp('N debe ser un numero Natural');
          n1=input('Ingrese la n: ');
          end
          if(isempty(n1))
              contador=3;
          else
          contador=contador+1;
          end
   end
end

if (contador == 4)
   x=input('->Ingrese el punto x:  ');
   if(isempty(x))
       contador=4;
   else
          while(x<e)
          disp('No ha ingresado el valor de x');
          x=input('Ingrese la x: ');
          end
          if(isempty(x))
              contador=4;
          else
          contador=contador+1;
          end
   end
end

disp('____________________________________________________________________________');

end