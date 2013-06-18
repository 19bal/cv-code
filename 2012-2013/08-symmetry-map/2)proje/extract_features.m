%% documentation 
%
%
function data = extract_features(bw,dbg)

    [boy, en] = size(bw);
    say = 0;
    en_sag = 0;
    en_sol = 64;
    en_ust = 64;
    en_alt = 0;

    bw = bw(1:boy/2,:);

    for i=1:boy/2
        for j=1:en
            if (bw(i,j) == 1)
                if (en_ust > i)
                    en_ust = i;    
                elseif (en_alt < i)
                    en_alt = i;
                end
                
                if (en_sol > j)
                    en_sol = j;
                elseif (en_sag < j)
                    en_sag = j;
                end
            end
        end
    end

    k = 1;
    m = 1;

    for i=en_ust:en_alt
        for j=en_sol:en_sag    
            bw2(k,m) = bw(i,j);
            m = m + 1;
        end
        k = k + 1;
        m = 1;
    end

    % figure; imshow(bw2);

    %insan resmini kirptiktan sonra yeni olusan resim uzeriden islemler

    %simetrik olmayan noktalar belirleniyor

    [boy2, en2] = size(bw2);
    for i=1:boy2-1
        for j=1:en2-1
            if((bw2(i,j) == 1) && (bw2(i,en2-j) == 1))
                bw3(i,j) = 0;
            else
                bw3(i,j) = bw2(i,j);
            end

        % if((bw2(i,j) == 1) && (bw2(boy2-i,j) == 1))
        %     bw4(i,j) = 0;
        % else
        %     bw4(i,j) = bw2(i,j);
        % end

        end
    end
    % figure; imshow(bw3); % x eksenine göre simetrik olmayan noktalar

    % figure; imshow(bw4); % y eksenine göre simetrik olmayan noktalar
    % buna simdilik gerek yok. Sadece x eksenini baz alarak sonuca
    % ulasilabilir.

    data = [0 ,0 ,0 ,0];

    for i=1:boy2-1
        for j=1:en2-1
            if(bw3(i,j) == 1)
                if (j < en2/2)
                    data(1) = data(1) + j;
                else
                    data(2) = data(2) + (en2 - j);
                end

                if (i < boy2/2)
                   data(3) = data(3) + i;
                else
                    data(4) = data(4) + (boy2 -i);
                end
            end
        end
    end
    data

end

%% helpers funcs
%
%
