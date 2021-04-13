function [M,ene,numerova]=ParaProbar(A,ene,v)
[m,n]=size(A);%Sacamos la dimencion de la matriz original ingresada esto para poder operar segun los casos que se nos presente
M=(1:1);%Generamos una nueva matriz, donde guardaremos las operaciones de las sumatorias que se realizan a partir de la matriz A
M(1,1)=m;%N viene dado por el numero de filas de la matriz de los puntos que se ingresan, colocamos ese valor en nuestra tabla de operaciones de sumatoria

ValorY=[A(1:m)];%Guardamos todos los valores de Y
Y=[ValorY];%Guardamos en un arreglo llamado Y

if(v==1)%Condicionamos para que pueda inicializar y obtener los valores segun el numero de variables, traemos la variable "v" que nos identifica cuantas variables existen
ValorX1=[A((m+1):(2*m))];%En este caso como es una variable obtenemos solo la columna que viene dado por "A((m+1):(2*m))" con esto podremos hacerder a todas las X_1
C=[ValorX1];%Ese valor obtenido en un arreglo ValorX1 lo guardamos en un arreglo C donde operaramos en forma general
end
if(v==2)%Condicionamos para que pueda inicializar y obtener los valores segun el numero de variables, traemos la variable "v" que nos identifica cuantas variables existen
ValorX1=[A((m+1):(2*m))];%En este caso como tenemos dos variable tenemos que escojer dos columnas de la matriz que viene dado por x1 x2
ValorX2=[A((2*m+1):(3*m))];
C=[ValorX1 ValorX2];%Ese valor lo guardamos en un arreglo C donde vamos a operar de forma general 
end
if(v==3)%Condicionamos para que pueda inicializar y obtener los valores segun el numero de variables, traemos la variable "v" que nos identifica cuantas variables existen
ValorX1=[A((m+1):(2*m))];%En este caso como son 3 variables tenemos que escojer 3 columnas para optener los puntos y guardarlos en arreglos 
ValorX2=[A((2*m+1):(3*m))];
ValorX3=[A((3*m+1):(4*m))];
C=[ValorX1 ValorX2 ValorX3];%Se guarda en un arreglo los puntos obtenidos previamente
end
if(v==4)%Condicionamos para que pueda inicializar y obtener los valores segun el numero de variables, traemos la variable "v" que nos identifica cuantas variables existen
ValorX1=[A((m+1):(2*m))];%En este caso como obtenemos 4 variables tenemos que esscojer 3 columnas 
ValorX2=[A((2*m+1):(3*m))];
ValorX3=[A((3*m+1):(4*m))];
ValorX4=[A((4*m+1):(5*m))];
C=[ValorX1 ValorX2 ValorX3 ValorX4];%Guardamos en un arreglo los valores obtenidos
end

%-------------Operacion de sumatorias para generar la tabla MATRIZ---------
numerova=v;%Declaramos una variable donde guardara el numero de variables que obtuvimos del excel
enesima=ene;%Declaramos una variable donde se guardara el numero de grado
%Para poder llenar la tabla vamos a generar la sumatoria de los valores de
%la primera fila con los de la columna 
var=2;
for j=1:1:(enesima)
    for i=0:1:(numerova-1)
    h=((i*m)+1);
    f=((i+1)*m);
    M(1,(var))=sum(C(h:f).^j);
    M((var),1)=sum(C(h:f).^j);
    var=var+1;
    end
end

%Creamos sentecias para poder generar la operacion de los valores obtenidos
%previamente operando los valores entre fila y columna y sacando la
%sumatoria de los mismo 

[f,c]=size(M);
var=1;
p=1;
hasta=numerova;

for j=0:1:numerova
    for i=p:1:(hasta-1)
        h=((j*m)+1);f=((j+1)*m);
        v=((i*m)+1);z=((i+1)*m);
        M(1,(c+var))=sum(C(h:f).*C(v:z));
        M((c+var),1)=sum(C(h:f).*C(v:z));
        var=var+1;
    end
    p=p+1;
end

%Hacer sentencias para poder obtener la operaciones de y por la primera
%columna

[f2,c2]=size(M);
M(1,(c2+1))=sum(Y(1:m));
aux3=2;
verificador=1;
for j=1:1:enesima
    for i=0:1:(numerova-1)
        h=((i*m)+1);f=((i+1)*m);  
        M((aux3),(c2+1))=sum(Y(1:m).*C(h:f).^j);
        aux3=aux3+1;
        verificador=verificador+1;
    end
end

%Creamos una sentencia cuando es multiplicado 2 terminos con otro y asi
%poder agregarlo a la trabla 

p1=1;
for j=0:1:numerova
    for i=p1:1:(hasta-1)
        h=((j*m)+1);f=((j+1)*m);
        v=((i*m)+1);z=((i+1)*m);
        M((verificador+1),(c2+1))=sum(Y(1:m).*C(h:f).*C(v:z));
        verificador=verificador+1;
    end
    p1=p1+1;
end

%Creamos sentencia para poder operar terminos que esten elevados a n y irle
%agregando a la tabla en el orden que corresponda

ca=1;
for p=1:1:enesima
    for k=1:1:numerova
        ca=ca+1;
        sq=2;
        for j=1:1:enesima
            for i=1:1:numerova
                h=(((k-1)*m)+1);f=(((k-1)+1)*m);
                v=(((i-1)*m)+1);z=(((i)-1+1)*m);
                M(sq,ca)=sum((C(h:f).^p).*(C(v:z).^j));
                sq=sq+1;
            end
        end
    end
end

%Creamos sentencias para obtener el resultado cuando se operan 3 terminos y
%que vayan guardando en la matriz general de resultado que es M

ca=(((numerova*enesima)+2)-1);
p2=2;
for p=1:1:(numerova-1)
    for k=p2:1:numerova
        ca=ca+1;
        sq=2;
        for j=1:1:enesima
            for i=1:1:numerova
                v=(((i-1)*m)+1);z=(((i-1)+1)*m);
                h=(((k-1)*m)+1);f=(((k-1)+1)*m);
                h1=(((p-1)*m)+1);f1=(((p-1)+1)*m);
                M(sq,ca)=sum((C(h1:f1)).*(C(h:f)).*(C(v:z).^j));
                M(ca,sq)=sum((C(h1:f1)).*(C(h:f)).*(C(v:z).^j));
                sq=sq+1;
            end
        end
        
    end
    p2=p2+1;
end

%Generamos sentencias para poder guardar la operacion de 4 terminos para
%poder asi terminar con la totalidad de la matriz M

p2=2;
ca=(((numerova*enesima)+2)-1);
for p=1:1:(numerova-1)
     for k=p2:1:(numerova)
         ca=ca+1;
         sq=((numerova*enesima)+2);
         j2=2;
         for j=1:1:(numerova-1)
             for i=j2:1:(numerova)
                f=(((i-1)*m)+1);c=(((i-1)+1)*m);
                f1=(((j-1)*m)+1);c1=(((j-1)+1)*m);
                f2=(((k-1)*m)+1);c2=(((k-1)+1)*m);
                f3=(((p-1)*m)+1);c3=(((p-1)+1)*m);
                M(sq,ca)=sum((C(f3:c3)).*(C(f2:c2)).*(C(f1:c1)).*(C(f:c)));
                M(ca,sq)=sum((C(f3:c3)).*(C(f2:c2)).*(C(f1:c1)).*(C(f:c)));
                sq=sq+1;
             end
             j2=j2+1;
         end
     end
     p2=p2+1;
end

end