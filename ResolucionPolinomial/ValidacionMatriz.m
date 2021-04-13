function [n,aux]=ValidacionMatriz(A)

syms v1;
syms v2;
syms v3;
syms v4;
syms y1;

v1=0;%variable dependiente 1
v2=0;%variable dependiente 2
v3=0;%variable dependiente 3
v4=0;%variable dependiente 4
y1=0;%termino independiente


[m,n]=size(A);%reservando el tama?o de la matriz del excel

if(n==2)
    ValorY=[A(1:m)];%guardando el valor de cada columna del excel
    ValorX1=[A((m+1):(2*m))];%guardando el valor de cada columna del excel
    Valor_xy=isnan(ValorY);%valida si existen los datos con "1"(verdadero) y si no existen con"0"(falso)
    Valor_x1=isnan(ValorX1);%valida si existen los datos con "1"(verdadero) y si no existen con"0"(falso)
    
    if(sum(Valor_xy)>0)%valida si existen los valores en y
        y1=0;
        disp('Se necesita valores de Y para continuar');
    else
        y1=1;
        if(sum(Valor_x1)>0)
            v1=0;
            disp('Se necesita valores de X1 para continuar');
        else
            v1=1;
            disp('Se ingreso una variable');
        end
    end
end

if(n==3)
    ValorY=[A(1:m)];%guardando el valor de cada columna del excel
    ValorX1=[A((m+1):(2*m))];%guardando el valor de cada columna del excel
    ValorX2=[A((2*m+1):(3*m))];%guardando el valor de cada columna del excel
    Valor_x1=isnan(ValorX1);%valida si existen los datos con "1"(verdadero) y si no existen con"0"(falso)
Valor_x2=isnan(ValorX2);%valida si existen los datos con "1"(verdadero) y si no existen con"0"(falso)
Valor_xy=isnan(ValorY);%valida si existen los datos con "1"(verdadero) y si no existen con"0"(falso)


    if(sum(Valor_xy)>0)%valida si existen los valores en y
        y1=0;
        disp('Se necesita valores de Y para continuar');
    else
        y1=1;
        if(sum(Valor_x1)>0)
            v1=0;
            disp('Se necesita valores de X1 para continuar');
        else
            v1=1;
            if(sum(Valor_x2)>0)
                v2=0;
            else
                v2=1;
                disp('Se ingreso dos variables');
            end
        end
    end


end

if(n==4)
ValorY=[A(1:m)];%guardando el valor de cada columna del excel
ValorX1=[A((m+1):(2*m))];%guardando el valor de cada columna del excel
ValorX2=[A((2*m+1):(3*m))];%guardando el valor de cada columna del excel
ValorX3=[A((3*m+1):(4*m))];%guardando el valor de cada columna del excel

    Valor_x1=isnan(ValorX1);%valida si existen los datos con "1"(verdadero) y si no existen con"0"(falso)
Valor_x2=isnan(ValorX2);%valida si existen los datos con "1"(verdadero) y si no existen con"0"(falso)
Valor_x3=isnan(ValorX3);%valida si existen los datos con "1"(verdadero) y si no existen con"0"(falso)
Valor_xy=isnan(ValorY);%valida si existen los datos con "1"(verdadero) y si no existen con"0"(falso)


    if(sum(Valor_xy)>0)%valida si existen los valores en y
        y1=0;
        disp('Se necesita valores de Y para continuar');
    else
        y1=1;
        if(sum(Valor_x1)>0)
            v1=0;
            disp('Se necesita valores de X1 para continuar');
        else
            v1=1;
            if(sum(Valor_x2)>0)
                v2=0;
                disp('Se ingreso una variable');
            else
                v2=1;
                if(sum(Valor_x3)>0)
                    v3=0;
                else
                    v3=1;
                    disp('Se ingreso tres variables');
                end
            end
        end
    end




end

if(n==5)
ValorY=[A(1:m)];%guardando el valor de cada columna del excel
ValorX1=[A((m+1):(2*m))];%guardando el valor de cada columna del excel
ValorX2=[A((2*m+1):(3*m))];%guardando el valor de cada columna del excel
ValorX3=[A((3*m+1):(4*m))];%guardando el valor de cada columna del excel
ValorX4=[A((4*m+1):(5*m))];%guardando el valor de cada columna del excel

    Valor_x1=isnan(ValorX1);%valida si existen los datos con "1"(verdadero) y si no existen con"0"(falso)
Valor_x2=isnan(ValorX2);%valida si existen los datos con "1"(verdadero) y si no existen con"0"(falso)
Valor_xy=isnan(ValorY);%valida si existen los datos con "1"(verdadero) y si no existen con"0"(falso)
Valor_x4=isnan(ValorX4);%valida si existen los datos con "1"(verdadero) y si no existen con"0"(falso)
Valor_x3=isnan(ValorX3);%valida si existen los datos con "1"(verdadero) y si no existen con"0"(falso)



    if(sum(Valor_xy)>0)%valida si existen los valores en y
        y1=0;
        disp('Se necesita valores de Y para continuar');
    else
        y1=1;
        if(sum(Valor_x1)>0)
            v1=0;
            disp('Se necesita valores de X1 para continuar');
        else
            v1=1;
            if(sum(Valor_x2)>0)
                v2=0;
                disp('Se ingreso una variable');
            else
                v2=1;
                if(sum(Valor_x3)>0)
                    v3=0;
                    disp('Se ingreso dos variables');
                else
                    v3=1;
                    if(sum(Valor_x4)>0)
                        v4=0;
                    else
                        v4=1;
                        disp('Se ingreso 4 variables');
                    end
                end
            end
        end
    end

end


disp('Datos leidos de Excel EXITOSAMENTE...!');
if((y1==1)&&(v1==1)&&(v2==0)&&(v3==0)&&(v4==0))%verifica si tiene solo una variable
    disp('La matriz a operar es la siguiente : ');
    MATRIZ=[ValorY; ValorX1]';%genera la matriz con los valores del excel
    disp(MATRIZ);
    n=input('->Ingrese el orden "n" :  ');%ingresa el orden de la funcion
    while((isempty(n))||(n<0))%verifica que n exista y que sea positivo
    disp('El valor ingresado no es valido ingrese un numero entero positivo hasta 4No ha ingresado el valor de n');
    n=input('Ingrese la n: ');%ingresa el orden de la funcion hasta que la condicion se cumpla
    end
    aux=1;%auxiliar para ver en que modulo esta dependiendo de las variables
end
if((y1==1)&&(v1==1)&&(v2==1)&&(v3==0)&&(v4==0))%verifica si tiene 2 variables
    disp('La matriz a operar es la siguiente con dos variables : ');
    MATRIZ=[ ValorY; ValorX1; ValorX2]';%genera la matriz con los valores del excel
    disp(MATRIZ);
    n=input('->Ingrese el orden  :  ');%ingresa el orden de la funcion
    while((isempty(n))||(n<0))%verifica que n exista y que sea positivo
    disp('El valor ingresado no es valido ingrese un numero entero positivo hasta 4');
    n=input('Ingrese la n: ');%ingresa el orden de la funcion hasta que la condicion se cumpla
    end
    aux=2;%auxiliar para ver en que modulo esta dependiendo de las variables
end
if((y1==1)&&(v1==1)&&(v2==1)&&(v3==1)&&(v4==0))%verifica si tiene 3 variables
    disp('La matriz a operar es la siguiente : ');
    MATRIZ=[ValorY; ValorX1; ValorX2; ValorX3]';%genera la matriz con los valores del excel
    disp(MATRIZ);
    n=input('->Ingrese el orden  :  ');%ingresa el orden de la funcion
    while((isempty(n))||(n<0))%verifica que n exista y que sea positivo
    disp('El valor ingresado no es valido ingrese un numero entero positivo hasta 4');
    n=input('Ingrese la n: ');%ingresa el orden de la funcion hasta que la condicion se cumpla
    end
    aux=3;%auxiliar para ver en que modulo esta dependiendo de las variables
end
if((y1==1)&&(v1==1)&&(v2==1)&&(v3==1)&&(v4==1))%verifica si tiene 3 variables
    disp('La matriz a operar es la siguiente : ');
    MATRIZ=[ ValorY; ValorX1; ValorX2; ValorX3; ValorX4]';%genera la matriz con los valores del excel
    disp(MATRIZ);
    n=input('->Ingrese el orden  :  ');%ingresa el orden de la funcion
    while((isempty(n))||(n<0))%verifica que n exista y que sea positivo
    disp('El valor ingresado no es valido ingrese un numero entero positivo hasta 4');
    n=input('Ingrese la n: ');%ingresa el orden de la funcion hasta que la condicion se cumpla
    end
    aux=4;%auxiliar para ver en que modulo esta dependiendo de las variables
end

end