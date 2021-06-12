function Bisecccion
clc;
syms x;
funcion=input('Ingrese f(x,y): ');%Se pide al usuario el ingreso de la funcion 
intervalo=input('Ingrese el intevalo: ');%Se pide al usuario que ingrese el intervalo
tolerancia=input('Ingrese la tolerancia: ');%Se pide que se ingrese una tolerancia
inf(1)=intervalo(1);%Guardamos en un arreglo los valores de los intervalor, en este caso el inferior
sup(1)=intervalo(2);%Se guarda el valor del intervalo superior en este arreglo
formatSpec1 = '\n[Iteracion] [Intervalo Inferior]               [Intervalo Superior]         [Punto Medio]           [F(intervalo inferior)] [F(intervalo superior)] [F(intervalo medio)]      [Error]      \n';
formatSpec2 = '[%d]             (%f)                    (%f)                   (%f)                      (%f)                %f            %f            %f\n';
formatSpec3 = '[%d]             (%f)                    (%f)                   (%f)         \n';
fprintf(formatSpec1);

for i=1:1:1%Realizamos un proceso para lo que solo tendra los intervalos ingresados y la media calculada
    X(i+1)=((inf(i)+sup(i))/2);
    fin(i)=subs(funcion,x,inf(i));
    fsup(i)=subs(funcion,x,sup(i));
    fmedia(i)=subs(funcion,x,X(i+1));
    if((fin(i)*fmedia(i))<0)
        inf(i+1)=inf(i);
        sup(i+1)=X(i+1);
    else
        inf(i+1)=X(i+1);
        sup(i+1)=sup(i);
    end
    fprintf(formatSpec3,i-1,inf(i),sup(i),X(i+1));
end

for i=2:1:99999%Se realiza la iteraciones, hasta que cumpla con el menor de tolerancia indicado
    X(i+1)=((inf(i)+sup(i))/2);
    fin(i)=subs(funcion,x,inf(i));
    fsup(i)=subs(funcion,x,sup(i));
    fmedia(i)=subs(funcion,x,X(i+1));
    error(i)=abs((X(i)-X(i+1))/X(i))*100;
    fprintf(formatSpec2,i-1,inf(i),sup(i),X(i+1),fin(i),fsup(i),fmedia(i),error(i));
    if(abs(error(i))<=tolerancia)%Condicional para que el programa salte al llegar a la condicion de tolerancia
            break;
    end
    if((fin(i)*fmedia(i))<0)
        inf(i+1)=inf(i);
        sup(i+1)=X(i+1);
    else
        inf(i+1)=X(i+1);
        sup(i+1)=sup(i);
    end
    
end


end