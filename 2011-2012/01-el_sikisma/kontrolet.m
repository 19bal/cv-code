function sonuc = kontrolet(bw, fr_num)
    L = length(fr_num);
    temp = [];
    k = 1;
    for i = 1: L
        R = regionprops(bw{fr_num(i)}, 'Eccentricity');
        U = unique(bw{fr_num(i)});
        if length(U) == 2
            if R(U(2)).Eccentricity >= 0 && R(U(2)).Eccentricity < 0.7
                temp(k) = fr_num(i);
                k = k + 1;
            end
        end
    end
    if ~isempty(temp)
        sonuc = temp(round(length(temp)/2));
    else
        sonuc = 0;
    end