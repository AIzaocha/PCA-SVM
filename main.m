%{
***************************************************************************
    
    Cheng Gong
    2017-6-24
    ������Ϣ������ҵ

    ������ҵĿ���ǶԾ������ͼƬ������״����ͼƬ�����״����ͼƬ����ͼƬ���з��࣬
    �������õķ�����PCA+SVM�������ɷַ�������֧����������ϵķ�����
    ѵ��ͼƬ��15�ţ�����ͼƬ5��
***************************************************************************

%}



%main ������������
clear 
close all
tic
%%
% ������ȡָ���ļ����µ�ͼƬ
disp('ѵ��ͼƬ��·��:E:\MatlabProgram\��ҵ����\������Ϣ����3.0\train');
pathname = 'E:\MatlabProgram\��ҵ����\������Ϣ����3.0\train';

disp('���ڶ�ȡͼƬ...');

img_path_list = dir(strcat(pathname,'\*.png'));
img_num = length(img_path_list);
imagedata = [];
if img_num >0
    for j = 1:img_num
        img_name = img_path_list(j).name;
        temp = imread(strcat(pathname, '/', img_name));
        temp = imresize(temp,[370,370]);
        temp = double(temp(:));
        imagedata = [imagedata, temp];
    end
end

fprintf('ͼƬ��ȡ��ϡ�\n\n��ͼƬ���н�ά����,��PCA����...\n\n');
%����ĵڶ�ά�ж�������
col_of_data = size(imagedata,2);

% ���Ļ� & ����Э�������
%��ÿһ�еľ�ֵ������ÿһ����һ��ͼƬ��չ��;
imgmean = mean(imagedata,2);
for i = 1:col_of_data
    imagedata(:,i) = imagedata(:,i) - imgmean;
end
%Э������󣬾����ʽ60*60
covMat = imagedata'*imagedata;
%coeff��ʾ�������ɷֵ�ϵ����latent,��ʾ����ֵ��explained��������
[COEFF, latent, explained] = pcacov(covMat);

% ѡ�񹹳�95%����������ֵ
i = 1;
proportion = 0;
while(proportion < 95)
    proportion = proportion + explained(i);
    i = i+1;
end
p = i - 1;%  p=32

% ����������ʱp=32,������Ϊ��60ά��ά��32ά����С��������
% ��ʱw������Ϊ��һ������ϵ��Ȼ����ԭʼ����ͶӰ���������ϵ��
W = imagedata*COEFF;    % N*M��
W = W(:,1:p);           % N*p��

% ѵ����������������µı����� p*M��
% reference��ʱ��32*60,60����60��ͼƬ��32����һ��ͼƬ��ά��ı�ʾ����
reference = W'*imagedata;

%%
%չʾ������������ΪͼƬ
figure(1)

%չʾ������,
%p����ֻȡǰp������ֵ������W��չʾ������
for i = 1:p
    train_w = reshape(W(:,i),370,370,3);
    subplot(6,6,i)
    imshow(train_w)
end
suptitle('����PCA�������ȡ������ͼ��');
%��������ͼƬ������
print(1,'-dpng','����ͼ')
disp('��ȡ������ͼ�񱣴�Ϊ:����ͼ.png');
fprintf('����PCA�������ս��:����Ϊtrain_pca.mat\n');
save('train_pca','W','reference')
fprintf('PCA���н�����\n\n')

%%
%�������svm���̣���֧�����������з���
disp('��ʼSVMѵ��...');
%nclass ����������
nclass = 3;
%һЩѵ��������������򵥵�������Ӱ�첻�Ǻܴ�

c=128;  
multiSVMstruct=multiSVMtrain( reference',nclass,c); 
disp('SVMѵ����ɡ�')
fprintf('\n')

%%
%���ò��Ժ�����������Խ��������ʾ��ȷ��

disp('��ʼ����ѵ�����...')
%test�ǲ����ļ�����
test
disp('������ɡ�')
toc;