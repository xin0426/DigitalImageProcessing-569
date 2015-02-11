clear all;
close all;
clc;

Graw=readraw('girl.raw');
Eraw=readraw('elaine.raw');

N=256;
% problem 3a
[Gr,Gc,Gr_nor,Gc_nor]=xgyg(Graw);
[Er,Ec,Er_nor,Ec_nor]=xgyg(Eraw);

figure()
imshow(uint8(Gr_nor));
title('x gradient of the girl.raw image');
figure()
imshow(uint8(Gc_nor));
title('y gradient of the girl.raw image');
        
figure()
imshow(uint8(Er_nor));
title('x gradient of the elaine.raw image');
figure()
imshow(uint8(Ec_nor));
title('y gradient of the elaine.raw image');
 
[htg_G,cdf_G,G_nor]=htgcdf(Gr,Gc);
[htg_E,cdf_E,E_nor]=htgcdf(Er,Ec);
x=[0:1/255:1];


t1=0.06;
t2=0.11;
t3=0.15;
G_edge1=edge(G_nor,cdf_G,t1);
G_edge2=edge(G_nor,cdf_G,t2);
G_edge3=edge(G_nor,cdf_G,t3);

E_edge1=edge(E_nor,cdf_E,t1);
E_edge2=edge(E_nor,cdf_E,t2);
E_edge3=edge(E_nor,cdf_E,t3);


figure()
imshow(uint8(G_edge1));

figure()
imshow(uint8(G_edge2));

figure()
imshow(uint8(G_edge3));

figure()
imshow(uint8(E_edge1));

figure()
imshow(uint8(E_edge2));

figure()
imshow(uint8(E_edge3));


%problem 3b
% LOG filter with zero-crossing
G_gau=gaussian(Graw);
G_lp=lp(G_gau);
G_Zerocrs1=Zerocrs(G_lp,4);
G_Zerocrs2=Zerocrs(G_lp,5);
G_Zerocrs3=Zerocrs(G_lp,6);

E_gau=gaussian(Eraw);
E_lp=lp(E_gau);
E_Zerocrs1=Zerocrs(E_lp,5);
E_Zerocrs2=Zerocrs(E_lp,6);
E_Zerocrs3=Zerocrs(E_lp,7);

figure()
imshow(uint8(G_Zerocrs1));

figure()
imshow(uint8(G_Zerocrs2));

figure()
imshow(uint8(G_Zerocrs3));


figure()
imshow(uint8(E_Zerocrs1));

figure()
imshow(uint8(E_Zerocrs2));

figure()
imshow(uint8(E_Zerocrs3));


% variance map
G_var=var(Graw);
E_var=var(Eraw);

figure()
imshow(uint8(G_var));
title('variance map of the girl.raw image');
figure()
imshow(uint8(E_var));
title('variance map of the elaine.raw image');

% Problem 3c Post Processing
for i=2:N-1
    for j=2:N-1
        if G_edge3(i,j)==0
          if Gr_nor(i,j)>Gc_nor(i,j)
            if G_edge3(i,j)<G_edge3(i,j+1) && G_edge3(i,j)==G_edge3(i,j-1)
                G_edge3(i,j)=255;
            end
                if G_edge3(i,j)==G_edge3(i,j+1) && G_edge3(i,j)<G_edge3(i,j-1)
                   G_edge3(i,j)=255;
                end
          end
        elseif Gr_nor(i,j)<Gc_nor(i,j)
               if G_edge3(i,j)<G_edge3(i+1,j) || G_edge3(i,j)==G_edge3(i-1,j)
                   G_edge3(i,j)=255;
                   end
                   if G_edge3(i,j)==G_edge3(i+1,j) || G_edge3(i,j)<G_edge3(i-1,j)
                G_edge3(i,j)=255;
                   end
           
          end
        end
end


    for i=2:N-1
    for j=2:N-1
        if E_edge3(i,j)==0
          if Er_nor(i,j)>Ec_nor(i,j)
            if E_edge3(i,j)<E_edge3(i,j+1) || E_edge3(i,j)==E_edge3(i,j-1)
                  E_edge3(i,j)=255;
                end
                if E_edge3(i,j)==E_edge3(i,j+1) || E_edge3(i,j)<E_edge3(i,j-1)
                E_edge3(i,j)=255;
                end
    
          end
        elseif Er_nor(i,j)<Ec_nor(i,j)
               if E_edge3(i,j)<E_edge3(i+1,j) || E_edge3(i,j)==E_edge3(i-1,j)
                    E_edge3(i,j)=255;
                   end
                   if E_edge3(i,j)==E_edge3(i+1,j) || E_edge3(i,j)<E_edge3(i-1,j)
                E_edge3(i,j)=255;
                   end
          end
        end
    end

figure()
imshow(uint8(G_edge3));
figure()
imshow(uint8(E_edge3));
                

    
        



