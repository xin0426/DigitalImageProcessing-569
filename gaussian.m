function G_gau=gaussian(Graw)

N=256;
% create the 3*3 gaussian filter
W=3;
sigma=W/(6*sqrt(2));
H=zeros(W,W);
H_sum=0;
for i=1:W
    for j=1:W
    H(i,j)=exp(-((i-2)^2+(j-2)^2)/(sigma^2));
    H_sum=H_sum+H(i,j);
    end
end

% create a new matrix for the convolution
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

% implement gaussian filtering
G_gau=zeros(N,N);
for i=2:N+1
    for j=2:N+1
        G_gau(i-1,j-1)=(G(i-1,j-1)*H(1,1)+G(i-1,j)*H(1,2)+G(i-1,j+1)*H(1,3)+G(i,j-1)*H(2,1)+G(i,j)*H(2,2)+G(i,j+1)*H(2,3)+G(i+1,j-1)*H(3,1)+G(i+1,j)*H(3,2)+G(i+1,j+1)*H(3,3))/H_sum;
    end
end
        
        