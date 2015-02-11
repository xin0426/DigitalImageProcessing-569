function G_Zerocrs=Zerocrs(Graw,T)
N=256;
for i=1:N
    for j=1:N
        if Graw(i,j)>T
            Graw(i,j)=1;
        elseif Graw(i,j)<(-T)
            Graw(i,j)=-1;
        else
            Graw(i,j)=0;
        end
    end
end

G=zeros(N+2,N+2);
for i=2:N+1
    for j=2:N+1
        G(i,j)=Graw(i-1,j-1);
    end
end

G_Zerocrs=zeros(N,N);
for i=1:N
    for j=1:N
    G_Zerocrs(i,j)=255;
    end
end

for i=2:N+1
    for j=2:N+1
        if G(i,j)==0 && (G(i-1,j)*G(i+1,j)==-1 || G(i-1,j-1)*G(i+1,j+1)==-1 || G(i,j-1)*G(i,j+1)==-1 || G(i-1,j+1)*G(i+1,j-1)==-1)
            G_Zerocrs(i-1,j-1)=0;
        end
     end
end