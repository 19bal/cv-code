function v=hareket_tesbit(resim)
   [X Y] = size(resim);
    H = X; %resmin yuksekligi
    bound = regionprops(resim, 'BoundingBox');
    adet = size(bound);

    if(adet(1) ~= 0  && adet(1) == 1)
        
        if(bound.BoundingBox(4) >= H )
            resim([1:round(H/2)],:) = 0;
            alan = regionprops(resim, 'Area');

            if(length(cat(1,alan.Area)) == 1)

                bound = regionprops(resim, 'BoundingBox');
                eccen = regionprops(resim, 'eccentricity');
                L = bound.BoundingBox(1);% en soldaki pikselin x koordinati
                R = bound.BoundingBox(1) + bound.BoundingBox(3);% en sagdaki pikselin x kordinati
                w = R-L;
                v = 1
                if(w > 25 && alan.Area < 270 && w < 40 && eccen.Eccentricity<0.85)
                    v = 2;
                else
                    v = 0;
                end
            else
                v = 0;
            end
        else
            v = 0;
        end
    else
        v = 3;
    end
end