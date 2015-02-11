function G=lpf5_weighted(F)
% linear noise cleaning
% spatial domain processing
% create the impulse response array
H=[1 2 4 2 1; 2 4 8 4 2; 4 8 16 8 4; 2 4 8 4 2; 1 2 4 2 1];
for i=1:5
    for j=1:5
        H(i,j)=H(i,j)/100;
    end 
end

N=512;

% create a new matrix for the convolution
F_lpf=zeros(N+4,N+4);
for i=3:N+2
    for j=3:N+2
        F_lpf(i,j)=F(i-2,j-2);
    end
end
for i=3:N+2
    F_lpf(i,1)=F_lpf(i,5);
    F_lpf(i,2)=F_lpf(i,4);
    F_lpf(i,N+3)=F_lpf(i,N+1);
    F_lpf(i,N+4)=F_lpf(i,N);
    F_lpf(1,i)=F_lpf(5,i);
    F_lpf(2,i)=F_lpf(4,i);
    F_lpf(N+3,i)=F_lpf(N+1,i);
    F_lpf(N+4,i)=F_lpf(N,i);
end
F_lpf(1,1)=F_lpf(5,5);
F_lpf(1,2)=F_lpf(4,5);
F_lpf(2,1)=F_lpf(5,4);
F_lpf(2,2)=F_lpf(4,5);

F_lpf(1,N+3)=F_lpf(4,N);
F_lpf(1,N+4)=F_lpf(5,N);
F_lpf(2,N+3)=F_lpf(4,N+1);
F_lpf(2,N+4)=F_lpf(5,N+1);

F_lpf(N+3,1)=F_lpf(N,4);
F_lpf(N+4,1)=F_lpf(N,5);
F_lpf(N+3,2)=F_lpf(N+1,4);
F_lpf(N+4,2)=F_lpf(N+1,5);

F_lpf(N+3,N+3)=F_lpf(N+1,N+1);
F_lpf(N+3,N+4)=F_lpf(N,N+1);
F_lpf(N+4,N+3)=F_lpf(N+1,N);
F_lpf(N+4,N+4)=F_lpf(N,N);

 
% Implement the spatial domain processing
G=zeros(N,N);
for i=3:N+2
    for j=3:N+2
        G(i-2,j-2)=F_lpf(i-2,j-2)*H(1,1)+F_lpf(i-2,j-1)*H(1,2)+F_lpf(i-2,j)*H(1,3)+F_lpf(i-2,j+1)*H(1,4)+F_lpf(i-2,j+2)*H(1,5)+F_lpf(i-1,j-2)*H(2,1)+F_lpf(i-1,j-1)*H(2,2)+F_lpf(i-1,j)*H(2,3)+F_lpf(i-1,j+1)*H(2,4)+F_lpf(i-1,j+2)*H(2,5)+F_lpf(i,j-2)*H(3,1)+F_lpf(i,j-1)*H(3,2)+F_lpf(i,j)*H(3,3)+F_lpf(i,j+1)*H(3,4)+F_lpf(i,j+2)*H(3,5)+F_lpf(i+1,j-2)*H(4,1)+F_lpf(i+1,j-1)*H(4,2)+F_lpf(i+1,j)*H(4,3)+F_lpf(i+1,j+1)*H(4,4)+F_lpf(i+1,j+2)*H(4,5)+F_lpf(i+2,j-2)*H(5,1)+F_lpf(i+2,j-1)*H(5,2)+F_lpf(i+2,j)*H(5,3)+F_lpf(i+2,j+1)*H(5,4)+F_lpf(i+2,j+2)*H(5,5);
    end
end