function [mn st] = bg_model(f)
% Example using:   [mn st] = bg_model('002.mpg');

reader = mmreader(f);                   % videoyu framelerine ayırmak için okuma değişkenine ata
N = get(reader, 'numberOfFrames') - 1;  % video içerisinde kaç frame olduğunu ata
frames = read(reader, [1, N]);          % videonun N adet frameni oku ve ata

[R, C, L] = size(frames(:, :, :, 1));   % frameler için satır ve sütun sayılarını al (R=satır sayısı ve C=sütun sayısı olarak ata)
I_mn = uint8([]);                       % framelerin pixel ortalamalarının tutulacağı değişken
I_st = [];                              % framelerin pixel standart sapmalarının tutulacağı değişken
for r = 1 : R
    for c = 1 : C
        pixel_rc = {[] [] []};          % framelerin her bir pixelinin kırmızı, yeşil, mavi değerlerini tutmak için ceil(hücre) kullan
        for i = 1 : N
            pixel_rc{1}(i) = frames(r, c, 1, i); % her bir framenin r satır, c sütun numaraları kırmızı renk değerini al
            pixel_rc{2}(i) = frames(r, c, 2, i); % her bir framenin r satır, c sütun numaraları yeşil renk değerini al
            pixel_rc{3}(i) = frames(r, c, 3, i); % her bir framenin r satır, c sütun numaraları mavi renk değerini al
        end
        I_mn(r, c, 1) = mean(pixel_rc{1});       % framelerin r satır, c sütun numaraları kırmızı renk değerlerinin ortalamasını hesapla
        I_mn(r, c, 2) = mean(pixel_rc{2});       % framelerin r satır, c sütun numaraları yeşil renk değerlerinin ortalamasını hesapla
        I_mn(r, c, 3) = mean(pixel_rc{3});       % framelerin r satır, c sütun numaraları mavi renk değerlerinin ortalamasını hesapla
        I_st(r, c, 1) = std(pixel_rc{1});        % framelerin r satır, c sütun numaraları kırmızı renk değerlerinin standart sapmasını hesapla
        I_st(r, c, 2) = std(pixel_rc{2});        % framelerin r satır, c sütun numaraları yeşil renk değerlerinin standart sapmasını hesapla
        I_st(r, c, 3) = std(pixel_rc{3});        % framelerin r satır, c sütun numaraları mavi renk değerlerinin standart sapmasını hesapla
    end
end

mn = I_mn; % dönüş değerlerine ata
st = I_st; % dönüş değerlerine ata
