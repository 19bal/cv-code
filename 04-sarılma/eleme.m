function [index,hata] = eleme(bw, Oan)

    son_alan = [];
    maske = strel('square',3);
    hata = 0;
    
    Oan = enkars(bw, Oan);
    
    for i = 1:length(Oan)
        f = bwlabel(bw{Oan(i)});
        L = regionprops(f,'Area');
        son_alan(i) = max([L.Area]);
    end 
        
    index = Oan(find(son_alan == min(son_alan)));
    
    I = bw{index};
    
    for p = 1:2
        I = imerode(I,maske);
    end
    I = imopen(I,maske);
    I = bwlabel(I);

    if length(unique(I)) >= 3 || length(unique(I)) == 1
        hata = 1;
    else
        index;
    end