function G_lp=lp(Graw)
N=256;
% gain-normalized four-neighbor Laplacian impulse response array
H=[0 -1 0; -1 4 -1; 0 -1 0];
for i=1:3
    for j=1:3
        H(i,j)=H(i,j)/4;
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

% implement Laplacian
G_lp=zeros(N,N);
for i=2:N+1
    for j=2:N+1
        G_lp(i-1,j-1)=(G(i-1,j-1)*H(1,1)+G(i-1,j)*H(1,2)+G(i-1,j+1)*H(1,3)+G(i,j-1)*H(2,1)+G(i,j)*H(2,2)+G(i,j+1)*H(2,3)+G(i+1,j-1)*H(3,1)+G(i+1,j)*H(3,2)+G(i+1,j+1)*H(3,3));
    end
end
