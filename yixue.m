clc;
clear;
% [file path] = uigetfile('*.*');
root = './原始图像`';
img_list = dir(root);
for i = 3:174
    name = img_list(i).name;
    filename = [root,'/',name];
    %filename = fullfile(path,file);
    Image = imread(filename); %输入原始图像
    Ih = rgb2gray(Image); % RGB图像转化成灰度图像
    thresh1 = graythresh(Image); % 针对原图自动确定二值化阈值，阈值越大图像越黑，越小越白
    I20 = im2bw(Image,thresh1); % 对图像直接进行二值化
    I21 = imdilate(I20, strel('disk', 4));
    I21 = ~I21(150:420,100:400);
%     I21 = ~I21;
    % figure(2)
    % imshow(I21);
    % 提取二值化图前两个最大连通域
    imLabel = bwlabel(I21,4);      % 对连通区域进行标记
    stats = regionprops(imLabel,'Area');
    [b,index] = sort([stats.Area],'descend');
    if length(stats)<2
        bw = imLabel;
    else
        bw = ismember(imLabel,index(1:2));
        if mean(mean(bw(1:3,:)))==1 %|| mean(mean(bw(end-10:end,:)))> 0 
            bw = ismember(imLabel,[index(1),index(3)]);  
        end
        if mean(mean(bw(1:3,:)))==1 %|| mean(mean(bw(end-10:end,:)))> 0 
            bw = ismember(imLabel,[index(2),index(3)]);  
        end
%         if mean(mean(bw(1:10,:)))> 0 || mean(mean(bw(end-10:end,:)))> 0 
%             bw = ismember(imLabel,[index(1),index(4)]);  
%         end
%         if mean(mean(bw(1:10,:)))> 0 || mean(mean(bw(end-10:end,:)))> 0 
%             bw = ismember(imLabel,[index(2),index(4)]);  
%         end
    end

    plots = rand(size(bw));
    plots(plots>0.999) = 1;
    plots(plots<=0.999) = 0;
    plots = plots.*bw;

    point = zeros(size(Ih));
    point(150:420,100:400) = plots ;
    %point = plots ;
    figure(i)
    imshow(I20);

    hold on
    spy(point,10,'yellow')
    pause
    close all
    
end

