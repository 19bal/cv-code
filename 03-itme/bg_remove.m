function bw = bg_remove(fg, mn, st)
% Example using:   bg_remove('006.mpg', '002.mpg')

% [mn st] = bg_model(bg);
reader = mmreader(fg);                  % videoyu framelerine ayırmak için okuma değişkenine ata
N = get(reader, 'numberOfFrames') - 1;  % video içerisinde kaç frame olduğunu ata
frames = read(reader, [1, N]);          % videonun N adet frameni oku ve ata

[R, C, L] = size(frames(:, :, :, 1));   % frameler için satır ve sütun sayılarını al (R=satır sayısı ve C=sütun sayısı olarak ata)

k = 26;
for i = 1 : N
    F1 = double(mn(:, :, 1)) - k*st(:, :, 1); % her framenin kırmızı değerlerinin ortalama kırmızı değerlerden farkını al
    T1 = double(mn(:, :, 1)) + k*st(:, :, 1); % her framenin kırmızı değerlerinin ortalama kırmızı değerlerden farkını al
    F2 = double(mn(:, :, 2)) - k*st(:, :, 2); % her framenin yeşil değerlerinin ortalama yeşil değerlerden farkını al
    T2 = double(mn(:, :, 2)) + k*st(:, :, 2); % her framenin yeşil değerlerinin ortalama yeşil değerlerden farkını al
    F3 = double(mn(:, :, 3)) - st(:, :, 3);   % her framenin mavi değerlerinin ortalama mavi değerlerden farkını al
    T3 = double(mn(:, :, 3)) + st(:, :, 3);   % her framenin mavi değerlerinin ortalama mavi değerlerden farkını al

    Y = ones(R, C);
    P1 = frames(:, :, 1, i);
    P2 = frames(:, :, 2, i);
    P3 = frames(:, :, 3, i);

    Y((T1 >= P1 & P1 >= F1) & (T2 >= P2 & P2 >= F2)) = 0; % mavi değer koşuluna gerek yok

    se = strel('disk', 5);
    Y = imopen(Y, se);
    Y = imclose(Y, se);

    label = bwlabel(Y);
    s = regionprops(label, 'Area');
    id = find([s.Area] > 900);
    Y = ismember(label, id);
    bw{i} = Y;
end
end
