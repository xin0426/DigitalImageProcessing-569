function G=med_plussign3(F)
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

% implement the median filter
G=zeros(N,N);
for i=2:N+1
    for j=2:N+1
        H=zeros(1,5);
        H(:,1)=F_out(i-1,j);
        H(:,2)=F_out(i,j);
        H(:,3)=F_out(i+1,j);
        H(:,4)=F_out(i,j-1);
        H(:,5)=F_out(i,j+1);
        
       for m=1:4
            for n=m+1:5
            if H(:,m)>H(:,n)
                t=H(:,m);
                H(:,m)=H(:,n);
                H(:,n)=t;
            end
            end
        end
        G(i-1,j-1)=H(:,3);
    end
end
        