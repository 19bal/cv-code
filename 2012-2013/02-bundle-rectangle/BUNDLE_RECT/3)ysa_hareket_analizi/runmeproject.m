close all; clear all; clc;

photo_file = '_db\egitim\';
type_file = '.png';
photos = dir([photo_file,'*',type_file]);
photo_count = size(photos,1);

% eðitim seti
for i=1:photo_count
    p_name = [photo_file, photos(i,1).name];
    p = imread(p_name);
    % gürültülerin giderilmesi
    label = bwlabel(p);
    rp = regionprops(label,'Area');
    area = [rp.Area];
    f = area == max(area);
    [r,c] = find( f == 0 ); % c etiket bilgisini tutar
    for j = 1:length(c)
        noise = label == (c(j));
        label(noise) = 0;
    end
    %% ysa'ya verilmesi gereken verilerin hesaplanmasý
    im = bwlabel(label); 
    t = extract_features(im)';
    h(i) = t(3) - t(1);       % yukseklik
    w(i) = t(8) - t(4);       % genislik
    area(i) = h(i) * w(i);    % alan
    angel(i) = atan( h(i) / w(i) ); %acý
    ft(i) = fft(area(i));     % spektral güç
end    
% eðitim setinin optimizasyonu
h = h./max(h);
w = w./max(w);
area = area./max(area);
angel = angel./max(angel);
ft = ft./max(ft);
%% eðitim setinin oluþturulmasý
Input(:,1) = [ mean(h(1:20)); mean(w(1:20)); mean(area(1:20)); mean(angel(1:20)); mean(ft(1:20))];
Input(:,2) = [ mean(h(21:40)); mean(w(21:40)); mean(area(21:40)); mean(angel(21:40)); mean(ft(21:40))];
Input(:,3) = [ mean(h(41:60)); mean(w(41:60)); mean(area(41:60)); mean(angel(41:60)); mean(ft(41:60))];
Output = [ 1 0 0; 
           0 1 0;
           0 0 1; ];

%% test seti
t_photo_file = '_db\test\';
t_photos = dir([t_photo_file,'*',type_file]);
t_photo_count = size(t_photos,1);
for i=1:t_photo_count
    p_name = [t_photo_file, t_photos(i,1).name];
    p = imread(p_name);
    % gürültülerin giderilmesi
    label = bwlabel(p);
    rp = regionprops(label,'Area');
    area = [rp.Area];
    f = area == max(area);
    [r,c] = find( f == 0 ); % c etiket bilgisini tutar
    for j = 1:length(c)
        noise = label == (c(j));
        label(noise) = 0;
    end
    %%
    im = bwlabel(label); 
    t = extract_features(im)';
    h(i) = t(3) - t(1);
    w(i) = t(8) - t(4);
    area(i) = h(i) * w(i);
    angel(i) = atan( h(i) / w(i) );
    ft(i) = fft(area(i));
end
% test setinin optimasyonu
h = h./max(h);
w = w./max(w);
area = area./max(area);
angel = angel./max(angel);
ft = ft./max(ft);
% test setinin oluþturulmasý
Test(:,1) = [ mean(h(1:10)); mean(w(1:10)); mean(area(1:10)); mean(angel(1:10)); mean(ft(1:10))];
Test(:,2) = [ mean(h(11:20)); mean(w(11:20)); mean(area(11:20)); mean(angel(11:20)); mean(ft(11:20))];
Test(:,3) = [ mean(h(21:30)); mean(w(21:30)); mean(area(21:30)); mean(angel(21:30)); mean(ft(21:30))];
TestOutput = [ 1 0 0; 
               0 1 0;
               0 0 1; ];

% aðýn eðitilmesi
inputs = Input;
targets = Output;

% Create a Pattern Recognition Network
hiddenLayerSize = 10;
net = patternnet(hiddenLayerSize);

% girdilerin eðitim, doðrulama, test için ayrýlmasý
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;

% aðýn eðitilmesi
[net,tr] = train(net,inputs,targets);

% aðýn test edilmesi
outputs = net(inputs);
errors = gsubtract(targets,outputs);
performance = perform(net,targets,outputs)

% aðýn görünümü
view(net)

% Plots
figure, plotperform(tr)
figure, plottrainstate(tr)
figure, plotconfusion(targets,outputs)
figure, ploterrhist(errors)




