function unut(son)

    for a=1:140
        label = bwlabel(son{a});         
        U = unique(label);
       
        if length(U) == 2
            fprintf('Çanta elde.\n');
        
        elseif length(U) == 3
            fprintf('Çanta bırakıldı.\n');
        end
    end  
end