%% documentation 
% Siluet resim dizisindeki resimlere 3x3'luk Gauss Filtresi 0.5 
% standart sapma degeriyle uygulanarak Magnitude elde edilir.
% Magnitude'un esiklenmesiyle BF (binary flow image) uretilir.
% BF nin averaji bize GFI(gait flow image)'yi verir.
%%

function [data] = extract_features(bw,dbg)
 
 data = hareket_tesbit(bw);
 bw = double(bw);
 h1 = fspecial('gaussian',[3 3],0.5);
 
 % standart sapma degeriyle uygulanarak Magnitude elde edilir.
% Magnitude'un esiklenmesiyle BF (binary flow image) uretilir.
% BF nin averaji bize GFI(gait flow image)'yi verir.
%%
 % magnitude
 magnitude = imfilter(bw, h1, 'replicate');
 BF = bw;
 [r,c] = size(BF);
 bw(bw==255) = 0.49999;
 for x = 1:r
     for y = 1:c
         if magnitude(x,y) >= 1
             BF(x,y) = 0;
         else
             BF(x,y) = 1;
         end    
     end
 end
 
 data = bw;
end

%% helpers funcs
%