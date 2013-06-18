function [mn st] = oku(video)                        %sadece perdenin olduğu video okuma işlemi 

    reader = mmreader(video);                        % videoyu framelerine ayırmak için okuma değişkenine ata
    frames = read(reader, [1, 10]);

    [R C L] = size(frames(:,:,:,1));

    sum_Red = double(zeros(R, C));  
    sum_Green = double(zeros(R, C));
    sum_Blue = double(zeros(R, C));
    
    st = double([]);
    L = 10;
    Red = cell(L, 1);                               % framelerin kırmızı bileşenlerini tutmak için 
    Green = cell(L, 1);                             % framelerin yeşil bileşenlerini tutmak için 
    Blue = cell(L, 1);                              % framelerin mavi bileşenlerini tutmak için 
    
    for i = 1: L
        Red{i, 1} = double(frames(:,:,1,i)); 
        Green{i, 1} = double(frames(:,:,2,i));
        Blue{i, 1} = double(frames(:,:,3,i));
        sum_Red = Red{i, 1} + sum_Red;
        sum_Green = Green{i, 1} + sum_Green;
        sum_Blue = Blue{i, 1} + sum_Blue;
    end

    mn{1} = sum_Red/L;                              % tüm framelerin R lerinin ortalaması
    mn{2} = sum_Green/L;                            % tüm framelerin G lerinin ortalaması
    mn{3} = sum_Blue/L;                             % tüm framelerin B lerinin ortalaması

    piksel_Red = cell(L, 1);
    piksel_Green = cell(L, 1);
    piksel_Blue = cell(L, 1);

    st = cell(1, 3);                                % R, G ve B icin 3 boyutlu cell
    
    st{1} = double(zeros(R, C));
    st{2} = double(zeros(R, C));
    st{3} = double(zeros(R, C));
    
    for i = 1: R
        for j = 1: C
            for k = 1: L
                piksel_Red{i*j}(k) = Red{k}(i, j);     % R frame'lerinin ayni noktadaki piksellerini grupla
                piksel_Green{i*j}(k) = Green{k}(i, j); % G frame'lerinin ayni noktadaki piksellerini grupla
                piksel_Blue{i*j}(k) = Blue{k}(i, j);   % B frame'lerinin ayni noktadaki piksellerini grupla
            end
            st{1}(i, j) = std(piksel_Red{i*j}(:))+1;   % tum R framelerinde (i, j) noktasindaki piksellerin standart sapması
            st{2}(i, j) = std(piksel_Green{i*j}(:))+1; % tum G framelerde (i, j) noktasindaki piksellerin standart sapması
            st{3}(i, j) = std(piksel_Blue{i*j}(:))+1;  % tum B framelerde (i, j) noktasindaki piksellerin standart sapması 
        end
    end
end

