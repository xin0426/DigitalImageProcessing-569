function G=lpf3_simple(F)
% linear noise cleaning
% spatial domain processing
% create the impulse response array
H=[1 1 1; 1 1 1; 1 1 1];
for i=1:3
    for j=1:3
        H(i,j)=H(i,j)/9;
    end 
end

N=512;

% create a new matrix for the convolution
F_lpf=zeros(N+2,N+2);
for i=2:N+1
    for j=2:N+1
        F_lpf(i,j)=F(i-1,j-1);
    end
end

for i=2:N+1
       F_lpf(1,i)=F_lpf(3,i);
       F_lpf(N+2,i)=F_lpf(N,i);
       F_lpf(i,1)=F_lpf(i,3);
       F_lpf(i,N+2)=F_lpf(i,N);
end

F_lpf(1,1)=F_lpf(3,3);
F_lpf(1,N+2)=F_lpf(3,N);
F_lpf(N+2,1)=F_lpf(N,3);
F_lpf(N+2,N+2)=F_lpf(N,N);
 
% Implement the spatial domain processing
G=zeros(N,N);
for i=2:N+1
    for j=2:N+1
        G(i-1,j-1)=F_lpf(i-1,j-1)*H(1,1)+F_lpf(i-1,j)*H(1,2)+F_lpf(i-1,j+1)*H(1,3)+F_lpf(i,j-1)*H(2,1)+F_lpf(i,j)*H(2,2)+F_lpf(i,j+1)*H(2,3)+F_lpf(i+1,j-1)*H(3,1)+F_lpf(i+1,j)*H(3,2)+F_lpf(i+1,j+1)*H(3,3);
    end
end