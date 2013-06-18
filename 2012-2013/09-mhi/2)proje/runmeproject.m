function runme()
close all; clear all; clc;
dbg = ~true;
db = '../_db/';
db_64x64_fg = strcat(db, '64x64/Our_Foreground/');
db_64x64_mhi = strcat(db, '64x64/MHI/');
db_64x64_mei = strcat(db, '64x64/MEI/');
mkdir(db_64x64_mhi)
mkdir(db_64x64_mei)
dip_initialise('silent');

%% Datastore
load(strcat(db, 'datastore_64x64.mat'));

%% Seperation Points
% Ground Truth'lari yukle ve uzerine hesaplananlari ekle
%load(strcat(db, 'seperation_points_ground_truth.mat'));

psz = size(etiket, 3);
for pi=1:psz
    if true, fprintf('%03d/%03d. kisi isleniyor...\n', pi, psz); end
    ssz = cellsize(etiket, pi);
    for si=1:ssz
        if true, fprintf('\t%1d/%1d. seq isleniyor...\n', si, ssz);  end

        clear seq_frms;
        fsz = cellsize(etiket, pi, si);
        sz = size(imread(strcat(db_64x64_fg, db64x64_fnms{1, si, pi})));
        MHI = zeros(sz);
        MEI = zeros(sz);
        bwold = -1;
        for fi=1:fsz
            if true, fprintf('\t\t%03d/%03d. frame isleniyor...\n', fi, fsz);    end
            
            bw = imread(strcat(db_64x64_fg, db64x64_fnms{fi, si, pi}));
            seq_frms(:,:,fi) = bw;
            
            if(bwold ~= -1)
                MHI = MHI + deltaMHI(bw, bwold);
                MEI = MEI + deltaMEI(bw, bwold, fi);
            end
            bwold = bw;
            if dbg
                figure(1);
                    subplot(221), imshow(bw)
                    subplot(222), imshow(bwold)
                    subplot(223), imshow(deltaMHI(bw, bwold, dbg))
                    subplot(224), imshow(MHI)
                 pause(0.2)
                 figure(2);
                    subplot(221), imshow(bw)
                    subplot(222), imshow(bwold)
                    subplot(223), imshow(deltaMEI(bw, bwold, dbg))
                    subplot(224), imshow(MEI)
                 pause(0.2)
            end
        end
        features{fi, si}.mei = MHI;
        features{fi, si}.mhi = MEI;
        imwrite(MHI , strcat(db_64x64_mhi, db64x64_fnms{fi, si, pi}))
        imwrite(MEI , strcat(db_64x64_mei, db64x64_fnms{fi, si, pi}))
    end
end

%% Save
info = 'features{fi,si,pi}.project';
save(strcat(db, 'features.mat'), 'features', 'info');
end
%% helpers funcs
%
%
%
function data = deltaMHI(bw, bwold)
    data = deltaMEI(bw, bwold, 1);
end

function data = deltaMEI(bw, bwold, frm)
    data = (bw - bwold) .* frm;
    
end

