close all; clear all; clc;
dbg = ~true;
db = '../_db/';
db_64x64_fg = strcat(db, '64x64/Our_Foreground/');
db_mhi = strcat(db, 'MHI/');
db_mei = strcat(db, 'MEI/');


dip_initialise('silent');

%% Datastore
load(strcat(db, 'datastore.mat'));
objectsMHI = []
objectsMEI = []
targets = []
psz = size(vf_fnms, 3);
for pi=1:psz
    if true, fprintf('%03d/%03d. kisi isleniyor...\n', pi, psz); end

    ssz = cellsize(vf_fnms, pi);
    for si=1:ssz
        if true, fprintf('\t%1d/%1d. seq isleniyor...\n', si, ssz);  end

        clear seq_frms;
        fsz = cellsize(vf_fnms, pi, si);
            
            [t, nm] = fileparts(vf_fnms{fsz, si, pi});
            nm(1) ='f'
            nm(2) ='g'
            mhi = imread(strcat(db_mhi, strcat(nm, '.png')));
            mei = imread(strcat(db_mei, strcat(nm, '.png')));
            
            if(si == 1)
                objectsMHI = [objectsMHI; reshape(mhi,1,[])];
                objectsMEI = [objectsMEI; reshape(mei,1,[])];
                targets = [targets; 0,1];
            elseif(si == 4)
                objectsMHI = [objectsMHI; reshape(mhi,1,[])];
                objectsMEI = [objectsMEI; reshape(mei,1,[])];
                targets = [targets; 0,1];
                
            elseif(si == 9)
                objectsMHI = [objectsMHI; reshape(mhi,1,[])];
                objectsMEI = [objectsMEI; reshape(mei,1,[])];
                targets = [targets; 0,1];
            end
    end
end
save('targets.mat','targets')
save('objectsMHI.mat','objectsMHI')
save('objectsMEI.mat','objectsMEI')
