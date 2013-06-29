dbg = ~true;
%burayý dokumante edelim
fnm4masks = '../_db/64x64/Our_Foreground/';
ext4masks = '*.png';
DIR_body = '../_db/64x64_shadow/Cutted_Body_masks/';
DIR_shadow= '../_db/64x64_shadow/Cutted_shadow_masks/';
DIR_body64 = '../_db/64x64_shadow/Cutted_Body_masks_64x64/';
DIR_shadow64= '../_db/64x64_shadow/Cutted_shadow_masks_64x64/';
%fnm4error = '_db/error/';        

dbnm_masks = pathos(fnm4masks);

DIR_masks = dir(strcat(dbnm_masks, ext4masks));

mkdir(DIR_body);
mkdir(DIR_shadow);
mkdir(DIR_body64);
mkdir(DIR_shadow64);
sz = length(DIR_masks);
load('./table_e.mat');
t(:,:,1) = cell2mat(table);
load('./table_k.mat');
t(:,:,2) = cell2mat(table);
load('./table_s.mat');
t(:,:,3) = cell2mat(table);

table = mean(t,3);
for f=1:sz
    fnm_masks = DIR_masks(f).name;
    bw = imread(strcat(dbnm_masks, fnm_masks));

    bw = im2bw(bw);
    L = bwlabel(bw);
    spY = table(f,1);
    spX = table(f,2);
    
    [szX,szy] = size(bw);
    sp = uint32([spY + 0.5 , spX + 0.5]);
    if(sp(2) > 1)
        body = bw(1:sp(2),:);
        shadow = bw(sp(2):end,:);
    else
        body = bw;
        shadow = bw;
        fprintf('error on :')
        fprintf(DIR_video(f).name)
        fprintf('\n')
    end
    if dbg
        figure(2),
        subplot(223), imshow(body);
        subplot(224), imshow(shadow);
    end
    imwrite(body, pathos(strcat(DIR_body, fnm_masks)));
    imwrite(shadow, pathos(strcat(DIR_shadow, fnm_masks)));
    body64 = zeros(64,64);
    [x,y] = size(body);
    body64(1:x,1:y) = body;
    imwrite(body64, pathos(strcat(DIR_body64, fnm_masks)));
    shadow64 = zeros(64,64);
    [x,y] = size(shadow);
    shadow64(1:x,1:y) = shadow;
    imwrite(shadow64, pathos(strcat(DIR_shadow64, fnm_masks)));
end