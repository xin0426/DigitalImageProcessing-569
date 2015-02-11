clear all;
close all;
clc;
F=readraw('peppers_mixed.raw');
Araw=readraw('peppers.raw');
imshow(uint8(F));




G1=lpf3_simple(F);
G2=lpf3_weighted(F);
G3=lpf5_simple(F);
G4=lpf5_weighted(F);

G5=outlier(F);

G6=med_square3(F);
G7=med_square5(F);
G8=med_plussign3(F);
G9=med_plussign5(F);

G10=med_square3(outlier(lpf5_weighted(F)));
G11=lpf5_weighted(outlier(med_square3(F))); 
G12=lpf5_weighted(outlier(med_plussign5(F))); 
G13=lpf5_weighted(outlier(med_plussign5(med_plussign5(F)))); 


figure(2)
imshow(uint8(G1));

figure(3)
imshow(uint8(G2));

figure(4)
imshow(uint8(G3));

figure(5)
imshow(uint8(G4));

figure(6)
imshow(uint8(G5));

figure(7)
imshow(uint8(G6));

figure(8)
imshow(uint8(G7));

figure(9)
imshow(uint8(G8));

figure(10)
imshow(uint8(G9));

figure(11)
imshow(uint8(G10));

figure(12)
imshow(uint8(G11));

figure(13)
imshow(uint8(G12));

figure(14)
imshow(uint8(G13));


[SSIM1,E1,SSIM_avr1]=ssim(Araw,G10);
[SSIM2,E2,SSIM_avr2]=ssim(Araw,G11);
[SSIM3,E3,SSIM_avr3]=ssim(Araw,G12);
[SSIM4,E4,SSIM_avr4]=ssim(Araw,G13);

PSNR1=psnr(Araw,G10);
PSNR2=psnr(Araw,G11);
PSNR3=psnr(Araw,G12);
PSNR4=psnr(Araw,G13);



