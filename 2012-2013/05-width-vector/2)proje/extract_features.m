%% documentation 
%
%
function data = extract_features(bw,dbg)
    bw = imfill(bw, 'holes');
    q = bw;
    q(:,2:end) = bw(:,1:end -1);
    q = q + (q == -1);
    if true
        figure(1);
            subplot(221), imshow(bw)
            subplot(222), imshow(bw)
            subplot(223), imshow(q)
            subplot(224), imshow(q - bw)
    end
    data = q; 
end
%% helpers funcs
%
%
