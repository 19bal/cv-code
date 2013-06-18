function bg_kontrol(video1, video2)

    [mn st] = bg_model(video1);
    [y_resimler] = bg_arka(video2,mn,st);

    t = 1;
    liste = {};
    for a=1:40
        J =y_resimler{a};
        R = bwlabel(J);
        b = regionprops(R,'BoundingBox');
        liste{t} = b;
        t = t + 1;
    end
    
    p = 1;
    for m=15:40
        x = liste{m}.BoundingBox(3);
        b_aralik(p) = abs(x);
        p = p + 1;
    end
    
    maxdeger = max(b_aralik);
    
    if maxdeger < 200
        fprintf('Yavaş yürüyor.\n');
    else
        fprintf('Hızlı yürüyor.\n');
    end
         
end


