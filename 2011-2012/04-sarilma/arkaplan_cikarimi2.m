function [bw , index , hata] = arkaplan_cikarimi2(video_yolu,fr_aralik)
    %% objemizi okuyoruz.
    
    obje = mmreader(video_yolu);
    %% arkaplan ortalamas� ve standart sapmas�
    
    [mn st] = bg_model(video_yolu,[fr_aralik(1) fr_aralik(2)]);
    
    %% Frame say�s�n� al�yoruz. Ve t�m frameleri okuyoruz.
 
    num = get(obje, 'numberOfFrames'); % En son frame'in index numaras�n� verir.
    frame = read(obje,[1 num]);
    
    %% Frame'lerin boyutlar�n� al�yoruz.
    [R C L] = size(read(obje,num));
    bw = {};
    Oan = [];
    hata = 0;
    for fr_no = 1:num

        temp = double(ones(R,C));
    %%  Ortalama ile Standart Sapma Etkile�imi
    % a=double(mn{1})+ st{1}*x; Ortalama Frame'in RED k�sm�n�n standart
    % miktar� kadar �st s�n�r� belirtilmi�tir.
    % b=double(mn{1})- st{1}*x; �fadesinde ortalama frame'in RED k�sm�n�n
    % alt s�n�r�n�n belirlenmesi yap�lm��t�r.
    % c de�eri Green k�sm�n�n �st de�eri, d ise Green bile�eninin alt
    % s�n�r�n� belirtmektedir.
    % e ve g de�erleride benzer �ekilde Blue bile�eni i�in yap�lm��t�r.
    %
        f1 = double(mn{1}) - double(frame(:,:,1,fr_no));
        f2 = double(mn{2}) - double(frame(:,:,2,fr_no));
        f3 = double(mn{3}) - double(frame(:,:,3,fr_no));
    %% Ge�ici de�i�ken kal�c� yap�lm��t�r.
    % Ge�ici de�erleri ta��yan temp dizisi bw cell'inde kal�c� hale
    % getirilmi�tir.
    
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
    