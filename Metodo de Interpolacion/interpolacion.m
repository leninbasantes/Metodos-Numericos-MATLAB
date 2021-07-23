function interpolacion
clc;
syms x;
%Se le da la opcion al usuario de poder elegir la opcion de entrada que
%tendra el programa. Como se especifica en el menu.
disp('--------Modo de Lectura--------');
disp('[L]-> LAGRANGE');
disp('[N]-> NEWTON');
disp('[S]-> SALIR');
prompt = 'Ingrese [L] o [N] o [S] : ';
str = input(prompt,'s');

while((isempty(str))||(str~='L')&&(str~='N')&&(str~='S'))%condicion para verificar la respuesta del mensaje 
    clc;%se limpia el mensaje
    disp('!!!!Valor ingresado ERRONEO, ingrese nuevamente!!!!');
    disp('--------Modo de Lectura--------');
    disp('[L]-> LAGRANGE');
    disp('[N]-> NEWTON');
    disp('[S]-> SALIR');
    prompt = 'Ingrese [L] o [N] o [S] : ';
    str = input(prompt,'s');%se lanza un mensaje 
end


if (str=='L')
    disp('Metodo de Lagrange');
    X=input('Ingrese lo puntos X. Ejemplo [5 2 6]: ');
    Y=input('Ingrese los puntos Y. Ejemplo [5 2 4]: ');
    longitudx=length(X);
    longitudy=length(Y);
        while(longitudx~=longitudy)
        clc;%se limpia el mensaje
        disp('!!!!Valor ingresado ERRONEO, debe tener la misma longitud!!!!');
        X=input('Ingrese lo puntos X. Ejemplo [5 2 6]: ');
        Y=input('Ingrese los puntos Y. Ejemplo [5 2 4]: ');
        longitudx=length(X);
        longitudy=length(Y);
        end
        lagrange(X,Y);

end


if (str=='N')
    disp('Metodo de Newton');
    X=input('Ingrese lo puntos X. Ejemplo [5 2 6]: ');
    Y=input('Ingrese los puntos Y. Ejemplo [5 2 4]: ');
    longitudx=length(X);
    longitudy=length(Y);
        while(longitudx~=longitudy)
        clc;%se limpia el mensaje
        disp('!!!!Valor ingresado ERRONEO, debe tener la misma longitud!!!!');
        X=input('Ingrese lo puntos X. Ejemplo [5 2 6]: ');
        Y=input('Ingrese los puntos Y. Ejemplo [5 2 4]: ');
        longitudx=length(X);
        longitudy=length(Y);
        end
     newton(X,Y);
end

%Se realiza el condicional para que el usuario tenga la oportunidad de
%salir del programa.
if (str=='S')
 disp('Gracias usted esta saliendo');
end 
end

function lagrange(X,Y)
lx=length(X);
syms x; %Definir la variable x para el polinomio
Pn=0;  %Inicializar la variable donde se guardara el polinomio de lagrange
for i=1:lx  %Controla L_i
    producto1=1; %Productos que se realizan en el numerador
    producto2=1; %Productos que se realizan en el denominador
    for j=1:lx  %Controla x_i
        if(j==i) %Condicion para efectuar los productos del denominador
           for k=1:lx
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
title('Gráfica Polinomio de Lagrange')
xlabel('Eje x');
ylabel('Eje y');
hold off
disp('COEFICIENTE DE LAGRANGE');
disp(Li.');
if(lx<=20)
    disp('POLINOMIO DE LAGRANGE');
    disp(Pn);
end
end

function newton(x,y)
xa=x;ya=y;

d=zeros(length(y));
d(:,1)=y';
for k=2:length(x)
  for j=1:length(x)+1-k
    d(j,k)=(d(j+1,k-1)-d(j,k-1))/(x(j+k-1)-x(j));
  end
end

for w=1:length(x)
  ds=num2str(abs(d(1,w)));
  if w>1
    if x(w-1)<0
      sg1='+';
    else
      sg1='-';
    end
  end
  if d(1,w)<0
    sg2='-';
  else
    sg2='+';
  end
  if w==1
    acum=num2str(d(1,1));
  elseif w==2
    polact=['(x' sg1 num2str(abs(x(w-1))) ')' ];
    actual=[ds '*' polact];
  acum=[acum sg2 actual];
  else
    polact=[polact '.*' '(x' sg1 num2str(abs(x(w-1))) ')' ];
    actual=[ds '*' polact];
  acum=[acum sg2 actual];
end
end

fprintf('Polinomio interpolacion Newton: %s n')
disp(acum)

if x>max(xa)|x<min(xa)
  fprintf('t Punto fuera de rango. El resultado puede equivocado n');
end
xinterp=x;
yinterp=eval(acum);

xg=linspace(min(xa),max(xa));
x=xg;yg=eval(acum);
plot(xg,yg,xa,ya,'.r',xinterp,yinterp,'or');
grid
end