%% documentation 
%
%
function [data,res] = extract_features(bw,dbg)
% Duty factor makalesinde insan boyunun altyarısı ayaklarının oldugu kısımdır,
% fakat verisetinde hem insan hemde gölgesi olduğu için insan boyunun 4 e bolumunden
% üstten 3.cü parca ayaklardır mantıgıyla kodlama yapılmıştır.
% uygun resim geldiğinde alınan sonuc:
% orjınal: http://iceimg.com/i/68/14/e6f2d9cfe0.png
% işlem yapıldığında: http://iceimg.com/i/01/e4/0f9e3dd288.png

          points='';
          stat=regionprops(im2bw(bw),'BoundingBox');
          bbx=stat.BoundingBox;
         t=imcrop(bw,[bbx(1),(bbx(2)+bbx(4)/3),bbx(3),bbx(4)/3]);

         BW = edge(t,'sobel');
         I=im2bw(BW);
         bw2=bwperim(I,8);
          [x,y]=find(bw2==1);
          %figure(1);
          %imshow(I)
          %hold on
           k=1;
            for j=1:3:length(x)
                 %plot(y(j), x(j), 'r*');
                 points{k}=[x(j),y(j)];
                 k=k+1;
            end
        % hold off
         % ornekler al�nm�s resim
    %if dbg
    %    figure(1);
     %       imshow(I)
            %subplot(222), imshow(bw)
            %subplot(223), imshow(bw)
           % subplot(224), imshow(bw)
            %pause
    %end
    data = points;
    res=I;
end

%% helpers funcs
%
%
