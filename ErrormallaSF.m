%ERROR DEL METODO ITERATIVO PARA UN PUNTO FIJO
clear all 
close all

disp('Inserte el valor de x en el que desea ver el error (debe estar entre 0 y 1).')
xpunto = input(' x = ');
if  or (xpunto>1,xpunto<0)
  disp('El valor debe estar entre 0 y 1.')
  return
end

disp('Inserte el valor de y en el que desea ver el error (debe estar entre 0 y 1).')
ypunto = input(' y = ');
if or (ypunto>1,ypunto<0)
  disp('El valor debe estar entre 0 y 1.')
  return
end

% h = paso espacial
% k = paso temporal

hinicial = 0.03; %Un hinicial menor tarda mucho
hfinal = 0.2;
paso = 0.01;
hvec = (hinicial:paso:hfinal); 
kvec = (hinicial:paso:hfinal); %Construimos k igual a h para armar una grilla cuadrada
sa=length(hvec);
sc=length(kvec);

for i = 1:sa
 for j = 1:sc
  x = [0:hvec(i):1];
  M = length(x);
  y = x;
  [X, Y] = meshgrid(x,y);
  t0=0; 
  tf = 1; 
  t = [t0:kvec(j):tf];
  N = length(t); 
  %Condiciones iniciales
  U0 = sin(pi.*X).*sin(pi.*Y);
  %Condiciones de contorno
  U0(1,:) = zeros(1,M);
  U0(M,:) = zeros(1,M);
  U0(:,1) = zeros(1,M)';
  U0(:,M) = zeros(1,M)';
  Uvecn = vec(U0); 
  R = length(Uvecn);
  Uvecan = Uvecn; 
  %Esquema (método implícito)
  c1 = (kvec(j)^2)/(hvec(i)^2);
  c2 = -1-4*c1;
  A = diag(c2*ones(1,R))+diag(c1*ones(1,R-1),-1)+diag(c1*ones(1,R-1),1)+diag(c1*ones(1,R-M),-M)+diag(c1*ones(1,R-M),M);
  B = inv(A); 
  B = cerosB (M,R,B); 
    n=1;
  while (n<N)   
    Uvecdn = B*(Uvecan-2*Uvecn); 
    U = reshape(Uvecdn,M,M);
    Z = cos((sqrt(2))*pi*t(n)).*sin(pi.*X).*sin(pi.*Y); 
    Uvecan=Uvecn;
    Uvecn=Uvecdn;
    n=n+1;
  end
   ERROR=abs(Z-U); %Error en todos los puntos de la membrana
   diferencia(i,j)=interp2(x,y,ERROR,xpunto,ypunto,'linear','extrap');
   % diferencia guarda en cada posición el error en el punto fijo (i,j) de h y k.
   % Se interpola para poder elegir un punto que no esté en todas las grillas
   end
end


[H, K]=meshgrid(hvec,kvec);
%Grafico
surf(H,K,diferencia);
xlabel('h');
ylabel('k');
title('Error en un punto (x,y)');
