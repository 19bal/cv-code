function Oan = enkars(bw, Suan)

    Oan = [];
    Bound = [];
    Eccen = [];
         
    for i = 1:length(Suan)
        f = regionprops(bw{Suan(i)},'BoundingBox');
        g = regionprops(bw{Suan(i)},'Eccentricity');
        for j = 1:length(f)
            if f(j).BoundingBox(3) > 0
                x = j;
            end     
        end
        Bound(i) = f(x).BoundingBox(3);
        Eccen(i) = g(x).Eccentricity;
    end
    
    Bgecici = sort(unique(Bound));
    Bgecici = Bgecici(1:x*5);
    Egecici = sort(unique(Eccen),'descend');
    Egecici = Egecici(1:x*5);
    
    for i = 1:length(Bound)
        if sum(Bgecici == Bound(i)) && sum(Egecici == Eccen(i))
            Oan(length(Oan)+1) = Suan(i);
        end
    end
    