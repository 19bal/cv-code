function fr_num = ayikla(bw)
    L = size(bw, 2);
    A_toplam = 0;
    maxalan = [];
    max_alan_fr_sayisi = 0;
    se = strel('square', 4);
    for i = 1: L    
        [maxalan(i), j] = alan_ayikla(bw{i});
        A_toplam = A_toplam + maxalan(i);
        max_alan_fr_sayisi = max_alan_fr_sayisi + j;
    end
    
    A_ort = A_toplam/max_alan_fr_sayisi;
    k = 1;
    fr_num = [];
    for i = 1: L
        if maxalan(i) > A_ort
            label = bwlabel(bw{i});         
            U = unique(label);
            for x = 1 : length(U)
                if length(label(label == x)) < maxalan(i)
                    label(label == x) = 0;
                end
            end
            bw{i} = label; 
            fr_num(k) = i;
            k = k + 1;
        end
    end
    
    function [A_max, j]= alan_ayikla(I)
        R = regionprops(I, 'Area');
        A_max = max([R.Area]);
        j = 1;
        if isempty(A_max)
            A_max = 0;
            j = 0;
        end