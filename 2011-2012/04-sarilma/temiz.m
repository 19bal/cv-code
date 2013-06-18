function [temp , Oan ] = temiz(I, fr_no, Oan )
    
    maske = strel('disk',5);
    I = imopen(I,maske);
    temp = bwlabel(I);
    
    
    for i = 1:length(unique(temp))
        if length(temp( temp == unique(i) )) < 3000
            temp( temp == i ) = 0;
        end
        if length(temp( temp == unique(i) )) > 6500
            Oan(length(Oan) + 1) = fr_no;
        end
    end