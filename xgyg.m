function [Gr,Gc,Gr_nor,Gc_nor]=xgyg(Graw)
% implement sobel operator to image girl.raw
% get the x-gradient and y-gradient of the two images
% girl.raw
N=256;
G=zeros(N+2,N+2);
for i=2:N+1
    for j=2:N+1
        G(i,j)=Graw(i-1,j-1);
    end
end
for i=2:N+1
    G(i,1)=G(i,3);
    G(i,N+2)=G(i,N);
    G(1,i)=G(3,i);
    G(N+2,i)=G(N,i);
end
G(1,1)=G(3,3);
G(1,N+2)=G(3,N);
G(N+2,1)=G(N,3);
G(N+2,N+2)=G(N,N);

Gr=zeros(N,N);
Gc=zeros(N,N);

K=2;
for i=2:N+1
    for j=2:N+1
        Gr(i-1,j-1)=((G(i-1,j+1)+K*G(i,j+1)+G(i+1,j+1))-(G(i-1,j-1)+K*G(i,j-1)+G(i+1,j-1)))/(K+2);
        Gc(i-1,j-1)=((G(i-1,j-1)+K*G(i-1,j)+G(i-1,j+1))-(G(i+1,j-1)+K*G(i+1,j)+G(i+1,j+1)))/(K+2);
    end
end

% normalize x-gradient and y gradient to 0-255 and show the results
% girl.raw
Gr_max=0;
Gr_min=0;
Gc_max=0;
Gc_min=0;
for i=1:N
    for j=1:N
        if Gr(i,j)>Gr_max
            Gr_max=Gr(i,j);
        end
        if Gr(i,j)<Gr_min
            Gr_min=Gr(i,j);
        end
         if Gc(i,j)>Gc_max
            Gc_max=Gc(i,j);
        end
        if Gc(i,j)<Gc_min
            Gc_min=Gc(i,j);
        end
    end
end

Gr_nor=zeros(N,N);
Gc_nor=zeros(N,N);
for i=1:N
    for j=1:N
        Gr_nor(i,j)=(Gr(i,j)-Gr_min)/(Gr_max-Gr_min)*255;
        Gc_nor(i,j)=(Gc(i,j)-Gc_min)/(Gc_max-Gc_min)*255;
    end
end