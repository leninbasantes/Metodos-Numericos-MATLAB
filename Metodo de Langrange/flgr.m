function flgr
prompt = 'Se tiene que importa la matriz de excel? Y/N [Y]: ';
str = input(prompt,'s');%se lanza un mensaje para poder importar la tabla del excel 
while((isempty(str))||(str~='Y')&&(str~='N'))%condicion para verificar la respuesta del mensaje para poder importar la tabla
    clc;%se limpia el mensaje
    disp('Valor ingresado ERRONEO, ingrese "Y" para seguir o "N" para salir');
    prompt = 'Ingrese su opcion Y/N [Y]: ';
    str = input(prompt,'s');%se lanza un mensaje para poder importar la tabla del excel hasta que se cumpla la condicion
end
if (str=='Y')%condicion valida para poder importar los datos de la tabla del excel
    clc;%se limpia 'Y'
    disp('____________________________________________________________________________');
    disp('UNIVERSIDAD DE LAS FUERZAS ARMADAS ESPE - SANGOLQUI');
    disp('METODOS NUMERICOS PARA INGENIERIA DE SOFTWARE');
    disp('NRC: 2797');
    disp('INTERPOLACION DE LAGRANGE');
    disp('ELABORADO POR: LENIN BASANTES');
    disp('____________________________________________________________________________');
    disp('                               INGRESO DE DATOS                             ');
    disp('Cargando datos de Excel ......');
    A= xlsread('Datos');%se importan los datos de la tabla del excel 
    [Pn,Li,error_truncamiento]=PolinomioLagrange(A);
    [Pn,Li,error_truncamiento]=Evaluar(Pn,Li,error_truncamiento,A);
    disp('____________________________________________________________________________');
else
    disp('Para continuar se debe importar, Gracias usted esta saliendo');
end

end


function [Pn,Li,error_truncamiento] = PolinomioLagrange(A)
[m,n]=size(A);%reservando el tama?o de la matriz del excel
Y=[A(1:m)];%guardando el valor de cada columna del excel
X=[A((m+1):(2*m))];%guardando el valor de cada columna del excel
syms x; %Definir la variable x para el polinomio
Pn=0;  %Inicializar la variable donde se guardara el polinomio de lagrange
for i=1:m  %Controla L_i
    producto1=1; %Productos que se realizan en el numerador
    producto2=1; %Productos que se realizan en el denominador
    for j=1:m  %Controla x_i
        if(j==i) %Condicion para efectuar los productos del denominador
           for k=1:m
              if(X(j)-X(k)~=0)
                 producto2=(producto2).*(X(j)-X(k));
              end
           end
        elseif(j~=i) %Condicion para efectuar los productos del numerador
           producto1=(producto1).*(x-X(j));
        end
    end
    general=producto1./producto2;
    Li(i)=general;
    L(i)=general.*Y(i);
    Pn=Pn+L(i);
end
Pn = simplify(Pn);
hold on
fplot(Pn);
plot(X,Y,'g*');
title('Gr�fica Polinomio de Lagrange')
xlabel('Eje x');
ylabel('Eje y');
hold off
disp('COEFICIENTE DE LAGRANGE');
disp(Li.');
if(m<=20)
    disp('POLINOMIO DE LAGRANGE');
    disp(Pn);
end

error_truncamiento=1;
for i=1:m
    error_truncamiento=(error_truncamiento).*(x-X(i));
end
error_truncamiento = (diff(Pn,m,x).*error_truncamiento)./m;
disp('ERROR DE TRUNCAMIENTO');
disp(error_truncamiento);

end

function [Pn,Li,error_truncamiento] = Evaluar(Pn,Li,error_truncamiento,A)
syms x;
[m,n]=size(A);%reservando el tama?o de la matriz del excel
Y=[A(1:m)];%guardando el valor de cada columna del excel
X=[A((m+1):(2*m))];%guardando el valor de cada columna del excel
Min=min(X);
Max=max(X);
Min=((round(Min))-1);
Max=((round(Max))-1);
r = (Max-Min).*rand(1) + Min;
Pn = subs(Pn,x,r);
Li = subs(Li,x,r);
error_truncamiento = subs(error_truncamiento,x,r);
formatSpec ='Valores de Li evaluados en x = %f\n';
fprintf(formatSpec,r);
disp(Li.');
formatSpec = 'El valor generado randomicamente dentro del dominio de los puntos de X es (%f), reemplazando este valor en el polinomio anteriormente obtenido el resultado es= (%f)';
fprintf(formatSpec,r,Pn); 
formatSpec ='\n\nValor del error de truncamiento evaluado en x = %f : %f\n';
fprintf(formatSpec,r,error_truncamiento);

end
