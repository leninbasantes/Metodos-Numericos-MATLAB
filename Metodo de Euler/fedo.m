function fedo
%t-N
%x_0=5
%y_0=2
%h=0.25
%ultimo intervalo=10
clc;
syms e;
syms t;
syms N;
funcion=input('Ingrese f(x,y): ');
X(1)=input('Ingrese el valor de X_0: ');
Y(1)=input('Ingrese el valor de Y_0: ');
h=input('Ingrese tanaño de paso "h": ');
intervalof=input('Ingrese el final de intervalo: ');
X(1)=5;%Declaramos x_0 con el valor de 5
Y(1)=2;%Declaramos y_0 con el valor de 2
X1(1)=X(1);%Creamos otro arreglo para guardar los valores de euler mejorado
Y1(1)=Y(1);

clc;
disp('_______________________________________________________________________________________________________________________________________________');
    disp('UNIVERSIDAD DE LAS FUERZAS ARMADAS ESPE - SANGOLQUI');
    disp('METODOS NUMERICOS PARA INGENIERIA DE SOFTWARE');
    disp('EULER Y EULER MEJORADO');
    disp('ELABORADO POR: LENIN BASANTES');
   disp('_______________________________________________________________________________________________________________________________________________');

   
   disp('Datos');
   disp('Ecuacion f(x,y) dada: ');
   disp(funcion);
   formatSpec4='y_0= %f';
   fprintf(formatSpec4,Y(1));
   formatSpec4='\nx_0= %f';
   fprintf(formatSpec4,X(1));
   formatSpec4='\nh= %f';
   fprintf(formatSpec4,h);
   formatSpec4='\nEncontrar cuantos procesos hace en = %fs\n\n';
   fprintf(formatSpec4,intervalof);
   

tspan=[X(1):h:intervalof];%definimos en punto inicial del intervalo X(1), un paso h y un final de intervalo (intervalof)
%[t,y] = ode45(@(t,y) (-20*y+7*e^(-0.5*t)), tspan, Y(1));%Utilizaremos ode45 para poder obtener solucion exacta con puntos de x y y 

valorn=numel(tspan);%para poder realizar cada error se obtiene en numero de iteraciones que tiene el arreglo
disp('_______________________________________________________________________________________________________________________________________________');
disp('Euler');
formatSpec2 = '\n[Iteracion]     [X_n]               [Y_n]         [Y Analiticamente]\n';
formatSpec3 = '[%d]             (%f)         (%f)      (%f)\n';
fprintf(formatSpec2);
for i=1:1:valorn-1%Realizamos las operaciones para euler
    X(i+1)=X(i)+h;
    Y(i+1)=Y(i)+h*(-20*Y(i)+7*e^(-0.5*X(i)));
end

for i=1:1:valorn%Obtenemos los errores restando los arreglos donde se guardan estos
    ErrorAbsolutoEuler(i)=abs(y(i)-Y(i));    
    ErrorRelativoEuler(i)=(abs(y(i)-Y(i))/y(i));
     fprintf(formatSpec3,i,X(i),Y(i),y(i));
end

formatSpec4 = '\n[Iteracion] [Error absoluto Euler]        [Error Relativo Euler]\n';
formatSpec5 = '[%d]             (%f)                  (%f)\n';
fprintf(formatSpec4);
for i=1:1:valorn%Obtenemos los errores restando los arreglos donde se guardan estos
     fprintf(formatSpec5,i,ErrorAbsolutoEuler(i),ErrorRelativoEuler(i));
end



disp('_______________________________________________________________________________________________________________________________________________');
disp('Euler Mejorado');
formatSpec1 = '\n[Iteracion]     [X_n]               [Y_n]         [Y Analiticamente]\n';
formatSpec = '[%d]             (%f)         (%f)      (%f)\n';
fprintf(formatSpec1);
for i=1:1:valorn-1%Realizamos las operaciones para euler mejorado
    X1(i+1)=X1(i)+h;
    Y1(i+1)=Y1(i)+h*(-20*Y(i)+7*e^(-0.5*X(i)));
    Y1(i+1)=Y1(i)+h*(((X1(i)-Y1(i))+(X1(i+1)-Y1(i+1)))/2);
end


for i=1:1:valorn%Obtenemos los errores restando los arreglos donde se guardan estos
    ErrorAbsolutoEulerMejorado(i)=abs(y(i)-Y1(i));
    ErrorRelativoEulerMejorado(i)=(abs(y(i)-Y1(i))/y(i));
    fprintf(formatSpec,i,X1(i),Y1(i),y(i));
end


formatSpec6 = '\n[Iteracion]   [Error absoluto EulerM]        [Error Relativo EulerM]\n';
formatSpec7 = '[%d]             (%f)                    (%f)\n';
fprintf(formatSpec6);
for i=1:1:valorn%Obtenemos los errores restando los arreglos donde se guardan estos
    ErrorAbsolutoEulerMejorado(i)=y(i)-Y1(i);
    ErrorRelativoEulerMejorado(i)=((y(i)-Y1(i))/y(i));
    fprintf(formatSpec7,i,ErrorAbsolutoEulerMejorado(i),ErrorRelativoEulerMejorado(i));
end


%%%%%%%%%%%%%%%%%%%%%%Se imprime exacto
im1=subplot(1,3,1);
hold on
xlabel('Segundos');
ylabel('Procesos');
plot(t,y,'-o');
title(im1,{'Exacto'});
legend(im1,{'Exacto'});
hold off
%%%%%%%%%%%%%%%%%%%%%%%%Se imprime euler,exacto
im2=subplot(1,3,2);
hold on
xlabel('Segundos');
ylabel('Procesos');
plot(t,y,'-o');
plot(X,Y,'-o');
title(im2,{'Exacto-Euler'});
legend(im2,{'Exacto','Euler'});
hold off
%%%%%%%%%%%%%%%%%%%%%%%%%Se imprime euler,euler_mejorado,exacto
im3=subplot(1,3,3);
hold on
xlabel('Segundos');
ylabel('Procesos');
plot(t,y,'-o');
plot(X,Y,'-o');
plot(X1,Y1,'-*')
title(im3,{'Exacto-Euler-Euler Mejorado'});
legend(im3,{'Exacto','Euler','Euler Mejorado'});
hold off

end