function [y_resimler] =  bg_arka(video,mn,st)
        
        dir_name = 'frames';
        mkdir(dir_name);
        
        mov = aviread(video);
        sz = size(mov,2);
        for k=1:sz
            imageArray{k} = frame2im(mov(k));
        end
        
        ortalamaresim(:,:,1) = mn{1}; 
        ortalamaresim(:,:,2) = mn{2};    % Burada ise bg_model fonksiyonundan elde ettiğimiz ortalama degerlerden                   
        ortalamaresim(:,:,3) = mn{3};    % ortalama bir resim elde ettik. 
        
        standartresim(:,:,1) = st{1};
        standartresim(:,:,2) = st{2};    % Burada ise yine bg_model fonksiyonundan elde ettiğimiz standart sapmaları resim ile aynı boyutta
        standartresim(:,:,3) = st{3};    % dizinin içene attık. 
       
        for i=1:sz
           resim(:,:,1) = imageArray{i}(:,:,1);   % Okuduğumuz frameleri cikarilmisresim dizisinde topladık.  
           resim(:,:,2) = imageArray{i}(:,:,2);
           resim(:,:,3) = imageArray{i}(:,:,3);
           cikarilmisresim{i} = resim;                     
            
        end
        
        [R C L] = size(imageArray{1});
        
        for j=1:sz
             for r=1:R
                for c=1:C     
                     g(r,c) = abs(double(cikarilmisresim{j}(r,c,2)) - ortalamaresim(r,c,2)); % Fark resmini elde ettik.
                     
                     if g(r,c)>standartresim(r,c)*17    % Burada ise fark resmimizin piksel piksel standart sapma değerlerine göre 
                        g(r,c)=1;                       % arkaplan modellemesi yaptık.
                     else
                        g(r,c)=0;
                     end                     
                end    
             end
             resimler{j} = not(g);
        end
        
        Y = zeros(R, C);
        l = 1;
       
        for m=1:sz
        
            Y = resimler{m};
            se = strel('disk',7);
            Y = imclose(Y, se);

            Y = bwlabel(Y);
            label = unique(Y(Y ~= 0));

            for k = 1:length(label)
                area(k) = length(find(Y == k));
            end

            for k = 1:length(label)
                if area(k) < 1000
                    Y(Y == k) = 0;
                end
            end
            y_resimler{l} = Y;
            l = l + 1;	
            
            frame_name = strcat(dir_name, '/frame', num2str(m), '.png'); 	% Frame ismi ata
            imwrite(Y, frame_name, 'png');    
        end
