%% documentation 
%
%
function data = extract_features(bw,dbg)
        
    rp = regionprops(bw,'BoundingBox');
    bb  =  [rp.BoundingBox];
    figure(); imshow(bw);
    hold on;
    h = rectangle('Position',bb,'LineWidth',2);
    set(h,'EdgeColor',[.9 0 0]);
    plot(bb(1),bb(2), 'O');
    plot(bb(1)+ bb(3),bb(2), 'O');
    plot(bb(1),bb(4), 'O');
    plot(bb(1)+ bb(3),bb(4), 'O');
    hold off;
    %dikdörtgen içine alýnan insanýn görüntü üzerindeki koordinatlarý
    data = [ bb(1),bb(2); 
             bb(1)+ bb(3),bb(2); 
             bb(1),bb(4); 
             bb(1)+ bb(3),bb(4)];
end
%% helpers funcs
%
%
