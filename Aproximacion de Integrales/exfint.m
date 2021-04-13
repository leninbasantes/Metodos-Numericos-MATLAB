
function exfint
syms x;
encabezado;
f=input('Ingrese la funcion:');
a=input('Ingrese el valor del intervalo minimo "a":');
b=input('Ingrese el valor del intervalo minimo "b":');
%Comprueba que el valor de b sea mayor q el valor de 
if b<a
    clc
    disp('WARNING!!! El l�mite b debe ser mayor que el l�mite a');
    a=input('Ingrese el valor del intervalo minimo "a":');
    b=input('Ingrese el valor del intervalo minimo "b":');   
end
n=input('Ingrese el numero de segmentos "n":');

%Comprueba si el valor de n es mayor que 0
while n<0
    clc;
    disp('El valor de n debe ser mayor que 0');
    n=input('Ingrese el numero de segmentos "n":');
    %fin de la comprobacion
end

e=input('Ingrese el valor de epsilon:');

%Comprueba si el valor de n es mayor que 0
while e<a || e>b
    clc;
    disp('El valor de �psilon debe estar entre a y b');
    e=input('Ingrese el valor de epsilon:');
end
efint(f,a,b,n,e);
end
function encabezado
    disp('____________________________________________________________________________');
    disp('UNIVERSIDAD DE LAS FUERZAS ARMADAS ESPE - SANGOLQUI');
    disp('METODOS NUMERICOS PARA INGENIERIA DE SOFTWARE');
    disp('M�TODOS DE INTEGRACI�N');
    disp('ELABORADO POR: LENIN BASANTES');
    disp('____________________________________________________________________________');
    disp('                               INGRESO DE DATOS                             ');
end
function efint(f,a,b,n,e)
syms x;
    %Determinamos el modulo de n
    modulo = mod(n,2); %el numero de intervalos
    moduloS = mod(n,3);
    
    %trapecio 
    h = (b-a)/n;
    aux = a;
    xi = 0;
    for i=1:n+1
        xi_t(i)=aux;
        y_t(i)=subs(f,aux);
        aux = aux + (h);
    end
    for i=1:(n-1)
        aux = aux + (h);
        xi = xi + subs(f,aux);
    end
    I_Trapecio=double(h*(subs(f,a) + 2*xi + subs(f,b))/2);
    %%%% Calculo del error
    error_absoluto_T = double(int(f,a,b)-I_Trapecio);
    error_relativo_T = double(error_absoluto_T/int(f,a,b));
    error_truncamiento_T = double(-1/12*subs(diff(f,2,x),x,e)*h^3);
    %%%%Grafica
    im1=subplot(1,3,1);
    hold on
    fplot(f);
    plot(xi_t,y_t,'-m x');
    title('Metodo del Trapecio')
    legend('fx','Segmentos');
    hold off
    
    %para simpson 1/3
    if modulo==0
        h = (b-a)/n;
        aux = a;
        xi = 0;
        xii = 0;
        for i=1:n+1
            xi_t(i)=aux;
            y_t(i)=subs(f,aux);
            aux = aux + (h);
        end
        for i=1:(n-1)
            aux = aux + (h);
            if mod(i,2)==0
                xii = xii + subs(f,aux); 
            else xi= xi + subs(f,aux);
            end
        end   
        
        I_Simpson13 = double(h*(subs(f,a) + 4 * xi +  2 * xii + subs(f,b))/3);
        simpson13M = 1;
        simpson13 = n/2;
        %%%% Calculo del error
        error_absoluto_S13 = double(int(f,a,b)-I_Simpson13);
        error_relativo_S13 = double(error_absoluto_S13/int(f,a,b));
        error_truncamiento_S13 = double(-1*((b-a)^4/(180*n^4))*subs(diff(f,4,x),x,e));
        %%%%Grafica
        im1=subplot(1,3,2);
        hold on
        fplot(f);
        plot(xi_t,y_t);
        title('Metodo de Simpson 1/3')
        legend('fx','Intervalo');
        hold off
    end
    if moduloS == 0
        h = (b-a)/n;
        aux = a;
        xi = 0;
        xii = 0;
        xi3 = 0;
        for i=1:n+1
            xi_t(i)=aux;
            y_t(i)=subs(f,aux);
            aux = aux + (h);
        end
        for i=1:(n-1)
            aux = aux + (h);
            ar(i) = aux; 
        end   
        
        for i=1:3:(n-2)
            xi = xi +subs(f,ar(i));
        end
        for i=2:3:(n-1)
           xii = xii + subs(f,ar(i)); 
        end
        for i=3:3:(n-3)
           xi3 = xi3 + subs(f,ar(i)); 
        end
        
        I_Simpson38 = double(3*h*(subs(f,a)+ 3 * xi +  3 * xii + 2 * xi3 +subs(f,b))/8);
        simpson38M = 1;
        simpson38 = n/3;
        %%%% Calculo del error
        error_absoluto_S38 = double(int(f,a,b)-I_Simpson38);
        error_relativo_S38 = double(error_absoluto_S38/int(f,a,b));
        error_truncamiento_S38= double(-((3*h^5)/80)*subs(diff(f,4,x),x,e));
        %%%%Grafica
        im1=subplot(1,3,3);
        hold on
        fplot(f);
        plot(xi_t,y_t,'-r x');
        title('Metodo de Simpson 3/8')
        legend('fx','Segmentos');
        hold off
        
    end
%%% Determinar las combinaciones 
fprintf('\nSe puede aplicar:\n* %d Metodo trapecio simple \n* Metodo trapecio multiple\n',n);
if(mod(n,2)==0)
    num=int64(n/2);
    fprintf('* %d Metodo simpson 1/3 simple \n* Metodo simpson 1/3 multiple\n',num);
    metodos = {'Metodo Trepecio';'Metodo Simpson 1/3'};
    integrales = [I_Trapecio;I_Simpson13];
    Error_Absoluto = [error_absoluto_T;error_absoluto_S13];
    Error_Relativo = [error_relativo_T;error_relativo_S13];
    Error_Truncamiento = [error_truncamiento_T;error_truncamiento_S13];
    t=table(metodos,integrales,Error_Absoluto,Error_Relativo, Error_Truncamiento);
end      
if(mod(n,3)==0)
    num=int64(simpson38);
    fprintf('* %d Metodo simpson 3/8 simple \n* Metodo simpson 3/8 multiple\n',num);
    metodos = {'Metodo Trepecio';'Metodo Simpson 3/8'};
    integrales = [I_Trapecio;I_Simpson38];
    Error_Absoluto = [error_absoluto_T;error_absoluto_S38];
    Error_Relativo = [error_relativo_T;error_relativo_S38];
    Error_Truncamiento = [error_truncamiento_T;error_truncamiento_S38];
    t=table(metodos,integrales,Error_Absoluto,Error_Relativo,Error_Truncamiento);
end
if(mod(n,2)==0 && mod(n,3)==0)
    metodos = {'Metodo Trepecio';'Metodo Simpson 1/3';'Metodo Simpson 3/8'};
    integrales = [I_Trapecio;I_Simpson13;I_Simpson38];
    Error_Absoluto = [error_absoluto_T;error_absoluto_S13;error_absoluto_S38];
    Error_Relativo = [error_relativo_T;error_relativo_S13;error_relativo_S38];
    Error_Truncamiento = [error_truncamiento_T;error_truncamiento_S13;error_truncamiento_S38];
    t=table(metodos,integrales,Error_Absoluto,Error_Relativo,Error_Truncamiento);
end
if(mod(n,2)~=0 && mod(n,3)~=0)
    metodos = {'Metodo Trepecio'};
    integrales = [I_Trapecio];
    Error_Absoluto = [error_absoluto_T];
    Error_Relativo = [error_relativo_T];
    Error_Truncamiento = [error_truncamiento_T];
    t=table(metodos,integrales,Error_Absoluto,Error_Relativo,Error_Truncamiento);
end
fprintf('\n');
disp(t);

end