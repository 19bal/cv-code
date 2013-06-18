function BW = bw_nesne(F, mn, std)
    L = size(F, 2); % frame say�s�
    [r c] = size(mn{1}); % framelerin sat�r sutun say�s�n� al
    
    BW = cell(1, L);
    se = strel('disk', 3); % imopen islemi icin maske
    se1 = strel('square', 5);
    for i = 1: L
        BW{i} = uint8(ones(r, c));     % her framei bw yapmak icin oncelikle tumu 0 olan frame olustur
        BW{i} = not(im2bw(BW{i}));
     
        Rf = double(F{i}(:,:,1)) - mn{1};
        Gf = double(F{i}(:,:,2)) - mn{2};
        Bf = double(F{i}(:,:,3)) - mn{3};
        % Her piksel icin R G B degerlerinin ortalamadan standart sapman�n   
        % katsay�s� ile yap�lan alt ve ust aral�kta ise her framein 
        % o noktas�na 0 yaz.
        BW{i}(abs(sqrt(Rf.^2 + Bf.^2 + Gf.^2) - sqrt(std{1}.^2 + std{2}.^2 + std{3}.^2)) < 60) = 0;
        
        %BW{i} = imclose(BW{i}, se);     % kenarlar� duzeltmek icin closeing yap�yoruz
        BW{i} = imfill((BW{i}), 'holes');
        BW{i} = imopen(BW{i}, se);
        
        label = bwlabel(BW{i});         
        U = unique(label);
        for k = 1 : length(U)
            if length(label(label == k)) < 4000
                label(label == k) = 0;
            end
        end
        BW{i} = label; 
    end