function [htg_G,cdf_G,G_nor]=htgcdf(Gr,Gc)
% tune the threshold
N=256;
G_s=zeros(N,N);

for i=1:N
    for j=1:N
        G_s(i,j)=sqrt((Gr(i,j))^2+(Gc(i,j))^2);
    end
end
 
% normalize the gradient 
G_max=0;
G_min=0;

for i=1:N
    for j=1:N
        if G_s(i,j)>G_max
            G_max=G_s(i,j);
        end
        if G_s(i,j)<G_min
            G_min=G_s(i,j);
        end
    end
end

G_nor=zeros(N,N);

for i=1:N
    for j=1:N
        G_nor(i,j)=(G_s(i,j)-G_min)/(G_max-G_min)*255;
    end
end

% get the histogram of gradients

htg_G=zeros(1,256);
x=[0:1/255:1];
for i=1:256
    for j=1:N*N
        if round(G_nor(j))==(i-1)
            htg_G(i)=htg_G(i)+1;
        end
    end
end


% get the cdf 
 cdf_G=zeros(1,256);
 for i=1:N
     for j=1:i
         cdf_G(1,i)=cdf_G(1,i)+htg_G(1,j);
     end
 end
 

