function son = arka(video, mn, st)

    reader = mmreader(video);
    N = get(reader, 'numberOfFrames') - 1;          % video içerisinde kaç frame olduğunu ata
    frames = read(reader, [1, N]);                  % videonun N adet frameni oku ve ata

    [R, C, L] = size(frames(:, :, :, 1));
    
        ortalamaresim(:,:,1) = mn{1}; 
        ortalamaresim(:,:,2) = mn{2};               % oku fonksiyonunda elde ettiğimiz ortalama değerlerden
        ortalamaresim(:,:,3) = mn{3};               % ortalama bir resim elde edilir.
        
        standartresim(:,:,1) = st{1};
        standartresim(:,:,2) = st{2};               % oku fonksiyonunda elde ettiğimiz standart sapmaları resim ile aynı boyutta
        standartresim(:,:,3) = st{3};               % dizinin içine atıldı. 

        for i=1:N
           resim(:,:,1) = frames(:,:,1,i);
           resim(:,:,2) = frames(:,:,2,i);
           resim(:,:,3) = frames(:,:,3,i);
           cikarilmisresim{i} = resim;
  
        end
        
        for j=160:300                               % Framelerde figüran olan kısım alındı.
             for r=1:R
                for c=1:C     
                     g(r,c) = abs(double(cikarilmisresim{j}(r,c,2)) - ortalamaresim(r,c,2)); % Fark resmi elde edildi.
                     if g(r,c)>standartresim(r,c)*30    % Fark resminin piksel piksel standart sapma değerlerine göre 
                        g(r,c)=1;                       % arkaplan modellemesi yapılır.
                     else
                        g(r,c)=0;
                     end     
                end    
             end
             
             resimler{j}=g;
        end
            
        Y = zeros(R, C);
        d = 1;
       
        for m=160:300        
            Y = resimler{m};
            se = strel('disk',5);
            Y = imopen(Y, se);
            Y = imdilate(Y, se);
            Y = imerode(Y, se);
            Y = imopen(Y, se);
            
            Y = bwlabel(Y);
            label = unique(Y(Y ~= 0));

            for k = 1:length(label)
                area(k) = length(find(Y == k));
            end

            for k = 1:length(label)
                if area(k) < 750
                    Y(Y == k) = 0;
                end
            end
            son{d} = Y;
            d = d + 1;
        end
