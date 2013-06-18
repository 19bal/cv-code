function [mn,st] = bg_model(konum,frames)
    %konum=videonun yolunu belirtcez uzantýsýyla beraber
    %frames ise frame araligi demek mesela [1 2] yi arguman veririseniz 1.
    %ve 2. frameyi kullaný1 [1 100] verirseniz 1-100 arasi 100 tane frameyi alýr
    %frames 2 li deger iceriyor frames(2)-frames(1)+1 tane frame demek
    
    bas = frames(1); 
    son = frames(2);
    
    
    video = mmreader(konum);  % video'yu okuyoruz
    frame = read(video,[bas son]); % belirttigimiz araliklardaki frameleri aliyoruz
    
    [R C] = size(read(video,1));
    
    tasiyici = double(frame(:,:,:,1).*0); % frame boyutunda 0 degerli frame olusturuyoruz
    tasiyici2 = double(frame(:,:,:,1).*0);
    
    for i = bas:son % ortalamayi bulan kisim
        tasiyici = tasiyici + double(frame(:,:,:,i)); % tum frameler deki piksel degerlerini tek bir frame uzerinde topluyoruz        
    end
    ort_resim = double( tasiyici.* (1/(son - bas + 1)) ); % toplamini aldigimiz fram'i frame sayisina boluyoruz
    
    % standart sapma formulu:
    % -----------------------
    % varyans = [(x1-ort)^2+(x2-ort)^2+(x3-ort)^2.....+(xn-ort)^2]/(n-1)
    % standart_sapma = sqrt(varyans)
    % asagidaki 22-28 arasindaki satirlarda bu formul gerceklenmistir
    
    for f = bas:son
        tasiyici2 = tasiyici2 + ((double(read(video,f)) - double(ort_resim)) .^2);   
    end
    
    stdsap = double(sqrt(tasiyici2 .* (1/(son - bas))));
    stdsap = stdsap + 1;
    % donus degerleri her bir RGB bileþeni icin cell formatinda
    % olusturulmustur
    mn = { ort_resim(:,:,1) ort_resim(:,:,2) ort_resim(:,:,3)};  % framedeki her bir pikselin r,g,b seklinde ortalamalarýný
    st = { stdsap(:,:,1) stdsap(:,:,2) stdsap(:,:,3) };
end
