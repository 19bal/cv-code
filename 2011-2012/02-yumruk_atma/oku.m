function [im_av sapma] = oku(f)

    frames = mmreader(f);                   % videonun framelere ayrılması
    len_frames = frames.NumberOfFrames;     % frame sayısı
    
    for i=1:10
        data{i}=read(frames,i);             % framelerin dataya aktarılması
    end
    imshow(data{2});
    r = cell(10,1);                 
    g = cell(10,1);      % R,G,B renk bileşenlerinin tutulacağı değişkenler         
    b = cell(10,1);       
    for j=1:10
   
        r{j} = double(data{j}(:,:,1)); 
        g{j} = double(data{j}(:,:,2));
        b{j} = double(data{j}(:,:,3));              % framelerin renk bileşenlerine ayrılması
    end
    
    [C R L] = size(data{1});                % bir framenin boyutunun alınması

    sumr=double(zeros(C,R));                        % kırmızı renk bileşeninin tutulacağı matris
    sumg=double(zeros(C,R));                        % yesil renk bileşeninin tutulacağı matris
    sumb=double(zeros(C,R));                        % mavi renk bileşeninin tutulacağı matris
  
   
    

    for m=1:10
        sumr = sumr + double(r{m});         
        sumg = sumg + double(g{m});         % tüm framelerin bileşenlerinin toplanması
        sumb = sumb + double(b{m});
        
    end
    
    meanr = sumr/10;    
    meang = sumg/10;                % framelerin  ortalama renk bileşen değerlerinin hesaplanması
    meanb = sumb/10;
    mn{1} = meanr;
    mn{2} = meang;
    mn{3} = meanb;
    
    im_av(:,:,1)=mn{1};
    im_av(:,:,2)=mn{2};
    im_av(:,:,3)=mn{3};
    
     s_sapma = cell(1,3);
     
    s_sapma{1} = double(zeros(C, R));  
    s_sapma{2} = double(zeros(C, R));   % R,G,B için cell
    s_sapma{3} = double(zeros(C, R));
    for i = 1: 10
        s_sapma{1} = s_sapma{1} +  ( r{i}   - mn{1}).^2;   
        s_sapma{2} = s_sapma{2} +  ( g{i}   - mn{2}).^2;    % R,G,B için konumdaki piksellerin gruplanması
        s_sapma{3} = s_sapma{3} +  ( b{i}   - mn{3}).^2;    
    end
    
    
    
    s_sapma{1} = sqrt(s_sapma{1}/(10-1));
    s_sapma{2} = sqrt(s_sapma{2}/(10-1));   % R,G,B için standart sapma hesaplanması
    s_sapma{3} = sqrt(s_sapma{3}/(10-1));
    
    sapma = cell(1,1);
    sapma{1} = double(zeros(C,R));
    sapma{1}(:,:,1)=s_sapma{1};
    sapma{1}(:,:,2)=s_sapma{2};
    sapma{1}(:,:,3)=s_sapma{3};
    
    st = sapma;
    
