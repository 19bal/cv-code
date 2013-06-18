function [ frames eylem mesage]  = bg_model(f)
    frames = mmreader(f);                   
    len_frames = frames.NumberOfFrames;     
    
    for i=1:len_frames
        data{i}=read(frames,i);             
    end
    
    [C R L] = size(data{1});                
   
    [im_av st] = oku('1.avi'); % ortalama resim ve standart sapmay� d�nen fonksiyonun �a�r�lmas�
    
    for k=1:len_frames
         
          data{k} = double(data{k});
          fark{k}= im_av-data{k};  % her framenin ortalama de�erden ��kar�lmas�
    end
      
   
    for z=1:len_frames
        for t=1:C
            for q=1:R
                if (fark{z}(t,q,1) / st{1}(t,q,1))>=22 || (fark{z}(t,q,2) / st{1}(t,q,2)>=22) || (fark{z}(t,q,3) / st{1}(t,q,3))>=22;

                    fark{z}(t,q,1)=1;            
                    fark{z}(t,q,2)=1;           
                    fark{z}(t,q,3)=1;            
                else
                    fark{z}(t,q,1)=0;           
                    fark{z}(t,q,2)=0;
                    fark{z}(t,q,3)=0;
                end

            end
        end
        fark{z} = imfill(fark{z},'holes');       
        se = strel('square',20);                 
        new{z} = imerode(fark{z},se);            
        new2{z} = imdilate(new{z},se);          
        new3{z} = imdilate(new2{z},se);     
        
        data{z} = im2bw(new3{z});
        lb{z} = bwlabel(data{z});
        retData{z} = regionprops(lb{z},'Area');
        areas{z} = [retData{z}.Area];
        index{z} = find(areas{z} < 1000);
        areas{z}(index{z}) = 0;
        temp{z} = uint8(zeros(size(lb{z})));
        for m=1:length(areas{z})
            
            if areas{z}(m)~= 0
                temp{z}(lb{z}==m)=255;
            else
                temp{z}(lb{z}==m)=0;
            end
        end

        
        
    end
      frames = temp;
     
     

% Bundan sonraki i�lemlerde  eylemin ger�ekle�ip ger�ekle�medi�i kontrol
% ediliyor.

for p=1:len_frames
    clr{p} = im2bw(temp{p});
    clr{p} = bwlabel(clr{p});
    data_props{p} = regionprops(clr{p},'boundingbox');
    vektor_oran{p} = [data_props{p}.BoundingBox];
    oran{p} = vektor_oran{p}(3)/vektor_oran{p}(4);
    if oran{p} > 0.5 && oran{p} < 0.7
        eylem{p} = 1;
        mesage{p} = 'Yumruk atma eylemi ger�ekle�iyor ...';
    else
        eylem{p} = 0;
        mesage{p} = 'Eylem Yok ...';
    end
end


end



