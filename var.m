function G_var=var(Graw)
N=256;
% create a new matrix for calculation
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

G_mean=zeros(N,N);
for i=2:N+1
    for j=2:N+1
        G_mean(i-1,j-1)=(G(i-1,j-1)+G(i-1,j)+G(i-1,j+1)+G(i,j-1)+G(i,j)+G(i,j+1)+G(i+1,j-1)+G(i+1,j)+G(i+1,j+1))/9;
    end
end

G_var=zeros(N,N);

for i=2:N+1
    for j=2:N+1
        G_var(i-1,j-1)=((G(i-1,j-1)-G_mean(i-1,j-1))^2+(G(i-1,j)-G_mean(i-1,j-1))^2+(G(i-1,j+1)-G_mean(i-1,j-1))^2+(G(i,j-1)-G_mean(i-1,j-1))^2+(G(i,j)-G_mean(i-1,j-1))^2+(G(i,j+1)-G_mean(i-1,j-1))^2+(G(i+1,j-1)-G_mean(i-1,j-1))^2+(G(i+1,j)-G_mean(i-1,j-1))^2+(G(i+1,j+1)-G_mean(i-1,j-1))^2)/9;
    end
end

% normalize variance to 0-255
max=0;
min=0;
for i=1:N
    for j=1:N
        if G_var(i,j)>max
            max=G_var(i,j);
        end
        if G_var(i,j)<min
            min=G_var(i,j);
        end
    end
end
 
for i=1:N
    for j=1:N
        G_var(i,j)=((G_var(i,j)-min)/(max-min))*255;
    end
end