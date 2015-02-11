function G=med_square5(F)
% nonlinear noise cleaning
% median filter 
% square filter
% create a new matrix for the median filter
N=512;
F_out=zeros(N+4,N+4);
for i=3:N+2
    for j=3:N+2
        F_out(i,j)=F(i-2,j-2);
    end
end
for i=3:N+2
    F_out(i,1)=F_out(i,5);
    F_out(i,2)=F_out(i,4);
    F_out(i,N+3)=F_out(i,N+1);
    F_out(i,N+4)=F_out(i,N);
    F_out(1,i)=F_out(5,i);
    F_out(2,i)=F_out(4,i);
    F_out(N+3,i)=F_out(N+1,i);
    F_out(N+4,i)=F_out(N,i);
end
F_out(1,1)=F_out(5,5);
F_out(1,2)=F_out(4,5);
F_out(2,1)=F_out(5,4);
F_out(2,2)=F_out(4,5);

F_out(1,N+3)=F_out(4,N);
F_out(1,N+4)=F_out(5,N);
F_out(2,N+3)=F_out(4,N+1);
F_out(2,N+4)=F_out(5,N+1);

F_out(N+3,1)=F_out(N,4);
F_out(N+4,1)=F_out(N,5);
F_out(N+3,2)=F_out(N+1,4);
F_out(N+4,2)=F_out(N+1,5);

F_out(N+3,N+3)=F_out(N+1,N+1);
F_out(N+3,N+4)=F_out(N,N+1);
F_out(N+4,N+3)=F_out(N+1,N);
F_out(N+4,N+4)=F_out(N,N);

% implement the median filter
G=zeros(N,N);
for i=3:N+2
    for j=3:N+2
        H=zeros(1,25);
        H(:,1)=F_out(i-2,j-2);
        H(:,2)=F_out(i-2,j-1);
        H(:,3)=F_out(i-2,j);
        H(:,4)=F_out(i-2,j+1);
        H(:,5)=F_out(i-2,j+2);
        H(:,6)=F_out(i-1,j-2);
        H(:,7)=F_out(i-1,j-1);
        H(:,8)=F_out(i-1,j);
        H(:,9)=F_out(i-1,j+1);
        H(:,10)=F_out(i-1,j+2);
        H(:,11)=F_out(i,j-2);
        H(:,12)=F_out(i,j-1);
        H(:,13)=F_out(i,j);
        H(:,14)=F_out(i,j+1);
        H(:,15)=F_out(i,j+2);
        H(:,16)=F_out(i+1,j-2);
        H(:,17)=F_out(i+1,j-1);
        H(:,18)=F_out(i+1,j);
        H(:,19)=F_out(i+1,j+1);
        H(:,20)=F_out(i+1,j+2);
        H(:,21)=F_out(i+2,j-2);
        H(:,22)=F_out(i+2,j-1);
        H(:,23)=F_out(i+2,j);
        H(:,24)=F_out(i+2,j+1);
        H(:,25)=F_out(i+2,j+2);
        for m=1:24
            for n=m+1:25
            if H(:,m)>H(:,n)
                t=H(:,m);
                H(:,m)=H(:,n);
                H(:,n)=t;
            end
            end
        end
        G(i-2,j-2)=H(:,13);
    end
end