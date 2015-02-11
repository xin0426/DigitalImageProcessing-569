function G=med_plussign5(F)
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


% implement the median filter
G=zeros(N,N);
for i=3:N+2
    for j=3:N+2
        H=zeros(1,9);
        H(:,1)=F_out(i-2,j);
        H(:,2)=F_out(i-1,j);
        H(:,3)=F_out(i,j);
        H(:,4)=F_out(i+1,j);
        H(:,5)=F_out(i+2,j);
        H(:,6)=F_out(i,j-2);
        H(:,7)=F_out(i,j-1);
        H(:,8)=F_out(i,j+1);
        H(:,9)=F_out(i,j+2);
        
       for m=1:8
            for n=m+1:9
            if H(:,m)>H(:,n)
                t=H(:,m);
                H(:,m)=H(:,n);
                H(:,n)=t;
            end
            end
        end
        G(i-2,j-2)=H(:,5);
    end
end