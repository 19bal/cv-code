function [im_av sapma] = oku(f)

    frames = mmreader(f);                   % videonun framelere ayrýlmasý
    len_frames = frames.NumberOfFrames;     % frame sayýsý
    
    for i=1:10
        data{i}=read(frames,i);             % framelerin dataya aktarýlmasý
    end
    imshow(data{2});
    r = cell(10,1);                 
    g = cell(10,1);      % R,G,B renk bileþenlerinin tutulacaðý deðiþkenler         
    b = cell(10,1);       
    for j=1:10
   
        r{j} = double(data{j}(:,:,1)); 
        g{j} = double(data{j}(:,:,2));
        b{j} = double(data{j}(:,:,3));              % framelerin renk bileþenlerine ayrýlmasý
    end
    
    [C R L] = size(data{1});                % bir framenin boyutunun alýnmasý

    sumr=double(zeros(C,R));                        % kýrmýzý renk bileþeninin tutulacaðý matris
    sumg=double(zeros(C,R));                        % yesil renk bileþeninin tutulacaðý matris
    sumb=double(zeros(C,R));                        % mavi renk bileþeninin tutulacaðý matris
  
   
    

    for m=1:10
        sumr = sumr + double(r{m});         
        sumg = sumg + double(g{m});         % tüm framelerin bileþenlerinin toplanmasý
        sumb = sumb + double(b{m});
        
    end
    
    meanr = sumr/10;    
    meang = sumg/10;                % framelerin  ortalama renk bileþen deðerlerinin hesaplanmasý
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
        s_sapma{2} = s_sapma{2} +  ( g{i}   - mn{2}).^2;    % R,G,B için konumdaki piksellerin gruplanmasý
        s_sapma{3} = s_sapma{3} +  ( b{i}   - mn{3}).^2;    
    end
    
    
    
    s_sapma{1} = sqrt(s_sapma{1}/(10-1));
    s_sapma{2} = sqrt(s_sapma{2}/(10-1));   % R,G,B için standart sapma hesaplanmasý
    s_sapma{3} = sqrt(s_sapma{3}/(10-1));
    
    sapma = cell(1,1);
    sapma{1} = double(zeros(C,R));
    sapma{1}(:,:,1)=s_sapma{1};
    sapma{1}(:,:,2)=s_sapma{2};
    sapma{1}(:,:,3)=s_sapma{3};
    
    st = sapma;
    
