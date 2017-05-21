%OCSILACIONES DE UNA MEMBRANA CUADRADA
clear all 
close all


disp('Escriba la cantidad de puntos en los que quiere dividir los ejes x e y. El valor debe estar entre 10 y 100.');
grilla = input('grilla = ');
if  or (grilla>100,grilla<10)
  disp('El valor debe estar entre 10 y 100.')
  return
end

disp('¿Hasta que tiempo quiere ver la oscilacion?');
tf = input('t = '); %Tiempo final
%Definicion de las variables
h = 1/grilla; %Separación entre los puntos del eje x
x = [0:h:1];
M = length(x);
y = x;
[X, Y] = meshgrid(x,y); %Grilla de puntos x e y
k = (1/4)*h; %Intervalo temporal
t0 = 0; %Tiempo inicial
t = [t0:k:tf];
N = length(t);

%Condiciones iniciales
U0 = sin(pi.*X).*sin(pi.*Y); 
%Condiciones de contorno
U0(1,:) = zeros(1,M);
U0(M,:) = zeros(1,M);
U0(:,1) = zeros(1,M)';
U0(:,M) = zeros(1,M)';
% Se le imponen c.c. a U0 porque no es cero en los bordes
Uvecn = vec(U0); %Transforma a la matriz U0 en un vector
R = length(Uvecn);
Uvecan = Uvecn;

%Esquema: (Método implícito)
% A*U(n+1) = U(n-1)-2*U(n)
% U(n+1) = Uvecdn (vector "despues que n")
% U(n) = Uvecn (vector a tiempo n)
% U(n-1) = Uvecan (vector "antes que n")
% B = inv(A)
% U(n+1) = B*(U(n-1)-2*U(n))

c1=(k^2)/(h^2);
c2=-1-4*c1;
A=diag(c2*ones(1,R))+diag(c1*ones(1,R-1),-1)+diag(c1*ones(1,R-1),1)+diag(c1*ones(1,R-M),-M)+diag(c1*ones(1,R-M),M);
B = inv(A); 
B=cerosB (M,R,B);
% La función cerosB debe estar en la misma carpeta que este programa

n=1;
while (n<N)   
    Uvecdn = B*(Uvecan-2*Uvecn); 
    U = reshape(Uvecdn,M,M); %Vuelve a convertir el vector en matriz
    Z = cos((sqrt(2))*pi*t(n)).*sin(pi.*X).*sin(pi.*Y); %Solución exacta
    %Gráfico
    subplot(1,2,1);
      surf(X,Y,U) 
      axis([0,1,0,1,-1,1]) 
      xlabel('x')
      ylabel('y')
      title ('Metodo iterativo')
    subplot(1,2,2);
      surf(X,Y,Z) 
      axis([0,1,0,1,-1,1]) 
      xlabel('x')
      ylabel('y')
      title ('Solucion exacta')
    drawnow
    pause(0.2)
    Uvecan=Uvecn; %Redefinición de las variables
    Uvecn=Uvecdn;
    n=n+1;
end

