function [bw , index , hata] = arkaplan_cikarimi2(video_yolu,fr_aralik)
    %% objemizi okuyoruz.
    
    obje = mmreader(video_yolu);
    %% arkaplan ortalamasý ve standart sapmasý
    
    [mn st] = bg_model(video_yolu,[fr_aralik(1) fr_aralik(2)]);
    
    %% Frame sayýsýný alýyoruz. Ve tüm frameleri okuyoruz.
 
    num = get(obje, 'numberOfFrames'); % En son frame'in index numarasýný verir.
    frame = read(obje,[1 num]);
    
    %% Frame'lerin boyutlarýný alýyoruz.
    [R C L] = size(read(obje,num));
    bw = {};
    Oan = [];
    hata = 0;
    for fr_no = 1:num

        temp = double(ones(R,C));
    %%  Ortalama ile Standart Sapma Etkileþimi
    % a=double(mn{1})+ st{1}*x; Ortalama Frame'in RED kýsmýnýn standart
    % miktarý kadar üst sýnýrý belirtilmiþtir.
    % b=double(mn{1})- st{1}*x; Ýfadesinde ortalama frame'in RED kýsmýnýn
    % alt sýnýrýnýn belirlenmesi yapýlmýþtýr.
    % c deðeri Green kýsmýnýn üst deðeri, d ise Green bileþeninin alt
    % sýnýrýný belirtmektedir.
    % e ve g deðerleride benzer þekilde Blue bileþeni için yapýlmýþtýr.
    %
        f1 = double(mn{1}) - double(frame(:,:,1,fr_no));
        f2 = double(mn{2}) - double(frame(:,:,2,fr_no));
        f3 = double(mn{3}) - double(frame(:,:,3,fr_no));
    %% Geçici deðiþken kalýcý yapýlmýþtýr.
    % Geçici deðerleri taþýyan temp dizisi bw cell'inde kalýcý hale
    % getirilmiþtir.
    
        temp(abs(sqrt(f1.^2 + f2.^2 + f3.^2) - sqrt(st{1}.^2+st{2}.^2+st{3}.^2)) < 60) = 0;
        [bw{fr_no}, Oan] = temiz(temp, fr_no, Oan);
    end
    if length(Oan) == 0
        hata = 1;
        index = 0;
    else
        [index, hata] = eleme(bw,Oan);
    end
    index=min(index);
    