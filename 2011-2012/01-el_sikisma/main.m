function el_sikisma_frame = main(bg_video_yolu, fg_video_yolu, frame_aralik)
    
%% arka plan cýkarmak icin olan bolum
% [fr_num bw]
    obj = mmreader(bg_video_yolu);
    bas_frame_num = frame_aralik(1);
    son_frame_num = frame_aralik(2);
    vframes = read(obj, [bas_frame_num son_frame_num]);
    
    Fbg = cell(1, son_frame_num - bas_frame_num+1);
    
    for i = 1: son_frame_num - bas_frame_num+1
        Fbg{i} = vframes(:,:,:,i);
    end
    [mn std] = bg_model(Fbg);       % arka plan icin mean ve std hesapla

    
%% arka plana gore kisileri ayýrt eden bolum 
    obj = mmreader(fg_video_yolu);
    vframes = read(obj);
    num_frame = size(vframes, 4);   % video frame sayisi
    Ffg = cell(1, num_frame);
    
    for i = 1: num_frame
        Ffg{i} = vframes(:,:,:,i);
    end
    bw = bw_nesne(Ffg, mn, std);       % on planý arka plandan ayýrt et

%% buyuk alana sahip frameleri ayikla
    fr_num = ayikla(bw);
    
%% el sikisma olup olamadýgýný kontrol et
    el_sikisma_frame = kontrolet(bw, fr_num);
