clc;
clear all;
close all;

%1-a
fid=fopen('desk.raw','r');
if (fid == -1)
	  	error('can not open input image file press CTRL-C to exit \n');
	  	pause
end
pix= fread(fid,inf,'uchar');
fclose(fid);

width=400; height=300;
N=width*height;

pix_R=zeros(1,N);
pix_G=zeros(1,N);
pix_B=zeros(1,N);
pix_gray=zeros(1,N);

for i=1:N*3
    if mod(i,3)==1
        pix_R((i+2)/3)=pix(i);
    end
    if mod(i,3)==2
            pix_G((i+1)/3)=pix(i);
        end
     if mod(i,3)==0
            pix_B(i/3)=pix(i);
     end
end

for i=1:N
    pix_gray(1,i)=0.21*pix_R(1,i)+0.72*pix_G(1,i)+0.07*pix_B(1,i);
end
    
G=zeros(width,height);
G(1:N)=pix_gray(1:N);

figure(1)
imshow(uint8(G'));

%1-b
htg=zeros(1,256);
x=[0:1/255:1];
for i=1:256
    for j=1:N
        if round(G(j))==(i-1)
            htg(i)=htg(i)+1;
        end
    end
end

figure(2)
bar(x,htg);
title('Original histogram');
axis([0,1,0,max(htg)]);

% linear scaling
G_ls=zeros(width,height);
for i=1:N
    if round(G(i))<50
        G_ls(i)=(255/49)*round(G(i));
   else
        G_ls(i)=255;
    end
end
htg_ls=zeros(1,256);
 for i=1:256
    for j=1:N
        if round(G_ls(j))==(i-1)
            htg_ls(i)=htg_ls(i)+1;
        end
    end
 end

figure(3)
imshow(uint8(G_ls)');

figure(4)
bar(x,htg_ls);
title(' Histogram after linear scaling');
axis([0,1,0,max(htg_ls)]);

% square root scaling
   G_srs=zeros(width,height);
for i=1:N
    if round(G(i))<50
        G_srs(i)=(255/sqrt(49))*sqrt(round(G(i)));
   else
        G_srs(i)=255;
    end
end
htg_srs=zeros(1,256);
 for i=1:256
    for j=1:N
        if round(G_srs(j))==(i-1)
            htg_srs(i)=htg_srs(i)+1;
        end
    end
 end

figure(5)
imshow(uint8(G_srs)');

figure(6)
bar(x,htg_srs);
title(' Histogram after square root scaling');
axis([0,1,0,max(htg_srs)]);         

% cumulative histogram equalization
cpd=zeros(1,256);
cpd(1,1)=htg(1,1)/N;
for i=2:256
    cpd(1,i)=cpd(1,i-1)+htg(1,i)/N;
end
G_che=zeros(width,height);
for i=1:256
    for j=1:N
    if round(G(j))==i
        G_che(j)=cpd(1,i)*255;
    end
    end
end
htg_che=zeros(1,256);
 for i=1:256
    for j=1:N
        if round(G_che(j))==(i-1)
            htg_che(i)=htg_che(i)+1;
        end
    end
 end
 figure(7)
imshow(uint8(G_che)');

figure(8)
bar(x,htg_che);
title(' Histogram after cumulative histogram equalization');
axis([0,1,0,max(htg_che)]);      

% digital implementation of histogram equalization
H=zeros(1,N);
q=floor(N/256);
G_di=zeros(width,height);
for i=0:255
    H(i*q+1:(i+1)*q)=i-255;
end
H((i+1)*q+1:N)=0;

G_di(1:N)=G(1:N);

count=1;
    for j=0:255
        for k=1:N
            if round(G_di(k))==j
               G_di(k)=H(count);
               count=count+1;
            end
        end
    end
    

        G_di(1:N)=G_di(1:N)+255;

htg_di=zeros(1,256);
 for i=1:256
    for j=1:N
        if round(G_di(j))==(i-1)
            htg_di(i)=htg_di(i)+1;
        end
    end
 end
 figure(9)
imshow(uint8(G_di)');

figure(10)
bar(x,htg_di);
title(' Histogram after digital implementation of histogram equalization');
axis([0,1,0,max(htg_di)]);      

%1-c
% local contrast enhancement
   G_lce=zeros(width,height);
for i=1:N
    if round(G(i))<150
        G_lce(i)=sqrt(149)*sqrt(round(G(i)));
   else
        G_lce(i)=G(i);
    end
end
htg_lce=zeros(1,256);
 for i=1:256
    for j=1:N
        if round(G_lce(j))==(i-1)
            htg_lce(i)=htg_lce(i)+1;
        end
    end
 end

figure(11)
imshow(uint8(G_lce)');

figure(12)
bar(x,htg_lce);
title(' Histogram after local contrast enhancement');
axis([0,1,0,max(htg_lce)]);         


