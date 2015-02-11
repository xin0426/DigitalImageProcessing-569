function G=outlier(F)
% nonlinear noise cleaning
% outlier
% create a new matrix for the outlier processing
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

% implement the outlier noise cleaning
G=zeros(N,N);
for i=1:N
    for j=1:N
        G(i,j)=F(i,j);
    end
end

for i=2:N+1
    for j=2:N+1
        avr=(F_out(i-1,j-1)+F_out(i-1,j)+F_out(i-1,j+1)+F_out(i,j-1)+F_out(i,j)+F_out(i,j+1)+F_out(i+1,j-1)+F_out(i+1,j)+F_out(i+1,j+1))/8;
        e=abs(F_out(i,j)-avr);
        th=0.1*avr;   % set the threshold level as 10%
        if e>th
            G(i-1,j-1)=avr;
        end
    end
end