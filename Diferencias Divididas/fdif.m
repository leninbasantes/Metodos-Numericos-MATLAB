function fdif
clc;
disp('--------Modo de Lectura--------');
disp('[L]-> Lista de puntos');
disp('[F]-> Funcion');
disp('[N]-> Salir');
prompt = 'Ingrese [L] o [F] o [N] : ';
str = input(prompt,'s');

while((isempty(str))||(str~='L')&&(str~='F')&&(str~='N'))%condicion para verificar la respuesta del mensaje 
    clc;%se limpia el mensaje
    disp('!!!!Valor ingresado ERRONEO, ingrese nuevamente!!!!');
    disp('[L]-> Lista de puntos');
    disp('[F]-> Funcion');
    disp('[N]-> Salir');
    prompt = 'Ingrese [L] o [F] o [N] : ';
    str = input(prompt,'s');%se lanza un mensaje 
end

if (str=='L')%condicion valida para poder importar lista de puntos
    syms x_o;
    syms h;
    syms orden;
    clc;%se limpia 'L'
    Encabe;
    disp('Cargando datos de Excel ......');
    A= xlsread('Datos');%se importan los datos de la tabla del excel 
    disp('La lista de puntos es: ');
    disp(A);
    [Pn]=PolinomioLagrange(A);
    [x_o,h,orden]=solicitud_datos;
    dif(Pn,orden,h,x_o);
    disp('____________________________________________________________________________');
    
end

if (str=='F')
    syms x_o;
    syms h;
    syms x;
    syms orden;
    clc;%se limpia 'F'
    Encabe;
    Pn = input('Ingrese f(x): ');
    [x_o,h,orden]=solicitud_datos;
    dif(Pn,orden,h,x_o);
    disp('____________________________________________________________________________');
end

if (str=='N')
 disp('Gracias usted esta saliendo');
end   

end

function Encabe
    disp('____________________________________________________________________________');
    disp('UNIVERSIDAD DE LAS FUERZAS ARMADAS ESPE - SANGOLQUI');
    disp('METODOS NUMERICOS PARA INGENIERIA DE SOFTWARE');
    disp('DIFERENCIACCION DIVIDIDA');
    disp('ELABORADO POR: LENIN BASANTES');
    disp('____________________________________________________________________________');
    disp('                               INGRESO DE DATOS                             ');
end

function [fx] = PolinomioLagrange(A)
syms x;
[m,n]=size(A);%reservando el tama?o de la matriz del excel
Y=[A(1:m)];%guardando el valor de cada columna del excel
X=[A((m+1):(2*m))];%guardando el valor de cada columna del excel
suma=0;
for i=1:m
    producto1=1;
    producto2=1;
    for j=1:m
        if(j==i)
           for k=1:m
              if(X(j)-X(k)~=0)
                 producto2=(producto2).*(X(j)-X(k));
              end
           end
        elseif(j~=i)
           producto1=(producto1).*(x-X(j));
        end
    end
    general=producto1./producto2;
    L(i)=general.*Y(i);
    suma=suma+L(i);
end
fx=suma;
end

function [x_o,h,orden]=solicitud_datos
x_o=input('Ingrese el valor de punto inicial "x_o":');
h=input('Ingrese el valor de tamanio de paso "h":');
orden=input('Ingrese el valor del orden "n":');
end

function dif(fx,n,h,xi)    %Funcion que permite calcular la e-nesima derivada en cada iteracion
syms x;
for i=1:3
    for j=1:n
        if(i==1)
            Dif_Adelante(j,1)=diferenciacion(fx,j,h,xi,i);   %Almacena el valor de la diferenciacion hacia adelante
        elseif(i==2)
            Dif_Atras(j,1)=diferenciacion(fx,j,h,xi,i);      %Almacena el valor de la diferenciacion hacia atras
        else
            Dif_Centrada(j,1)=diferenciacion(fx,j,h,xi,i);   %Almacena el valor de la diferenciacion centrada
        end
    end
end
e_nesima = (1:n).';
%%%%%%%%%%%%%%% ERROR TRUNCAMIENTO %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i=1:n
    ETruncamiento_DifAdelante(i,1) = double((Dif_Adelante(i,1)/factorial(i+1))*h^(i+1));
    ETruncamiento_DifAtras(i,1) = double((Dif_Atras(i,1)/factorial(i+1))*h^(i+1));
    ETruncamiento_DifCentrada(i,1) = double((Dif_Centrada(i,1)/factorial(i+1))*h^(i+1));
end
%Almacen los resultados en la table de diferenciacio y error de
%truncamiento
T=table(e_nesima,Dif_Adelante,Dif_Atras,Dif_Centrada,ETruncamiento_DifAdelante,ETruncamiento_DifAtras,ETruncamiento_DifCentrada);
disp(T);

%%%%%%%%%%%%%5%%%%ERRORES ABSOLUTO RELATIVO%%%%%%%%%%%%%%%%%%%%%%
for i=1:n
    ErrorAbs_DifAdelante(i,1) = abs(double(subs(diff(fx,i,x),x,xi)-Dif_Adelante(i,1))); 
    ErrorAbs_DifAtras(i,1) = abs(double(subs(diff(fx,i,x),x,xi)-Dif_Atras(i,1)));
    ErrorAbs_DifCentrada(i,1) = abs( double(subs(diff(fx,i,x),x,xi)-Dif_Centrada(i,1)));
    ErrorRel_DifAdelante(i,1) = abs(double(ErrorAbs_DifAdelante(i,1)/subs(diff(fx,i,x),x,xi)));
    ErrorRel_DifAtras(i,1) = abs(double(ErrorAbs_DifAtras(i,1)/subs(diff(fx,i,x),x,xi)));
    ErrorRel_DifCentrada(i,1) = abs(double(ErrorAbs_DifCentrada(i,1)/subs(diff(fx,i,x),x,xi)));
end


disp('ERROR ABSOLUTO Y RELATIVO');
E=table(ErrorAbs_DifAdelante,ErrorAbs_DifAtras,ErrorAbs_DifCentrada,ErrorRel_DifAdelante,ErrorRel_DifAtras,ErrorRel_DifCentrada);
disp(E);


%%%%%%%%%%%%%%%%%%%%%%%%%%%% Graficas%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%PUNTOS%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:n
    j=n;
    P_Ax(i)=double(xi-(i*h));
    P_Ay(i)=double(subs(fx,x,(xi-(i*h))));
    P_Dx(i)=double(xi+(i*h));
    P_Dy(i)=double(subs(fx,x,(xi+(i*h))));
end
P_Cx =[P_Ax,xi,P_Dx];
P_Cy =[P_Ay,double(subs(fx,x,xi)),P_Dy];
P_Ax =[P_Ax,xi];
P_Ay =[P_Ay,double(subs(fx,x,xi))];
P_Dx =[xi,P_Dx];
P_Dy =[double(subs(fx,x,xi)),P_Dy];
%%%%%%%%%%%%%%Diferenciacion Adelante%%%%%%%%%%%%%%%%%%%%%%%%%%%
m_fx = subs(diff(fx,n,x),x,xi);
y_fx = subs(fx,x,xi);
y = m_fx *(x-xi)+ y_fx;
m_fx1 = Dif_Adelante(n,1);
y1 = m_fx1 *(x-xi)+ y_fx;
im1=subplot(1,3,1);
hold on 
fplot(fx);
fplot(y);
fplot(y1,'g');
plot(P_Dx,P_Dy,'m*');
title(im1,{'Diferencia hacia';'Adelante'});
legend(im1,{'f(x)','E-n�sima derivada','Aproximaci�n'})
hold off
%%%%%%%%%%%%%%Diferenciacion Atras%%%%%%%%%%%%%%%%%%%%%%%%%%%
m_fx1 = Dif_Atras(n,1);
y1 = m_fx1 *(x-xi)+ y_fx;
im2=subplot(1,3,2);
hold on
fplot(fx);
fplot(y);
fplot(y1,'g');
plot(P_Ax,P_Ay,'m*');
title(im2,{'Diferencia hacia';'Atras'});
legend(im2,{'f(x)','E-n�sima derivada','Aproximaci�n'})
hold off
%%%%%%%%%%%%%%Diferenciacion Centrada%%%%%%%%%%%%%%%%%%%%%%%%%%%
m_fx1 = Dif_Centrada(n,1);
%y1 = m_fx1 *(x-xi)+ y_fx;
y1 = m_fx1 *(x-(xi-h))+ subs(fx,x,(xi-h));
im3=subplot(1,3,3);
hold on
fplot(fx);
fplot(y);
fplot(y1,'g');
plot(P_Cx,P_Cy,'m*');
title(im3,{'Diferencia';'Centrada'});
legend(im3,{'f(x)','E-n�sima derivada','Aproximaci�n'})
hold off

end

function [T] = diferenciacion(fx,n,h,xi,caso)
syms x;
if(caso==1)
    
    %METODO DE DIFERENCIACION HACIA ADELANTE
    d=0;   
    suma_dd=0;  
    for i=0:n
    d=(-1)^i * (factorial(n)/(factorial(i)*factorial(n-i))) * subs(fx,x,(xi+(n-i)*h)); %Ecuacion general empleada para el calculo dediferenciacion hacia adelante
    suma_dd = suma_dd + d;
    end
    T = double(suma_dd/h^n);
    
elseif(caso==2)
    %METODO DE DIFERENCIACION HACIA ATRAS
    d=0;
    suma_da=0;
    for i=0:n
        d=(-1)^i * (factorial(n)/(factorial(i)*factorial(n-i))) * subs(fx,x,(xi-i*h));  %Ecuacion general empleada para el calculo dediferenciacion hacia atras
        suma_da = suma_da + d;
    end
    T = double(suma_da/h^n);
    
else
    %METODO DE DIFERENCIACION CENTRADA
    d=0;
    suma_dc=0;
    for i=0:n
        d=(-1)^i * (factorial(n)/(factorial(i)*factorial(n-i))) * subs(fx,x,(xi+(n-2*i)*h)); %Ecuacion general empleada para el calculo dediferenciacion centrada
        suma_dc = suma_dc + d;
    end
    T = double(suma_dc/(2^n*h^n));
    
end
end

