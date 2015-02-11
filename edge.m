function G_edge=edge(G_nor,cdf_G,t)
 N=256;
 T=0;
for i=1:256
    if cdf_G(1,i)<(1-t)*cdf_G(1,256) && cdf_G(1,i+1)>(1-t)*cdf_G(1,256)
       T=i;
    end
end

G_edge=zeros(N,N);
for i=1:N*N
    if round(G_nor(i))<T
        G_edge(i)=255;
    end
end