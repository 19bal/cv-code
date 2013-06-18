function runme()
close all; clear all; clc;
dbg = ~true;
db = '../_db/';
db_fg = strcat(db, 'sdha2010-ut-tower/Foreground_Masks/');
db_mhi = strcat(db, 'MHI/');
db_mei = strcat(db, 'MEI/');
mkdir(db_mhi)
mkdir(db_mei)
dip_initialise('silent');

%% Datastore
load(strcat(db, 'datastore.mat'));

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
        sz = size(imread(strcat(db_fg, fg_fnms{1, si, pi})));
        MHI = uint8(zeros(sz));
        MEI = uint8(zeros(sz));
        bwold = -1;
        for fi=1:fsz
            if true, fprintf('\t\t%03d/%03d. frame isleniyor...\n', fi, fsz);    end
            
            bw = imread(strcat(db_fg, fg_fnms{fi, si, pi}));
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
                    subplot(223), imshow(deltaMEI(bw, bwold,fi, dbg))
                    subplot(224), imshow(MEI)
                 pause(0.2)
            end
        end
        features{fi, si}.mei = MHI;
        features{fi, si}.mhi = MEI;
        [t, nm] = fileparts(fg_fnms{fi, si, pi});
        strcat(nm, '.png')
        imwrite(MHI , strcat(db_mhi, strcat(nm, '.png')));
        imwrite(MEI , strcat(db_mei, strcat(nm, '.png')));
    end
end

%% Save
save(strcat(db, 'featuresnormal.mat'), 'features', 'info');
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

