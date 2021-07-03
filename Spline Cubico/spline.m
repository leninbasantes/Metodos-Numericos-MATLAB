function spline
clc;
syms x;
%Se le da la opcion al usuario de poder elegir la opcion de entrada que
%tendra el programa. Como se especifica en el menu.
disp('--------Modo de Lectura--------');
disp('[L]-> Agregar puntos X y una Funcion');
disp('[F]-> Agregar puntos X y F(x)');
disp('[N]-> Salir');
prompt = 'Ingrese [L] o [F] o [N] : ';
str = input(prompt,'s');

while((isempty(str))||(str~='L')&&(str~='F')&&(str~='N'))%condicion para verificar la respuesta del mensaje 
    clc;%se limpia el mensaje
    disp('!!!!Valor ingresado ERRONEO, ingrese nuevamente!!!!');
    disp('[L]-> Agregar puntos X y Funcion');
    disp('[F]-> Agregar puntos X y F(x)');
    disp('[N]-> Salir');
    prompt = 'Ingrese [L] o [F] o [N] : ';
    str = input(prompt,'s');%se lanza un mensaje 
end

%Condicion para cuando el usuario quiera ingresar la funcion y los puntos
%"x" 
if (str=='L')
    X=input('Ingrese los puntos x. Ejemplo [1 2 3 4 5]: ');
    Fn=input('Ingrese la Funcion f(x). Ejemplo x^4: ');
    n=length(X);%Se obtiene la longitud del arreglo para poder realizar la operacaion al momentos de evaluar en la funcion ingresada
    for i=1:n
        %Utilizamos subs para poder evaluar el punto de la posicion i en la
        %funcion y lo guardamos en una posicion del arreglo y(i).
        y(i)=subs(Fn,x,X(i));
    end
    %Enviamos todos los datos obtenido a la funcion desarollo donde hara
    %los calculos para obtener los spline
    desarollo(X,y,n);
end

%Condicion para cuando el usuario quiera ingresar puntos en x y f(x)
if (str=='F')
    X=input('Ingrese los puntos x. Ejemplo [1 2 3 4 5]: ');
    y=input('Ingrese los puntos f(x). Ejemplo [2 4 6 8 10]: ');
    %Obtenemos la longitud de ambos arreglos es decir X y Y donde se
    %almacenaron los puntos que ingreso el usuario.
    n=length(X);
    val=length(y);
    %Se valida que tenga la misma longitud.
    while(n~=val)
        clc;%se limpia el mensaje
        disp('!!!!Valor ingresado ERRONEO, debe tener la misma longitud!!!!');
        X=input('Ingrese los puntos x. Ejemplo [1 2 3 4 5]: ');
        y=input('Ingrese los puntos f(x). Ejemplo [2 4 6 8 10]: ');
        n=length(X);
        val=length(y);
    end
    %Obteniendo los datos se manda a llamar a la funcion desaroolo para
    %proceder hacer los calculos.
    desarollo(X,y,n);
end

%Se realiza el condicional para que el usuario tenga la oportunidad de
%salir del programa.
if (str=='N')
 disp('Gracias usted esta saliendo');
end   
end 

function desarollo(X,y,n)
%En la funcion desarollo traemos datos X que son los puntos de x, y que son
%los puntos en f(x) y n que es la longitud de los datos ingresados.
%Cada ves que estamos trabajando un un spline cubico se puede utilizar la
%definicion que la segunda derivada del spline 0 "S0" es igual a 0 y que la
%segunda derivada del ultimo spline "SN" sera igual a 0
S0=0;
SN=0;
%Se calcula el tamaño de paso 
for i=1:n-1
  h(i)= X(i+1)-X(i);
end
%Se realiza el calculo de la segundas diferencias divididas
for k=1:n-2
    b(k)=6*((y(k+2)-y(k+1))/h(k+1)-(y(k+1)-y(k))/h(k)) ;
end
%Sistema de ecuaciones para hallar las segundas derivadas. 
Matriz(1,1)=2*(h(1)+ h(2) );
Matriz(1,2)= h(2);
B(1)=b(1)-h(1)*S0;
Matriz(n-2,n-3)=h(n-2);
Matriz(n-2,n-2)=2*(h(n-2)+h(n-1));
B(n-2)=b(n-2)-h(n-1)*SN;
for k=2:n-3
Matriz(k,k-1)=h(k);    
Matriz(k,k)=2*(h(k)+h(k+1));
Matriz(k,k+1)=h(k+1);
B(k)=b(k);
end
aux=inv(Matriz)*B';
w(1)=S0;
w(n)=SN;
for j=2:n-1
    w(j)= aux(j-1);
end
%Realizamos el calculo de las primeras derivadas operando el vector y por
%cada posicion W
for k=1:n-1
    U(k)=(y(k+1)-y(k))/h(k)-(h(k)/6)*(2*w(k)+w(k+1));
end
%Se calcula los coeficientes de los polinomios , donde le guardamos en una
%matriz
for k=1:n-1
    coeficiente(k,1)=(w(k+1)-w(k))/(6*h(k));
    coeficiente(k,2)=w(k)/2-3*X(k)*coeficiente(k,1);
    coeficiente(k,3)=U(k)-X(k)*w(k)+3*coeficiente(k,1)*X(k)^2;
    coeficiente(k,4)= -coeficiente(k,1)*X(k)^3 + (X(k)^2)*w(k)/2-X(k)*U(k)+y(k);
end
coeficiente

%Procedemos a graficar los puntos mediante el comando plot a partir de los
%puntos X y Y. El comando grid on nos ayudara a visualizar las cuadriculas
%de la grafica y finalmente el comando hold on el grafico se mantendra en
%el area de trabajo.
for i=1:n-1
    t(i,:)=X(i):0.01*h(i):X(i+1);
    p(i,:)=coeficiente(i,1).*(t(i,:).^3)+coeficiente(i,2).*(t(i,:).^2)+coeficiente(i,3).*t(i,:)+coeficiente(i,4);
    plot(t(i,:),p(i,:),'k')
    grid on 
    hold on
end
plot(X,y,'o')
for j=1:n-1
    for i=1:4
        s(i)=coeficiente(j,i);
    end
    disp(strcat('p',num2str(j),'=',poly2str(s,'x')));
end
end