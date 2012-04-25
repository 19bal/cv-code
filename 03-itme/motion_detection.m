function [people] = motion_detection(bw)
% Example using :
% ilk_frame ve son_frame'in değerlerini
% değiştirerek ekstra sonuçları görebilirsiniz.
% denemek için örnek girdiler:
%   ilk_frame = 1    140   195   195
%   son_frame = 375  211   375   211

I = {};
ilk_frame = 1;
son_frame = length(bw);
for i = ilk_frame:son_frame
    I{end+1} = bw{i};
end

N = son_frame - ilk_frame + 1;
[R C] = size(I{1}); % 1. frame gibi

% iki insan için bilgiler
people = struct('arm_angle', [0], 'count', [0], 'area', {[0]}, 'bound', {[0]}, 'top', {[0]});

for i = 1:N
    P = I{i};
    L = bwlabel(P);
    s = regionprops(L, 'all');
    areas = [s.Area];
    % parazitleri yok et /( ortalama ile minumum arasındaki alanları yok et)
    id = find(areas > (mean(areas) - min(areas)));
    bw = ismember(L, id);
    % tekrar al
    L = bwlabel(bw);
    s = regionprops(L, 'all');
    b = [s.BoundingBox];            % boundingleri al
    c = [s.Centroid];               % merkezleri al
    area = [s.Area];                % alanları al
    for p = 1 : length(area)
        people.area(i, p) = area(p);
    end
    p1 = false;
    p2 = false;
    if length(b) == 4
        pc = floor(b(1));
        if (pc > C/2); p2 = true;
        else p1 = true;
        end
        if p1
            % kişi sayısı
            people.count(i, 1) = 1; % kişi sayısını ata
            people.count(i, 2) = 0; % kişi sayısını ata
            % tepe noktası
            top = find(P(1:round(c(2)), round(floor(c(1)))) == 1);
            people.top(i, 1) = c(1);
            people.top(i, 2) = top(1);
            people.top(i, 3) = 0;
            people.top(i, 4) = 0;
            % genişlikler için
            for p = 1:4 % 1.kişiyi ata
                people.bound(i, p) = b(p);
            end
            for p = 5:8 % 2.kişiyi sıfırla
                people.bound(i, p) = 0;
            end
        elseif p2
            % kişi sayısı
            people.count(i,1) = 0; % kişi sayısını ata
            people.count(i,2) = 1; % kişi sayısını ata
            % tepe noktası
            top = find(P(1:round(c(2)), round(floor(c(1)))) == 1);
            people.top(i,1) = 0;
            people.top(i,2) = 0;
            people.top(i,3) = c(1);
            people.top(i,4) = top(1);
            % genişlikler için
            for p = 1:4
                people.bound(i, p) = 0; % 1.kişiyi sıfırla
            end
            for p = 1:4
                people.bound(i, p+4) = b(p); % 2.kişiyi sıfırla
            end
        end
    elseif length(b) == 8
        % kişi sayısı
        people.count(i, 1) = 1; % kişi sayısını ata
        people.count(i, 2) = 1; % kişi sayısını ata
        % tepe noktası
        top1 = find(P(1:round(c(2)), round(floor(c(1)))) == 1);
        top2 = find(P(1:round(c(4)), round(floor(c(3)))) == 1);
        people.top(i, 1) = c(1);
        people.top(i, 2) = top1(1);
        people.top(i, 3) = c(3);
        people.top(i, 4) = top2(1);
        p1 = true;
        p2 = true;
        for p = 1:8
            people.bound(i, p) = b(p);
        end
    end
    if p1 == true
        p1c = floor(people.bound(i, 1));
        p1r = floor(people.bound(i, 2));
        p1c_width = floor(people.bound(i, 3));
        p1r_width = floor(people.bound(i, 4));

        arm_x = p1c + p1c_width;
        arm_y = mean(find(P(:, arm_x) == 1));

        p1x = people.top(i, 1);
        p1y = people.top(i, 2);

        oran = (arm_y - p1y) / (arm_x - p1x);
        if oran < 0
            arm_alfa = rad2deg(atan(90 + abs(oran)));
        else
            arm_alfa = rad2deg(atan(1 / oran));
        end
        people.arm_angle(i, 1) = arm_alfa;

        if ((p1r + p1r_width) <= R) && ((p1c + p1c_width) <= C) && (p1c > 0)
            % sadece p1 resimleri gösterilmek istenirse
            % figure, imshow(P(p1r:p1r+p1r_width, p1c:p1c+p1c_width))
        end
    end
    if p2 == true
        p2c = floor(people.bound(i, 5));
        p2r = floor(people.bound(i, 6));
        p2c_width = floor(people.bound(i, 7));
        p2r_width = floor(people.bound(i, 8));

        arm_x = p2c + p2c_width;
        arm_y = mean(find(P(:, arm_x) == 1));

        p2x = people.top(i, 3);
        p2y = people.top(i, 4);

        oran = (arm_y - p2y) / (p2x - arm_x);
        if oran < 0
            arm_alfa = rad2deg(atan(90 + abs(oran)));
        else
            arm_alfa = rad2deg(atan(1 / oran));
        end
        people.arm_angle(i, 2) = arm_alfa;

        if ((p2r + p2r_width) <= R) && ((p2c + p2c_width) <= C) && (p2c > 0)
            % sadece p2 resimleri gösterilmek istenirse
            % figure, imshow(P(p2r:p2r+p2r_width, p2c:p2c+p2c_width)) %
        end
    end
    if p1 == false && p2 == false
        % kişi tepe noktasını sıfırla
        for p = 1:4
            people.top(i, p) = 0;
        end
        % kişi kol açısı, alanı, sayısını sıfırla
        for p = 1:2
            people.count(i, p) = 0; % kişi sayısını ata
            people.area(i, p) = 0;
            people.arm_angle(i, p) = 0;
        end
        for p = 1:8
            people.bound(i, p) = 0;
        end
    end
end

% together and untogether ?
% birlikte olup ayrılıyorlar mı tespit et
together_index = 0;
untogether_index = 0;
together_state = false;
untogether_state = false;
for i = 1:length(people.count)
    if people.count(i, 1) ~= 0 && people.count(i, 2) ~= 0
        p1_x = people.bound(i, 1);
        p1_width = people.bound(i, 3);

        p2_x = people.bound(i, 5);
        p2_width = people.bound(i, 7);

        p1_right = p1_x + p1_width;
        p2_left = p2_x;

        if p2_left == 0;      p_width = p1_width;
        elseif p1_right == C; p_width = p2_width;
        else                  p_width = abs(p2_left - p1_right);
        end

        if i < length(people.count) && together_state == false && (p_width < p1_width && p_width < p2_width) && sum(people.count(i + 1, :)) < sum(people.count(i, :))   % kişi sayısı azalıyorsa
            together_index = i + 1;
            together_state = true;
        end

        if i > 1 && untogether_state == false && (p_width < p1_width && p_width < p2_width) && sum(people.count(i, :)) > sum(people.count(i - 1, :)) % kişi sayısı artıyorsa
            untogether_index = i - 1;
            untogether_state = true;
        end
    end
end

% p1 arm angle with bounding box and motion starting ?
% kol merkezden açısı artıyorsa haraket başlama zamanını yakala

p1_motion_starting_index = 0;
p2_motion_starting_index = 0;
p1_motion_starting_state = false;
p2_motion_starting_state = false;
p1_mean_width = mean(people.bound(find(people.bound(:, 3) ~= 0 & people.bound(:, 7) ~= 0), 3));
p2_mean_width = mean(people.bound(find(people.bound(:, 7) ~= 0), 7));

if together_state
    % 2 kişinin olduğu anda ki kol açılarının ortalamalarını ve
    % standart sapmalarını ata
    count2 = find(people.count(:, 1) == 1 & people.count(:, 2) == 1);
    p1_mean_arm_angle = mean(people.arm_angle(count2(1):together_index, 1));
    p2_mean_arm_angle = mean(people.arm_angle(count2(1):together_index, 2));
    p1_std_arm_angle = std(people.arm_angle(count2(1):together_index, 1));
    p2_std_arm_angle = std(people.arm_angle(count2(1):together_index, 2));

    p1_min_arm_angle = p1_mean_arm_angle - p1_std_arm_angle;
    p1_max_arm_angle = p1_mean_arm_angle + p1_std_arm_angle;
    p2_min_arm_angle = p2_mean_arm_angle - p2_std_arm_angle;
    p2_max_arm_angle = p2_mean_arm_angle + p2_std_arm_angle;
    i = together_index - 1;

    while ((p1_min_arm_angle < people.arm_angle(i, 1) && people.arm_angle(i, 1) < p1_max_arm_angle) && (p1_mean_width < people.bound(i, 3)) && i >= ilk_frame)
        p1_motion_starting_index = i - 1;
        i = i - 1;
        if i == 1; break; end
        end
        if p1_motion_starting_index ~= 0
            p1_motion_starting_state = true;
    end
    i = together_index - 1;
    while ((p2_min_arm_angle < people.arm_angle(i, 2) && people.arm_angle(i, 2) < p2_max_arm_angle) && (p2_mean_width < people.bound(i, 7)) && i >= ilk_frame)
        p2_motion_starting_index = i - 1;
        i = i - 1;
        if i == 1; break; end
        end
        if p2_motion_starting_index ~= 0
            p2_motion_starting_state = true;
    end
end

% p1 and p2 together motion ?
% p1 ve p2 birlikte hareketi sırasında genişliklerinde
% büyüme küçülme %70 oranında oluyorsa yakala
LIKE = 70;
together_motion_state = false;
if together_state || untogether_state ||  people.count(:, 1) == 1 || people.count(:, 2) == 1
    if together_state == false
        together_index = 1;
    end
    if untogether_state == false
        untogether_index = N;
    end
    % birlikte iken genişlik ne kadar ?
    motion_width = people.bound(together_index+1:untogether_index, 3);
    if motion_width
        start = motion_width(1:round(length(motion_width) / 2));
        stop = motion_width(round(length(motion_width) / 2):end);

        start_like = 0;
        reverse_start = wrev(sort(start));
        for i = 1:length(start)
            if start(i) == reverse_start(i)
                start_like = start_like + (100 / length(start));
            end
        end
        stop_like = 0;
        sort_stop = sort(stop);
        for i = 1:length(stop)
            if stop(i) == sort_stop(i)
                stop_like = stop_like + (100 / length(stop));
            end
        end
        if stop_like > LIKE && start_like > LIKE % benzerlik oranları
            together_motion_state = true;
        end
    end
end

% p1 bounding_box and motion ending ?
% p2 hamle yaptıysa, p1 sendeliyor mu ?
p2_motion_ending_index = 0;
p2_motion_ending_state = false;
p2_mean_width = mean(people.bound(find(people.bound(:, 7) ~= 0), 7));
if untogether_state && p2_motion_starting_state
    for i = untogether_index:N
        if p2_mean_width < people.bound(i, 7) && people.count(i, 1) == 1
            p2_motion_ending_index = i;
        end
    end
    if p2_motion_ending_index ~= 0
        p2_motion_ending_state = true;
    end
end

% p1 bounding_box and motion ending ?
% p1 hamle yaptıysa, p2 sendeliyor mu ?
p1_motion_ending_index = 0;
p1_motion_ending_state = false;
p1_mean_width = mean(people.bound(find(people.bound(:, 3) ~= 0 & people.bound(:, 7) ~= 0), 3));
if untogether_state && p1_motion_starting_state
    for i = untogether_index:N
        if p1_mean_width < people.bound(i, 3) && people.count(i, 2) == 1
            p1_motion_ending_index = i;
        end
    end
    if p1_motion_ending_index ~= 0
        p1_motion_ending_state = true;
    end
end

percent = 0;
if p1_motion_starting_state
    frame_no = p1_motion_starting_index;
    fprintf('- p1 bişiler yapmaya başladı:%d\n', frame_no);
    figure(frame_no), imshow(I{frame_no});
    percent = percent + 35;
end
if p2_motion_starting_state
    frame_no = p2_motion_starting_index;
    fprintf('- p2 bişiler yapmaya başladı:%d\n', frame_no);
    figure(frame_no), imshow(I{frame_no});
    percent = percent + 35;
end
if together_state
    frame_no = together_index;
    fprintf('- birlikte oldular:%d\n', frame_no);
    figure(frame_no), imshow(I{frame_no});
    percent = percent + 10;
end
if together_motion_state
    fprintf('- birlikte iken küçülme ve büyüme oldu:[%d-%d]\n', together_index, untogether_index);
    percent = percent + 20;
end
if untogether_state
    frame_no = untogether_index;
    fprintf('- ayrıldılar:%d\n', frame_no);
    figure(frame_no), imshow(I{frame_no});
    percent = percent + 10;
end
if p2_motion_ending_state
    frame_no = p2_motion_ending_index;
    fprintf('- p1e bişiler oldu:%d\n', frame_no);
    figure(frame_no), imshow(I{frame_no});
    percent = percent + 25;
end
if p1_motion_ending_state
    frame_no = p1_motion_ending_index;
    fprintf('- p2e bişiler oldu:%d\n', frame_no);
    figure(frame_no), imshow(I{frame_no});
    percent = percent + 25;
end
fprintf('> itme durumu: |%% %d|\n', percent);
if (percent > 60)
    fprintf('[!] %%60 ı geçtiği için itme var\n');
else
    fprintf('[o] %%60 ı geçmediği için itme yok\n');
end
people;
