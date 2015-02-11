function G=med_square3(F)
% nonlinear noise cleaning
% median filter 
% square filter
% create a new matrix for the median filter
N=512;
F_out=zeros(N+2,N+2);
for i=2:N+1
    for j=2:N+1
        F_out(i,j)=F(i-1,j-1);
    end
end
for i=2:N+1
    F_out(i,1)=F_out(i,3);
    F_out(i,N+2)=F_out(i,N);
    F_out(1,i)=F_out(3,i);
    F_out(N+2,i)=F_out(N,i);
end
F_out(1,1)=F_out(3,3);
F_out(1,N+2)=F_out(3,N);
F_out(N+2,1)=F_out(N,3);
F_out(N+2,N+2)=F_out(N,N);

% implement the median filter
G=zeros(N,N);
for i=2:N+1
    for j=2:N+1
        H=zeros(1,9);
        H(:,1)=F_out(i-1,j-1);
        H(:,2)=F_out(i-1,j);
        H(:,3)=F_out(i-1,j+1);
        H(:,4)=F_out(i,j-1);
        H(:,5)=F_out(i,j);
        H(:,6)=F_out(i,j+1);
        H(:,7)=F_out(i+1,j-1);
        H(:,8)=F_out(i+1,j);
        H(:,9)=F_out(i+1,j+1);
        for m=1:8
            for n=m+1:9
            if H(:,m)>H(:,n)
                t=H(:,m);
                H(:,m)=H(:,n);
                H(:,n)=t;
            end
            end
        end
        G(i-1,j-1)=H(:,5);
    end
end
        
        