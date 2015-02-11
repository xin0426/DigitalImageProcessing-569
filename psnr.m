function PSNR=psnr(A,B)
MSE=0;
N=512;
for i=1:N
    for j=1:N
        MSE=(A(i,j)-B(i,j))^2;
    end
end
MSE=MSE/(N^2);

PSNR=10*log10((255^2)/MSE)