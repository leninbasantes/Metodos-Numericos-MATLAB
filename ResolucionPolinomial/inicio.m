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
    disp('Cargando datos de Excel ......');
    A= xlsread('Datos');%se importan los datos de la tabla del excel 
    [n,v]=ValidacionMatriz(A);%se llama a la funcion para validar la matriz
    [M,n,v]=ParaProbar(A,n,v);
    ResolucionPolinomica(A,M,n,v);
else
    disp('Para continuar se debe importar, Gracias usted esta saliendo');
end