function [SSIM,E,SSIM_avr]=ssim(Araw,Braw)
N=512;

% create new matrix for the window calculation
% for matrix Araw
A=zeros(N+4,N+4);
for i=3:N+2
    for j=3:N+2
        A(i,j)=Araw(i-2,j-2);
    end
end
for i=3:N+2
    A(i,1)=A(i,5);
    A(i,2)=A(i,4);
    A(i,N+3)=A(i,N+1);
    A(i,N+4)=A(i,N);
    A(1,i)=A(5,i);
    A(2,i)=A(4,i);
    A(N+3,i)=A(N+1,i);
    A(N+4,i)=A(N,i);
end
A(1,1)=A(5,5);
A(1,2)=A(4,5);
A(2,1)=A(5,4);
A(2,2)=A(4,5);

A(1,N+3)=A(4,N);
A(1,N+4)=A(5,N);
A(2,N+3)=A(4,N+1);
A(2,N+4)=A(5,N+1);

A(N+3,1)=A(N,4);
A(N+4,1)=A(N,5);
A(N+3,2)=A(N+1,4);
A(N+4,2)=A(N+1,5);

A(N+3,N+3)=A(N+1,N+1);
A(N+3,N+4)=A(N,N+1);
A(N+4,N+3)=A(N+1,N);
A(N+4,N+4)=A(N,N);

% for matrix Braw
B=zeros(N+4,N+4);
for i=3:N+2
    for j=3:N+2
        B(i,j)=Braw(i-2,j-2);
    end
end
for i=3:N+2
    B(i,1)=B(i,5);
    B(i,2)=B(i,4);
    B(i,N+3)=B(i,N+1);
    B(i,N+4)=B(i,N);
    B(1,i)=B(5,i);
    B(2,i)=B(4,i);
    B(N+3,i)=B(N+1,i);
    B(N+4,i)=B(N,i);
end
B(1,1)=B(5,5);
B(1,2)=B(4,5);
B(2,1)=B(5,4);
B(2,2)=B(4,5);

B(1,N+3)=B(4,N);
B(1,N+4)=B(5,N);
B(2,N+3)=B(4,N+1);
B(2,N+4)=B(5,N+1);

B(N+3,1)=B(N,4);
B(N+4,1)=B(N,5);
B(N+3,2)=B(N+1,4);
B(N+4,2)=B(N+1,5);

B(N+3,N+3)=B(N+1,N+1);
B(N+3,N+4)=B(N,N+1);
B(N+4,N+3)=B(N+1,N);
B(N+4,N+4)=B(N,N);

% calculate the mean,variance and covariance in the window
% mean of the original image Araw

ua=zeros(N,N);
for i=3:N+2
    for j=3:N+2
        ua(i-2,j-2)=(A(i-2,j-2)+A(i-2,j-1)+A(i-2,j)+A(i-2,j+1)+A(i-2,j+2)+A(i-1,j-2)+A(i-1,j-1)+A(i-1,j)+A(i-1,j+1)+A(i-1,j+2)+A(i,j-2)+A(i,j-1)+A(i,j)+A(i,j+1)+A(i,j+2)+A(i+1,j-2)+A(i+1,j-1)+A(i+1,j)+A(i+1,j+1)+A(i+1,j+2)+A(i+2,j-2)+A(i+2,j-1)+A(i+2,j)+A(i+2,j+1)+A(i+2,j+2))/25;
    end
end

% mean of the original image Braw

ub=zeros(N,N);
for i=3:N+2
    for j=3:N+2
        ub(i-2,j-2)=(B(i-2,j-2)+B(i-2,j-1)+B(i-2,j)+B(i-2,j+1)+B(i-2,j+2)+B(i-1,j-2)+B(i-1,j-1)+B(i-1,j)+B(i-1,j+1)+B(i-1,j+2)+B(i,j-2)+B(i,j-1)+B(i,j)+B(i,j+1)+B(i,j+2)+B(i+1,j-2)+B(i+1,j-1)+B(i+1,j)+B(i+1,j+1)+B(i+1,j+2)+B(i+2,j-2)+B(i+2,j-1)+B(i+2,j)+B(i+2,j+1)+B(i+2,j+2))/25;
    end
end

% variance of the original image Araw

da=zeros(N,N);
for i=3:N+2
    for j=3:N+2
        da(i-2,j-2)=((A(i-2,j-2)-ua(i-2,j-2))^2+(A(i-2,j-1)-ua(i-2,j-2))^2+(A(i-2,j)-ua(i-2,j-2))^2+(A(i-2,j+1)-ua(i-2,j-2))^2+(A(i-2,j+2)-ua(i-2,j-2))^2+(A(i-1,j-2)-ua(i-2,j-2))^2+(A(i-1,j-1)-ua(i-2,j-2))^2+(A(i-1,j)-ua(i-2,j-2))^2+(A(i-1,j+1)-ua(i-2,j-2))^2+(A(i-1,j+2)-ua(i-2,j-2))^2+(A(i,j-2)-ua(i-2,j-2))^2+(A(i,j-1)-ua(i-2,j-2))^2+(A(i,j)-ua(i-2,j-2))^2+(A(i,j+1)-ua(i-2,j-2))^2+(A(i,j+2)-ua(i-2,j-2))^2+(A(i+1,j-2)-ua(i-2,j-2))^2+(A(i+1,j-1)-ua(i-2,j-2))^2+(A(i+1,j)-ua(i-2,j-2))^2+(A(i+1,j+1)-ua(i-2,j-2))^2+(A(i+1,j+2)-ua(i-2,j-2))^2+(A(i+2,j-2)-ua(i-2,j-2))^2+(A(i+2,j-1)-ua(i-2,j-2))^2+(A(i+2,j)-ua(i-2,j-2))^2+(A(i+2,j+1)-ua(i-2,j-2))^2+(A(i+2,j+2)-ua(i-2,j-2))^2)/25;
    end
end

% variance of the original image Braw

db=zeros(N,N);
for i=3:N+2
    for j=3:N+2
        db(i-2,j-2)=((B(i-2,j-2)-ub(i-2,j-2))^2+(B(i-2,j-1)-ub(i-2,j-2))^2+(B(i-2,j)-ub(i-2,j-2))^2+(B(i-2,j+1)-ub(i-2,j-2))^2+(B(i-2,j+2)-ub(i-2,j-2))^2+(B(i-1,j-2)-ub(i-2,j-2))^2+(B(i-1,j-1)-ub(i-2,j-2))^2+(B(i-1,j)-ub(i-2,j-2))^2+(B(i-1,j+1)-ub(i-2,j-2))^2+(B(i-1,j+2)-ub(i-2,j-2))^2+(B(i,j-2)-ub(i-2,j-2))^2+(B(i,j-1)-ub(i-2,j-2))^2+(B(i,j)-ub(i-2,j-2))^2+(B(i,j+1)-ub(i-2,j-2))^2+(B(i,j+2)-ub(i-2,j-2))^2+(B(i+1,j-2)-ub(i-2,j-2))^2+(B(i+1,j-1)-ub(i-2,j-2))^2+(B(i+1,j)-ub(i-2,j-2))^2+(B(i+1,j+1)-ub(i-2,j-2))^2+(B(i+1,j+2)-ub(i-2,j-2))^2+(B(i+2,j-2)-ub(i-2,j-2))^2+(B(i+2,j-1)-ub(i-2,j-2))^2+(B(i+2,j)-ub(i-2,j-2))^2+(B(i+2,j+1)-ub(i-2,j-2))^2+(B(i+2,j+2)-ub(i-2,j-2))^2)/25;
    end
end

% covariance of  Araw and Braw

dab=zeros(N,N);
for i=3:N+2
    for j=3:N+2
      dab(i-2,j-2)=((A(i-2,j-2)-ua(i-2,j-2))*(B(i-2,j-2)-ub(i-2,j-2))+(A(i-2,j-1)-ua(i-2,j-2))*(B(i-2,j-1)-ub(i-2,j-2))+(A(i-2,j)-ua(i-2,j-2))*(B(i-2,j)-ub(i-2,j-2))+(A(i-2,j+1)-ua(i-2,j-2))*(B(i-2,j+1)-ub(i-2,j-2))+(A(i-2,j+2)-ua(i-2,j-2))*(B(i-2,j+2)-ub(i-2,j-2))+(A(i-1,j-2)-ua(i-2,j-2))*(B(i-1,j-2)-ub(i-2,j-2))+(A(i-1,j-1)-ua(i-2,j-2))*(B(i-1,j-1)-ub(i-2,j-2))+(A(i-1,j)-ua(i-2,j-2))*(B(i-1,j)-ub(i-2,j-2))+(A(i-1,j+1)-ua(i-2,j-2))*(B(i-1,j+1)-ub(i-2,j-2))+(A(i-1,j+2)-ua(i-2,j-2))*(B(i-1,j+2)-ub(i-2,j-2))+(A(i,j-2)-ua(i-2,j-2))*(B(i,j-2)-ub(i-2,j-2))+(A(i,j-1)-ua(i-2,j-2))*(B(i,j-1)-ub(i-2,j-2))+(A(i,j)-ua(i-2,j-2))*(B(i,j)-ub(i-2,j-2))+(A(i,j+1)-ua(i-2,j-2))*(B(i,j+1)-ub(i-2,j-2))+(A(i,j+2)-ua(i-2,j-2))*(B(i,j+2)-ub(i-2,j-2))+(A(i+1,j-2)-ua(i-2,j-2))*(B(i+1,j-2)-ub(i-2,j-2))+(A(i+1,j-1)-ua(i-2,j-2))*(B(i+1,j-1)-ub(i-2,j-2))+(A(i+1,j)-ua(i-2,j-2))*(B(i+1,j)-ub(i-2,j-2))+(A(i+1,j+1)-ua(i-2,j-2))*(B(i+1,j+1)-ub(i-2,j-2))+(A(i+1,j+2)-ua(i-2,j-2))*(B(i+1,j+2)-ub(i-2,j-2))+(A(i+2,j-2)-ua(i-2,j-2))*(B(i+2,j-2)-ub(i-2,j-2))+(A(i+2,j-1)-ua(i-2,j-2))*(B(i+2,j-1)-ub(i-2,j-2))+(A(i+2,j)-ua(i-2,j-2))*(B(i+2,j)-ub(i-2,j-2))+(A(i+2,j+1)-ua(i-2,j-2))*(B(i+2,j+1)-ub(i-2,j-2))+(A(i+2,j+2)-ua(i-2,j-2))*(B(i+2,j+2)-ub(i-2,j-2)))/25;
    end
end

% calculate the SSIM index of  each pixel
SSIM=zeros(N,N);
L=255;
c1=(0.01*L)^2;
c2=(0.03*L)^2;
for i=1:N
    for j=1:N
        SSIM(i,j)=((2*ua(i,j)*ub(i,j)+c1)*(2*dab(i,j)+c2))/(((ua(i,j))^2+(ub(i,j))^2+c1)*(da(i,j)+db(i,j)+c2));
    end
end

% calculate the absolute error 
E=zeros(N,N);
for i=1:N
    for j=1:N
        E(i,j)=abs(Araw(i,j)-Braw(i,j));
    end
end

figure()
imshow(uint8(E));

% apply pooling method to get one SSIM index for the whole image
SSIM_sum=0;
H=zeros(N,N);
H_sum=0;
for i=1:N
    for j=1:N
        H(i,j)=1;
    end
end
for i=172:341
    for j=172:341
        H(i,j)=2;
    end
end
for i=229:284
    for j=229:284
        H(i,j)=4;
    end
end
for i=1:N
    for j=1:N
        H_sum=H_sum+H(i,j);
    end
end
for i=1:N
    for j=1:N
        SSIM_sum=SSIM_sum+H(i,j)*SSIM(i,j);
    end
end

SSIM_avr=SSIM_sum/H_sum

% normalize SSIM to 0- 255
max=0;
min=0;
for i=1:N
    for j=1:N
        if SSIM(i,j)>max
            max=SSIM(i,j);
        end
        if SSIM(i,j)<min
            min=SSIM(i,j);
        end
    end
end

for i=1:N
    for j=1:N
        SSIM(i,j)=((SSIM(i,j)-min)/(max-min))*255;
    end
end
           
figure()
imshow(uint8(SSIM));
