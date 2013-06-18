function [mn, st] = bg_model(F)
    L = length(F);  % frame sayisi
    [R C] = size(F{1}(:,:,1)); % bir frame'in satir sutun sayisi

    sum_Red = double(zeros(R, C)); 
    sum_Green = double(zeros(R, C));
    sum_Blue = double(zeros(R, C));
    
    Red = cell(1, L); % framelerin kýrmýzý bilesenlerini tutmak icin 
    Green = cell(1, L); % framelerin yesil bilesenlerini tutmak icin 
    Blue = cell(1, L); % framelerin mavi bilesenlerini tutmak icin 
    for i = 1: L
        Red{i} = double(F{i}(:,:,1));     %frame'in R si 
        Green{i} = double(F{i}(:,:,2));   %frame'in G si
        Blue{i} = double(F{i}(:,:,3));    %frame'in B si
        
        sum_Red = Red{i} + sum_Red;       % R frameleri toplamý
        sum_Green = Green{i} + sum_Green; % G frameleri toplamý
        sum_Blue = Blue{i} + sum_Blue;    % B frameleri toplamý
    end
    
    mn{1} = sum_Red/L;   % tum framelerin R lerinin ortalamasý
    mn{2} = sum_Green/L; % tum framelerin G lerinin ortalamasý
    mn{3} = sum_Blue/L;  % tum framelerin B lerinin ortalamasý
    
    %standart sapma hesabý
    std_sapma = cell(1, 3); % R, G ve B icin 3 boyutlu cell
    std_sapma{1} = double(zeros(R, C));
    std_sapma{2} = double(zeros(R, C));
    std_sapma{3} = double(zeros(R, C));
    for i = 1: L
        std_sapma{1} = std_sapma{1} + ( Red{i} - mn{1}).^2;     % R frame'leri std hesabi
        std_sapma{2} = std_sapma{2} + ( Green{i} - mn{2}).^2; % G frame'lerinin ayni noktadaki piksellerini grupla
        std_sapma{3} = std_sapma{3} + ( Blue{i} - mn{3}).^2;   % B frame'lerinin ayni noktadaki piksellerini grupla
    end
    std_sapma{1} = sqrt(std_sapma{1}/(L-1));
    std_sapma{2} = sqrt(std_sapma{2}/(L-1));
    std_sapma{3} = sqrt(std_sapma{3}/(L-1));
    
    st = std_sapma;
    % standart sapma sonu