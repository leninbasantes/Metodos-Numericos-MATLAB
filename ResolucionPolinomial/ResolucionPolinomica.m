function ResolucionPolinomica(A,M,enesima,v)
[m,n]=size(A);
syms X_1;
syms X_2;
syms X_3;
syms X_4;


%Obtenemos los valores de cada calumna de la matriz segun el numero de
%variales que nos regresa en esta funcion

 ValorY=[A(1:m)];%guardando el valor de cada columna del excel
if(v==1)%Condicionamos para que pueda inicializar y obtener los valores segun el numero de variables, traemos la variable "v" que nos identifica cuantas variables existen
ValorX1=(A((m+1):(2*m)));%En este caso como es una variable obtenemos solo la columna que viene dado por "A((m+1):(2*m))" con esto podremos hacerder a todas las X_1
end
if(v==2)%Condicionamos para que pueda inicializar y obtener los valores segun el numero de variables, traemos la variable "v" que nos identifica cuantas variables existen
ValorX1=(A((m+1):(2*m)));%En este caso como tenemos dos variable tenemos que escojer dos columnas de la matriz que viene dado por x1 x2
ValorX2=(A((2*m+1):(3*m)));
end
if(v==3)%Condicionamos para que pueda inicializar y obtener los valores segun el numero de variables, traemos la variable "v" que nos identifica cuantas variables existen
ValorX1=(A((m+1):(2*m)));%En este caso como son 3 variables tenemos que escojer 3 columnas para optener los puntos y guardarlos en arreglos 
ValorX2=(A((2*m+1):(3*m)));
ValorX3=(A((3*m+1):(4*m)));
end
if(v==4)%Condicionamos para que pueda inicializar y obtener los valores segun el numero de variables, traemos la variable "v" que nos identifica cuantas variables existen
ValorX1=(A((m+1):(2*m)));%En este caso como obtenemos 4 variables tenemos que esscojer 3 columnas 
ValorX2=(A((2*m+1):(3*m)));
ValorX3=(A((3*m+1):(4*m)));
ValorX4=(A((4*m+1):(5*m)));
end


        if((enesima==1)&&(v==1))
        disp('Ta');    
        disp(M);
        R=rref(M);
        disp(R);
        F=[R(6) R(5)];
        [x y]=meshgrid(-5:10);
        y=(R(5)+ R(6).*x);
        x=linspace(-5,10,50);
        y=polyval(F,x);
        hold on
        plot(x,y,'r');
        plot(ValorX1,ValorY,'g*');
        hold off
        xlabel('Eje x');
        ylabel('Eje y');
        formatSpec = 'La ecuacion es Y=(%f) + (%f)*x\n';
        Y= R(5)+ R(6).*X_1;   %Ecuacion de Regresion obtenida
        y_t=ValorY.';       %Obtencion de datos para el calculo de error
        y_e=double(subs(Y,X_1,ValorX1).');    %Evaluar x en la ecuacion de regresion 
        Error=double(y_t-y_e);              %Calculo del error
        disp('   Tabla de errores')
        M=[y_t y_e Error];                  %Guardar todos los datos en una matriz e imprimir
        disp(M);
        fprintf(formatSpec,R(5),R(6));
        Y= R(5)+ R(6).*X_1;   %Ecuacion de Regresion obtenida
        y_t=ValorY.';       %Obtencion de datos para el calculo de error
        y_e=double(subs(Y,X_1,ValorX1).');    %Evaluar x en la ecuacion de regresion 
        Error=double(y_t-y_e);              %Calculo del error
        disp('   Tabla de errores')
        M=[y_t y_e Error];                  %Guardar todos los datos en una matriz e imprimir
        disp(M);
        CoeficienteCorrelacion(m,ValorY,ValorX1);   %Coeficiente de Correlacion;
        end
        
        
        if((enesima==1)&&(v==2))
        A1=(M(1));A5=(M(5));A9=(M(9));A17=(M(17));
        A2=(M(2));A6=(M(6));A10=(M(10));A18=(M(18));
        A3=(M(3));A7=(M(7));A11=(M(11));A19=(M(19));
        MATRIX=[A1 A5 A9 A17; A2 A6 A10 A18; A3 A7 A11 A19];
        disp(MATRIX);
        R=rref(MATRIX);
        disp(R);
        F=[R(10) R(11) R(12)];
        [x,y]=meshgrid(-5:0.5:10);
        z=(R(10)+R(11)*x+R(12)*y);
        surf(x,y,z);
        hold on
        plot3(ValorX1,ValorX2,ValorY,'ro')
        title('Sistema lineal en R3')
        xlabel('Eje x')
        ylabel('Eje y')
        zlabel('Eje z')
        Y=R(10)+R(11).*X_1+R(12).*X_2;
        y_t=ValorY.';       %Obtencion de datos para el calculo de error
        y_e=subs(Y,X_1,ValorX1);    %Evaluar x_1 en la ecuacion de regresion
        for i=1:m
            y_e(i)=subs(y_e(i),X_2,ValorX2(i));
        end
        y_e=double(y_e.');    %Evaluar x en la ecuacion de regresion 
        Error=double(y_t-y_e);              %Calculo del error
        disp('   Tabla de errores')
        M=[y_t y_e Error];                  %Guardar todos los datos en una matriz e imprimir
        disp(M);
        formatSpec = 'La ecuacion es Z=(%f) + (%f)*x + (%f)*y\n';
        fprintf(formatSpec,R(10),R(11),R(12));
        CoeficienteCorrelacion(m,ValorY,ValorX1,ValorX2);   %Coeficiente de Correlacion;
        end
        
        if((enesima==1)&&(v==3))
        A1=(M(1));A5=(M(8));A9=(M(15));A17=(M(22));A21=(M(49));
        A2=(M(2));A6=(M(9));A10=(M(16));A18=(M(23));A22=(M(50));
        A3=(M(3));A7=(M(10));A11=(M(17));A19=(M(24));A23=(M(51));
        A4=(M(4));A8=(M(11));A12=(M(18));A20=(M(25));A24=(M(52));
        MATRIX=[A1 A5 A9 A17 A21; A2 A6 A10 A18 A22; A3 A7 A11 A19 A23; A4 A8 A12 A20 A24];
        disp(MATRIX);
        R=rref(MATRIX);
        disp(R);
        formatSpec = 'La ecuacion es K=(%f) + (%f)*x + (%f)*y + (%f)*z\n';
        Y=R(17)+R(18).*X_1+R(19).*X_2+R(20).*X_3;
        y_t=ValorY.';       %Obtencion de datos para el calculo de error
        y_e=subs(Y,X_1,ValorX1);    %Evaluar x_1 en la ecuacion de regresion
        for i=1:m
            y_e(i)=subs(y_e(i),X_2,ValorX2(i));
            y_e(i)=subs(y_e(i),X_3,ValorX3(i));
        end
        y_e=double(y_e.');    %Evaluar x en la ecuacion de regresion 
        Error=double(y_t-y_e);              %Calculo del error
        disp('   Tabla de errores')
        M=[y_t y_e Error];                  %Guardar todos los datos en una matriz e imprimir
        disp(M);
        fprintf(formatSpec,R(17),R(18),R(19),R(20)); 
        CoeficienteCorrelacion(m,ValorY,ValorX1,ValorX2,ValorX3);   %Coeficiente de Correlacion;
        end
        
        if((enesima==1)&&(v==4))
        A1=(M(1));A5=(M(8));A9=(M(15));A17=(M(22));A21=(M(49));A31=(M(122));
        A2=(M(2));A6=(M(9));A10=(M(16));A18=(M(23));A22=(M(50));A32=(M(123));
        A3=(M(3));A7=(M(10));A11=(M(17));A19=(M(24));A23=(M(51));A33=(M(124));
        A4=(M(4));A8=(M(11));A12=(M(18));A20=(M(25));A24=(M(52));A34=(M(125));
        A25=(M(5));A26=(M(12));A27=(M(19));A28=(M(26));A29=(M(53));A30=(M(126));
        MATRIX=[A1 A5 A9 A17 A21 A31; A2 A6 A10 A18 A22 A32; A3 A7 A11 A19 A23 A33; A4 A8 A12 A20 A24 A34; A25 A26 A27 A28 A29 A30 ];
        disp(MATRIX);
        R=rref(MATRIX);
        disp(R);
        formatSpec = 'La ecuacion es G=(%f) + (%f)*x + (%f)*y + (%f)*z + (%f)*k\n';
        Y = R(26)+R(27).*X_1+R(28).*X_2+R(29).*X_3+R(30).*X_4;
        y_t=ValorY.';       %Obtencion de datos para el calculo de error
        y_e=subs(Y,X_1,ValorX1);    %Evaluar x_1 en la ecuacion de regresion
        for i=1:m
            y_e(i)=subs(y_e(i),X_2,ValorX2(i));
            y_e(i)=subs(y_e(i),X_3,ValorX3(i));
            y_e(i)=subs(y_e(i),X_4,ValorX4(i));
        end
        y_e=double(y_e.');    %Evaluar x en la ecuacion de regresion 
        Error=double(y_t-y_e);              %Calculo del error
        disp('   Tabla de errores')
        M=[y_t y_e Error];                  %Guardar todos los datos en una matriz e imprimir
        disp(M);
        fprintf(formatSpec,R(26),R(27),R(28),R(29),R(30));
        CoeficienteCorrelacion(m,ValorY,ValorX1,ValorX2,ValorX3,ValorX4);   %Coeficiente de Correlacion;
        end
        
        if((enesima==2)&&(v==1))
        disp(M);
        R=rref(M);
        disp(R);
        F=[R(12) R(11) R(10)];
        [x y]=meshgrid(-5:10);
        y=(R(10)+ R(11).*x + R(12).*x^2);
        x=linspace(-5,10,50);
        y=polyval(F,x);
        hold on
        plot(x,y,'r');
        plot(ValorX1,ValorY,'g*');
        hold off
        xlabel('Eje x');
        ylabel('Eje y');
        formatSpec = 'La ecuacion es Y=(%f) + (%f)*x + (%f)*x^2\n';
        fprintf(formatSpec,R(10),R(11),R(12)); 
        Y= R(10)+ R(11).*X_1+R(12).*(X_1)^2;   %Ecuacion de Regresion obtenida
        y_t=ValorY.';       %Obtencion de datos para el calculo de error
        y_e=double(subs(Y,X_1,ValorX1).');    %Evaluar x en la ecuacion de regresion 
        Error=double(y_t-y_e);              %Calculo del error
        disp('   Tabla de errores')
        M=[y_t y_e Error];                  %Guardar todos los datos en una matriz e imprimir
        disp(M);
        CoeficienteCorrelacion(m,ValorY,ValorX1);   %Coeficiente de Correlacion;
        end
        
        if((enesima==2)&&(v==2))
        disp(M);
        R=rref(M);
        disp(R);
        
         F=[R(42) R(41) R(40) R(39) R(38) R(37)];
         
        [x,y]=meshgrid(-5:0.5:10);
        z=(R(37)+ R(38)*x + R(39)*x.^2 + R(40)*y + R(41)*y.^2 + R(42)*y*x);
        surf(x,y,z);
        
        hold on
        plot3(ValorX1,ValorX2,ValorY,'ro')
        title('Sistema lineal en R3')
        xlabel('Eje x')
        ylabel('Eje y')
        zlabel('Eje z')
        hold off
        formatSpec = 'La ecuacion es Z=(%f) + (%f)*x_1 + (%f)*x^2 + (%f)*y + (%f)*y^2 + (%f)*xy\n';
        fprintf(formatSpec,R(37),R(38),R(39),R(40),R(41),R(42));  
        Y=R(37)+ R(38).*X_1+ R(39).*X_2+R(40).*((X_1)^2)+R(41).*((X_2)^2)+R(42).*(X_1).*(X_2);
        y_t=ValorY.';       %Obtencion de datos para el calculo de error
        y_e=subs(Y,X_1,ValorX1);
        for i=1:m
            y_e(i)=subs(y_e(i),X_2,ValorX2(i));
        end
        y_e=double(y_e.');    %Evaluar x en la ecuacion de regresion 
        Error=double(y_t-y_e);              %Calculo del error
        disp('   Tabla de errores')
        M=[y_t y_e Error];                  %Guardar todos los datos en una matriz e imprimir
        disp(M);
        CoeficienteCorrelacion(m,ValorY,ValorX1,ValorX2);   %Coeficiente de Correlacion;
        end
        
        if((enesima==2)&&(v==3))
        disp(M);
        R=rref(M);
        disp(R);
%         F=[R(12) R(11) R(10)];
%        [x y]=meshgrid(-5:10);
%         y=(R(101)+ R(102).*x + R(103).*x^2 + R(104).*y +R(105).*y^2 + R(106).*z + R(107).*z^2 + R(108).*x.*y + R(109).*x.*z+R(110).*y.*z);
        formatSpec = 'La ecuacion es K=(%f) + (%f)*x + (%f)*x^2 + (%f)*y + (%f)*y^2 + (%f)*z + (%f)*z^2 + (%f)*xy + (%f)*xz + (%f)*yz\n';
        fprintf(formatSpec,R(101),R(102),R(103),R(104),R(105),R(106),R(107),R(108),R(109),R(110));   
        Y=R(101)+ R(102).*X_1 + R(103).*((X_1)^2) + R(104).*X_2 + R(105).*((X_2)^2) + R(106).*X_3 + R(107).*((X_3)^2) + R(108).*(X_1).*(X_2) + R(109).*(X_1).*(X_3) + R(110).*(X_2).*(X_3);
        y_t=ValorY.';       %Obtencion de datos para el calculo de error
        y_e=subs(Y,X_1,ValorX1);    %Evaluar x_1 en la ecuacion de regresion
        for i=1:m
            y_e(i)=subs(y_e(i),X_2,ValorX2(i));
            y_e(i)=subs(y_e(i),X_3,ValorX3(i));
        end
        y_e=double(y_e.');    %Evaluar x en la ecuacion de regresion 
        Error=double(y_t-y_e);              %Calculo del error
        disp('   Tabla de errores')
        M=[y_t y_e Error];                  %Guardar todos los datos en una matriz e imprimir
        disp(M);
        CoeficienteCorrelacion(m,ValorY,ValorX1,ValorX2,ValorX3);   %Coeficiente de Correlacion;
        end  
        
        if((enesima==2)&&(v==4))
        disp(M);
        R=rref(M);
        disp(R);
%         F=[R(12) R(11) R(10)];
%        [x y]=meshgrid(-5:10);
%         y=(R(101)+ R(102).*x + R(103).*x^2 + R(104).*y +R(105).*y^2 + R(106).*z + R(107).*z^2 + R(108).*x.*y + R(109).*x.*z+R(110).*y.*z);
        formatSpec = 'La ecuacion es K=(%f) + (%f)*x + (%f)*x^2 + (%f)*y + (%f)*y^2 + (%f)*z + (%f)*z^2 + (%f)*k + (%f)*k^2 + (%f)*xy + (%f)*xz + (%f)*xk + (%f)*yz + (%f)*yk + (%f)*zk\n';
        fprintf(formatSpec,R(226),R(227),R(228),R(229),R(230),R(231),R(232),R(233),R(234),R(235),R(236),R(237),R(238),R(239),R(240));   
        Y = R(226) + R(227).*X_1 + R(228).*((X_1)^2) + R(229).*X_2 + R(230).*((X_2)^2) + R(231).*X_3 + R(232).*((X_3)^2) + R(233).*X_4 + R(234).*((X_4)^2) + R(235).*(X_1).*(X_2) + R(236).*(X_1).*(X_3) + R(237).*(X_1).*(X_4) + R(238).*(X_2).*(X_3) + R(239).*(X_2).*(X_4) + R(240).*(X_3).*(X_4);
        y_t=ValorY.';       %Obtencion de datos para el calculo de error
        y_e=subs(Y,X_1,ValorX1);    %Evaluar x_1 en la ecuacion de regresion
        for i=1:m
            y_e(i)=subs(y_e(i),X_2,ValorX2(i));
            y_e(i)=subs(y_e(i),X_3,ValorX3(i));
            y_e(i)=subs(y_e(i),X_4,ValorX4(i));
        end
        y_e=double(y_e.');    %Evaluar x en la ecuacion de regresion 
        Error=double(y_t-y_e);              %Calculo del error
        disp('   Tabla de errores')
        M=[y_t y_e Error];                  %Guardar todos los datos en una matriz e imprimir
        disp(M);
        CoeficienteCorrelacion(m,ValorY,ValorX1,ValorX2,ValorX3,ValorX4);   %Coeficiente de Correlacion;
        end 
        
        if((enesima==3)&&(v==1))
        disp(M);
        R=rref(M);
        disp(R);
        F=[R(20) R(19) R(18) R(17)];
        [x y]=meshgrid(-5:10);
        y=(R(17)+ R(18).*x + R(19).*x^2 + R(20).*x^3);
        x=linspace(-5,10,50);
        y=polyval(F,x);
        hold on
        plot(x,y,'r');
        plot(ValorX1,ValorY,'g*');
        hold off
        xlabel('Eje x');
        ylabel('Eje y');
        formatSpec = 'La ecuacion es Y=(%f) + (%f)*x + (%f)*x^2 + (%f)*x^3\n';
        fprintf(formatSpec,R(17),R(18),R(19),R(20));
        Y= R(17)+ R(18).*X_1 + R(19).*(X_1)^2 + R(20).*(X_1)^3;   %Ecuacion de Regresion obtenida
        y_t=ValorY.';       %Obtencion de datos para el calculo de error
        y_e=double(subs(Y,X_1,ValorX1).');    %Evaluar x en la ecuacion de regresion
        disp(y_e);
        Error=double(y_t-y_e);              %Calculo del error
        disp('   Tabla de errores')
        M=[y_t y_e Error];                  %Guardar todos los datos en una matriz e imprimir
        disp(M);
        CoeficienteCorrelacion(m,ValorY,ValorX1);   %Coeficiente de Correlacion;
        end 
        
        if((enesima==3)&&(v==2))
        disp(M);
        R=rref(M);
        disp(R);
%         F=[R() R() R()];
%         [x y]=meshgrid(-5:10);
%         y=(R(37)+ R(38).*x + R(39).*x^2 + R(40).*y +R(41).*y^2 + R(42).*x.*y);

        formatSpec = 'La ecuacion es Z=(%f) + (%f)*x + (%f)*x^2 + (%f)*x^3 + (%f)*y + (%f)*y^2 + (%f)*y^3 + (%f)*xy\n';
        fprintf(formatSpec,R(65),R(66),R(67),R(68),R(69),R(70),R(71),R(72));
        Y=R(65) + R(66).*X_1 + R(67).*((X_1)^2) + R(68).*((X_1)^3) + R(69).*X_2 + R(70).*((X_2)^2) + R(71).*((X_2)^3) + R(72).*(X_1).*(X_2);
        y_t=ValorY.';       %Obtencion de datos para el calculo de error
        y_e=subs(Y,X_1,ValorX1);    %Evaluar x_1 en la ecuacion de regresion
        for i=1:m
            y_e(i)=subs(y_e(i),X_2,ValorX2(i));
        end
        y_e=double(y_e.');    %Evaluar x en la ecuacion de regresion 
        Error=double(y_t-y_e);              %Calculo del error
        disp('   Tabla de errores')
        M=[y_t y_e Error];                  %Guardar todos los datos en una matriz e imprimir
        disp(M);
        CoeficienteCorrelacion(m,ValorY,ValorX1,ValorX2);   %Coeficiente de Correlacion;
        end
        
        %%%%%000000000000000000000000000000000000000000000000000000000
        
        if((enesima==3)&&(v==3))
        disp(M);
        R=rref(M);
        disp(R);
%         F=[R(12) R(11) R(10)];
%        [x y]=meshgrid(-5:10);
%         y=(R(101)+ R(102).*x + R(103).*x^2 + R(104).*y +R(105).*y^2 + R(106).*z + R(107).*z^2 + R(108).*x.*y + R(109).*x.*z+R(110).*y.*z);
        formatSpec = 'La ecuacion es K=(%f) + (%f)*x + (%f)*x^2 + (%f)*x^3 + (%f)*y + (%f)*y^2 + (%f)*y^3 + (%f)*z + (%f)*z^2 + (%f)*z^3 + (%f)*xy + (%f)*xz + (%f)*yz\n';
        fprintf(formatSpec,R(170),R(171),R(172),R(173),R(174),R(175),R(176),R(177),R(178),R(179),R(180),R(181),R(182));   
        Y=R(170) + R(171).*X_1 + R(172).*((X_1)^2) + R(173).*((X_1)^3) + R(174).*X_2 + R(175).*((X_2)^2) + R(176).*((X_2)^3) + R(177).*X_3 + R(178).*((X_3)^2) + R(179).*((X_3)^3) + R(180).*(X_1).*(X_2) + R(181).*(X_1).*(X_3) + R(182).*(X_2).*(X_3);
        y_t=ValorY.';       %Obtencion de datos para el calculo de error
        y_e=subs(Y,X_1,ValorX1);    %Evaluar x_1 en la ecuacion de regresion
        for i=1:m
            y_e(i)=subs(y_e(i),X_2,ValorX2(i));
            y_e(i)=subs(y_e(i),X_3,ValorX3(i));
        end
        y_e=double(y_e.');    %Evaluar x en la ecuacion de regresion 
        Error=double(y_t-y_e);              %Calculo del error
        disp('   Tabla de errores')
        M=[y_t y_e Error];                  %Guardar todos los datos en una matriz e imprimir
        disp(M);
        CoeficienteCorrelacion(m,ValorY,ValorX1,ValorX2,ValorX3);   %Coeficiente de Correlacion;
        
        end  
        
        if((enesima==3)&&(v==4))
        disp(M);
        R=rref(M);
        disp(R);
%         F=[R(12) R(11) R(10)];
%        [x y]=meshgrid(-5:10);
%         y=(R(101)+ R(102).*x + R(103).*x^2 + R(104).*y +R(105).*y^2 + R(106).*z + R(107).*z^2 + R(108).*x.*y + R(109).*x.*z+R(110).*y.*z);
        formatSpec = 'La ecuacion es G=(%f) + (%f)*x + (%f)*x^2 + (%f)*x^3 + (%f)*y + (%f)*y^2 + (%f)*y^3 + (%f)*z + (%f)*z^2 + (%f)*z^3 + (%f)*k + (%f)*k^2 + (%f)*k^3 + (%f)*xy + (%f)*xz + (%f)*xk + (%f)*yz + (%f)*yk + (%f)*zk\n';
        fprintf(formatSpec,R(362),R(363),R(364),R(365),R(366),R(367),R(368),R(369),R(370),R(371),R(372),R(373),R(374),R(375),R(376),R(377),R(378),R(379),R(380));   
        Y = R(362) + R(363).*X_1 + R(364).*((X_1)^2) + R(365).*((X_1)^3) + R(366).*X_2 + R(367).*((X_2)^2) + R(368).*((X_2)^3) + R(369).*X_3 + R(370).*((X_3)^2) + R(371).*((X_3)^3) + R(372).*X_4 + R(373).*((X_4)^2) + R(374).*((X_4)^3) + R(375).*(X_1).*(X_2) + R(376).*(X_1).*(X_3) + R(377).*(X_1).*(X_4) + R(378).*(X_2).*(X_3) + R(379).*(X_2).*(X_4) + R(380).*(X_3).*(X_4);
        y_t=ValorY.';       %Obtencion de datos para el calculo de error
        y_e=subs(Y,X_1,ValorX1);    %Evaluar x_1 en la ecuacion de regresion
        for i=1:m
            y_e(i)=subs(y_e(i),X_2,ValorX2(i));
            y_e(i)=subs(y_e(i),X_3,ValorX3(i));
            y_e(i)=subs(y_e(i),X_4,ValorX4(i));
        end
        y_e=double(y_e.');    %Evaluar x en la ecuacion de regresion 
        Error=double(y_t-y_e);              %Calculo del error
        disp('   Tabla de errores')
        M=[y_t y_e Error];                  %Guardar todos los datos en una matriz e imprimir
        disp(M);
        CoeficienteCorrelacion(m,ValorY,ValorX1,ValorX2,ValorX3,ValorX4);   %Coeficiente de Correlacion;
        end 
        
        if((enesima==4)&&(v==1))
        disp(M);
        R=rref(M);
        disp(R);
        F=[R(30) R(29) R(28) R(27) R(26)];
        [x y]=meshgrid(-5:10);
        y=(R(26)+ R(27).*x + R(28).*x^2 + R(29).*x^3 + R(30).*x^4);
        x=linspace(-5,10,50);
        y=polyval(F,x);
        hold on
        plot(x,y,'r');
        plot(ValorX1,ValorY,'g*');
        hold off
        xlabel('Eje x');
        ylabel('Eje y');
        formatSpec = 'La ecuacion es Y=(%f) + (%f)*x + (%f)*x^2 + (%f)*x^3 + (%f)*x^4\n';
        fprintf(formatSpec,R(26),R(27),R(28),R(29),R(30)); 
        Y= R(26) + R(27).*X_1 + R(28).*((X_1)^2) + R(29).*((X_1)^3) + R(30).*((X_1)^4);   %Ecuacion de Regresion obtenida
        y_t=ValorY.';       %Obtencion de datos para el calculo de error
        y_e=double(subs(Y,X_1,ValorX1).');    %Evaluar x en la ecuacion de regresion 
        Error=double(y_t-y_e);              %Calculo del error
        disp('   Tabla de errores')
        M=[y_t y_e Error];                  %Guardar todos los datos en una matriz e imprimir
        disp(M);
        CoeficienteCorrelacion(m,ValorY,ValorX1);   %Coeficiente de Correlacion;
        end 
        
        if((enesima==4)&&(v==2))
        disp(M);
%         ValorX2=[A((2*m+1):(3*m))];
%         ValorX1=[A((m+1):(2*m))];
%         ValorY=[A(1:m)];
        R=rref(M);
        disp(R);
%         F=[R() R() R()];
%         [x y]=meshgrid(-5:10);
%         y=(R(37)+ R(38).*x + R(39).*x^2 + R(40).*y +R(41).*y^2 + R(42).*x.*y);
        formatSpec = 'La ecuacion es Z=(%f) + (%f)*x + (%f)*x^2 + (%f)*x^3 + (%f)*x^4 + (%f)*y + (%f)*y^2 + (%f)*y^3 + (%f)*y^4 + (%f)*xy\n';
        fprintf(formatSpec,R(101),R(102),R(103),R(104),R(105),R(106),R(107),R(108),R(109),R(110));   
        Y=R(101) + R(102).*X_1 + R(103).*(X_1)^2 + R(104).*(X_1)^3 + R(105).*(X_1)^4 + R(106).*X_2 + R(107).*(X_2)^2 + R(108).*(X_2)^3 + R(109).*(X_2)^4 + R(110).*(X_1).*(X_2);
        y_t=ValorY.';       %Obtencion de datos para el calculo de error
        y_e=subs(Y,X_1,ValorX1);    %Evaluar x_1 en la ecuacion de regresion
        for i=1:m
            y_e(i)=subs(y_e(i),X_2,ValorX2(i));
        end
        y_e=double(y_e.');    %Evaluar x en la ecuacion de regresion 
        Error=double(y_t-y_e);              %Calculo del error
        disp('   Tabla de errores')
        M=[y_t y_e Error];                  %Guardar todos los datos en una matriz e imprimir
        disp(M);
        CoeficienteCorrelacion(m,ValorY,ValorX1,ValorX2);   %Coeficiente de Correlacion;
        end
        
        if((enesima==4)&&(v==3))
        disp(M);
        R=rref(M);
        disp(R);
%         F=[R(12) R(11) R(10)];
%        [x y]=meshgrid(-5:10);
%         y=(R(101)+ R(102).*x + R(103).*x^2 + R(104).*y +R(105).*y^2 + R(106).*z + R(107).*z^2 + R(108).*x.*y + R(109).*x.*z+R(110).*y.*z);
        formatSpec = 'La ecuacion es K=(%f) + (%f)*x + (%f)*x^2 + (%f)*x^3 + (%f)*x^4 + (%f)*y + (%f)*y^2 + (%f)*y^3 + (%f)*y^4 + (%f)*z + (%f)*z^2 + (%f)*z^3 + (%f).*z^4 + (%f)*xy + (%f)*xz + (%f)*yz\n';
        fprintf(formatSpec,R(257),R(258),R(259),R(260),R(261),R(262),R(263),R(264),R(265),R(266),R(267),R(268),R(269),R(270),R(271),R(272));   
        Y=R(257) + R(258).*X_1 + R(259).*((X_1)^2) + R(260).*((X_1)^3) + R(261).*((X_1)^4) + R(262).*X_2 + R(263).*((X_2)^2) + R(264).*((X_2)^3) + R(265).*((X_2)^4) + R(266).*(X_3) + R(267).*((X_3)^2) + R(268).*((X_3)^3) + R(269).*((X_3)^4) + R(270).*(X_1).*(X_2) + R(271).*(X_1).*(X_3) + R(272).*(X_2).*(X_3);
        y_t=ValorY.';       %Obtencion de datos para el calculo de error
        y_e=subs(Y,X_1,ValorX1);    %Evaluar x_1 en la ecuacion de regresion
        for i=1:m
            y_e(i)=subs(y_e(i),X_2,ValorX2(i));
            y_e(i)=subs(y_e(i),X_3,ValorX3(i));
        end
        y_e=double(y_e.');    %Evaluar x en la ecuacion de regresion 
        Error=double(y_t-y_e);              %Calculo del error
        disp('   Tabla de errores')
        M=[y_t y_e Error];                  %Guardar todos los datos en una matriz e imprimir
        disp(M);
        CoeficienteCorrelacion(m,ValorY,ValorX1,ValorX2,ValorX3);   %Coeficiente de Correlacion;
        end  
        
        if((enesima==4)&&(v==4))
        disp(M);
        R=rref(M);
        disp(R);
%         F=[R(12) R(11) R(10)];
%        [x y]=meshgrid(-5:10);
%         y=(R(101)+ R(102).*x + R(103).*x^2 + R(104).*y +R(105).*y^2 + R(106).*z + R(107).*z^2 + R(108).*x.*y + R(109).*x.*z+R(110).*y.*z);
        formatSpec = 'La ecuacion es G=(%f) + (%f)*x + (%f)*x^2 + (%f)*x^3 + (%f)*x^4 + (%f)*y + (%f)*y^2 + (%f)*y^3 + (%f)*y^4+ (%f)*z + (%f)*z^2 + (%f)*z^3 + (%f)*z^4 + (%f)*k + (%f)*k^2 + (%f)*k^3 + (%f)*k^4 + (%f)*xy + (%f)*xz + (%f)*xk + (%f)*yz + (%f)*yk + (%f)*zk\n';
        fprintf(formatSpec,R(530),R(531),R(532),R(533),R(534),R(535),R(536),R(537),R(538),R(539),R(540),R(541),R(542),R(543),R(544),R(545),R(546),R(547),R(548),R(549),R(550),R(551),R(552));   
        Y= R(530) + R(531).*X_1 + R(532).*((X_1)^2) + R(533).*((X_1)^3) + R(534).*((X_1)^4) + R(535).*X_2 + R(536).*((X_2)^2) + R(537).*((X_2)^3) + R(538).*((X_2)^4) + R(539).*X_3 + R(540).*((X_3)^2) + R(541).*((X_3)^3) + R(542).*((X_3)^4) + R(543).*X_4 + R(544).*((X_4)^2) + R(545).*((X_4)^3) + R(546).*((X_4)^4) + R(547).*(X_1).*(X_2) + R(548).*(X_1).*(X_3) + R(549).*(X_1).*(X_4) + R(550).*(X_2).*(X_3) + R(551).*(X_2).*(X_4) + R(552).*(X_3).*(X_4);   %Ecuacion de Regresion obtenida
        y_t=ValorY.';       %Obtencion de datos para el calculo de error
        y_e=subs(Y,X_1,ValorX1);    %Evaluar x_1 en la ecuacion de regresion
        for i=1:m
            y_e(i)=subs(y_e(i),X_2,ValorX2(i));
            y_e(i)=subs(y_e(i),X_3,ValorX3(i));
            y_e(i)=subs(y_e(i),X_4,ValorX4(i));
        end
        y_e=double(y_e.');    %Evaluar x en la ecuacion de regresion 
        Error=double(y_t-y_e);              %Calculo del error
        disp('   Tabla de errores')
        M=[y_t y_e Error];                  %Guardar todos los datos en una matriz e imprimir
        disp(M);
        CoeficienteCorrelacion(m,ValorY,ValorX1,ValorX2,ValorX3,ValorX4);   %Coeficiente de Correlacion;
        end     

    
end


function CoeficienteCorrelacion(varargin)
 disp('Coeficiente de Correlacion');
 if(nargin==3||nargin==4||nargin==5||nargin==6)
     coeficiente(1)=((varargin{1}.*sum(varargin{3}).*sum(varargin{2}))-(sum(varargin{3}).*sum(varargin{2})))/(sqrt((varargin{1}.*sum(varargin{3}.^2)).*((sum(varargin{3}))^2)).*(sqrt((varargin{1}.*sum(varargin{2}.^2)).*((sum(varargin{2}))^2))));
 end
 if(nargin==4||nargin==5||nargin==6 )
     coeficiente(2)=((varargin{1}.*sum(varargin{4}).*sum(varargin{2}))-(sum(varargin{4}).*sum(varargin{2})))/(sqrt((varargin{1}.*sum(varargin{4}.^2)).*((sum(varargin{4}))^2)).*(sqrt((varargin{1}.*sum(varargin{2}.^2)).*((sum(varargin{2}))^2))));
 end
 if(nargin==5||nargin==6 )
     coeficiente(3)=((varargin{1}.*sum(varargin{5}).*sum(varargin{2}))-(sum(varargin{5}).*sum(varargin{2})))/(sqrt((varargin{1}.*sum(varargin{5}.^2)).*((sum(varargin{5}))^2)).*(sqrt((varargin{1}.*sum(varargin{2}.^2)).*((sum(varargin{2}))^2))));
 end
 if(nargin==6 )
     coeficiente(4)=((varargin{1}.*sum(varargin{6}).*sum(varargin{2}))-(sum(varargin{6}).*sum(varargin{2})))/(sqrt((varargin{1}.*sum(varargin{6}.^2)).*((sum(varargin{6}))^2)).*(sqrt((varargin{1}.*sum(varargin{2}.^2)).*((sum(varargin{2}))^2))));
 end
 disp(coeficiente.');
end

