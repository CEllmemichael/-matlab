clc;
clear;
% [file path] = uigetfile('*.*');
root = './ԭʼͼ��`';
img_list = dir(root);
for i = 3:174
    name = img_list(i).name;
    filename = [root,'/',name];
    %filename = fullfile(path,file);
    Image = imread(filename); %����ԭʼͼ��
    Ih = rgb2gray(Image); % RGBͼ��ת���ɻҶ�ͼ��
    thresh1 = graythresh(Image); % ���ԭͼ�Զ�ȷ����ֵ����ֵ����ֵԽ��ͼ��Խ�ڣ�ԽСԽ��
    I20 = im2bw(Image,thresh1); % ��ͼ��ֱ�ӽ��ж�ֵ��
    I21 = imdilate(I20, strel('disk', 4));
    I21 = ~I21(150:420,100:400);
%     I21 = ~I21;
    % figure(2)
    % imshow(I21);
    % ��ȡ��ֵ��ͼǰ���������ͨ��
    imLabel = bwlabel(I21,4);      % ����ͨ������б��
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

