close all; clear all; clc;

photo_file = 'egitim\';
type_file = '.png';
photos = dir([photo_file,'*',type_file]);
photo_count = size(photos)

% e?itim seti

for i=1:photo_count(1)
    p_name = [photo_file, photos(i,1).name]
    p = imread(p_name);

    %% ysa'ya verilmesi gereken verilerin hesaplanmas?
    im = bwlabel(p); 
    t = extract_features(im);
    
    A(i)=t(1);
    phi(i)=t(2);

end 

% A = A./max(A);
% phi = phi./max(phi);

%% e?itim setinin olu?turulmas?
Input(:,1) = [ mean(A(1:20));mean( phi(1:20))];
Input(:,2) = [ mean(A(21:40)); mean(phi(21:40))];
Input(:,3) = [ mean(A(41:60)); mean(phi(41:60))];
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

    im = bwlabel(label); 
    t = extract_features(im)';
    A (i) = t(1);
    phi(i) = t(2); 
end

% test setinin olu?turulmas?
Input(:,1) = [ mean(A(1:20)); mean(phi(1:20))];
Input(:,2) = [ mean(A(21:40)); mean(phi(21:40))];
Input(:,3) = [ mean(A(41:60)); mean(phi(41:60))];
Output = [ 1 0 0; 
           0 1 0;
           0 0 1; ];

% agin egitilmesi
inputs = Input;
targets = Output;

hiddenLayerSize = 10;
net = patternnet(hiddenLayerSize);

% girdilerin e?itim, do?rulama, test için ayrilmasi
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;

% a??n e?itilmesi
[net,tr] = train(net,inputs,targets);

% a??n test edilmesi
outputs = net(inputs);
errors = gsubtract(targets,outputs);
performance = perform(net,targets,outputs)

% a??n görünümü
view(net)

% Plots
figure, plotperform(tr)
figure, plottrainstate(tr)
figure, plotconfusion(targets,outputs)
figure, ploterrhist(errors)