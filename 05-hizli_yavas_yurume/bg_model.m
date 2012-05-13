function [mn st] = bg_model(video)
    
     mov = aviread(video);
     sz = size(mov,2);
     
     for k=1:sz
         imageArray{k} = frame2im(mov(k));
     end

    for j=1:10                                   
        r{j} = imageArray{j}(:,:,1); 
        g{j} = imageArray{j}(:,:,2);
        b{j} = imageArray{j}(:,:,3);              % Framelerin renk bileşenlerine ayrılması
    end
    
    [R C L] = size(imageArray{1});                % Bir frame'in boyutunun alınması

    sumr = zeros(R, C);                           % Kırmızı renk bileşeninin tutulacağı matris
    sumg = zeros(R, C);                           % Yesil renk bileşeninin tutulacağı matris
    sumb = zeros(R, C);                           % Mavi renk bileseninin tutulacağı matris
    
    for i = 1: 10                                 
        sumr = sumr + double(r{i});         
        sumg = sumg + double(g{i});               % Tüm framelerin bileşenlerinin toplanması
        sumb = sumb + double(b{i}); 
    end
    for x = 1:R
        for y = 1:C
            for m=1:10                      
                rc_r{x, y}(m) = double(r{m}(x,y));  
                rc_g{x, y}(m) = double(g{m}(x,y));       % Framelerde, aynı piksellerde bulunan değerlerin tutulması
                rc_b{x, y}(m) = double(b{m}(x,y));
            end
        st{1}(x,y) = std(rc_r{x,y});
        st{2}(x,y) = std(rc_g{x,y});                     % Tüm framelerin ayrı ayrı standart sapmalarının hesaplanması
        st{3}(x,y) = std(rc_b{x,y}); 
        end
    end

    mn{1} = sumr/k;    
    mn{2} = sumg/k;                			 % Framelerin  ortalama renk bileşen değerlerinin hesaplanması
    mn{3} = sumb/k;                              
