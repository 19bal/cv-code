%% documentation 
% Siluet resim dizisindeki resimlere 3x3'luk Gauss Filtresi 0.5 
% standart sapma degeriyle uygulanarak Magnitude elde edilir.
% Magnitude'un esiklenmesiyle BF (binary flow image) uretilir.
% BF nin averaji bize GFI(gait flow image)'yi verir.
%%

function [data] = extract_features(bw,dbg)

% Gait Period
 s = regionprops(bw,'Area','BoundingBox');
 GP = [s.Area];
 
 for z = 1:length(GP)
     if  min(GP(z)) 
         periyot_number = z;
     end
 end
     
    
 % optical flow hesaplama
 
 [x,y] = size(bw);
 GFI = [x,y];
 
 h1 = fspecial('gaussian',[3 3],0.5);
 
 
 % magnitude
 magnitude = imfilter(bw, h1, 'replicate');
 
 % BF binary flow image
 BF = bw;
 [r,c] = size(BF);
 
 for x = 1:r
     for y = 1:c
         if magnitude(x,y) >= 1
             BF(x,y) = 0;
         else
             BF(x,y) = 1;
         end    
     end
 end
 
 
 
 % GFI : gait flow image
 % N : frame sayisi
 % GFI(x,y) = [BF_1(x,y) +...+ BF_N-1(x,y)] / N 
 
 for i=1:r
     for j= 1:c
        for N = 1:z
            GFI (i,j)= BF(i,j)/N;
        end
     end
 end

    
    %if dbg
    %    figure(1);
     %       imshow(I)
            %subplot(222), imshow(bw)
            %subplot(223), imshow(bw)
           % subplot(224), imshow(bw)
           %pause
    %end
 
    
 %data 
 data = GFI;
 
 
  
end

%% helpers funcs
%