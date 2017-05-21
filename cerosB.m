function B0=cerosB (M, R, B)
% Pone ceros en algunos lugares de la matriz B para mantener las condiciones de contorno
g=2;
   
while g<=(M-2)
 for i=1:(M+1)
      for j=(M+2):(2*M-1)
        B(i,j)=0;
      end
      for j=(g*M+2):((g+1)*M-1)
        B(i,j)=0;
      end
      for j=((M-2)*M+2):(R-M-1)
        B(i,j)=0;
      end
    end
    for d=(R-M):R
     for j=(M+2):(2*M-1)
        B(d,j)=0;
      end
      for j=(g*M+2):((g+1)*M-1)
        B(d,j)=0;
      end
      for j=((M-2)*M+2):(R-M-1)
        B(d,j)=0;
      end
    end
    for p=2:(M-2)
      for j=(M+2):(2*M-1)
        B(p*M,j)=0;
        B(p*M+1,j)=0;
      end
      for j=(g*M+2):((g+1)*M-1)
        B(p*M,j)=0;
        B(p*M+1,j)=0;
      end
      for j=((M-2)*M+2):(R-M-1)
        B(p*M,j)=0;
        B(p*M+1,j)=0;
      end
   end
g=g+1;
end
B0=B;
end