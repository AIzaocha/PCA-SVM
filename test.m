%{
����Ŀ����15���ˣ�ÿ����5����ͼƬ��Ϊ���Լ�
%}
%%
% ѡ����Լ�

%col_of_data = 60;%���ݼ�һ��60�У�ÿһ�д���һ����

disp('����ͼƬ��·��:E:\MatlabProgram\��ҵ����\������Ϣ����3.0\test');
pathname = 'E:\MatlabProgram\��ҵ����\������Ϣ����3.0\test';
img_path_list = dir(strcat(pathname,'\*.png'));
img_num = length(img_path_list);
testdata = [];

%��Ϊ����������Ŀ���٣�����ֱ�Ӷ����˲������������RealClass����Ϊ���࣬���1,2,3
realclass = [1;1;1;1;1;2;2;2;2;2;3;3;3;3;3];
if img_num >0
    for j = 1:img_num
        img_name = img_path_list(j).name;
        temp = imread(strcat(pathname, '/', img_name));
        temp = imresize(temp,[370,370]);
        temp = double(temp(:));
        testdata = [testdata, temp];
    end
end
col_of_test = size(testdata,2);

%���Ļ�����һ����������ͼƬ��һ��,����ͼƬ�ļ�ȥƽ��ֵ
meandata = mean(testdata,2);
for i = 1:size(testdata,2)
    testdata(:,i) = testdata(:,i) - meandata;
end

%%
%չʾ���Ļ�֮��Ľ��������ΪͼƬ
figure(2)
%����ͼƬ��һ����Ľ��
for i = 1:col_of_test
    test_w = reshape(testdata(:,i),370,370,3);
    subplot(4,4,i)
    imshow(test_w)
end
suptitle('����ͼƬ��һ����Ľ��')
disp('��ȡ������ͼ�񱣴�Ϊ:���Լ����Ļ�ͼ.png');
print(2,'-dpng','���Լ����Ļ�ͼ')

%����������������ϵ�ı����� p*M��
% object��ʱ��32*45,45����45��ͼƬ��32����һ��ͼƬ��ά��ı�ʾ����
object = W'* testdata;

% svm_test

class= multiSVM(object',multiSVMstruct,nclass);
disp('���Լ�����ȷ��Ϊ:')  
accuracy=sum(class==realclass)/length(class)
%{ 
��С���뷨��Ѱ�Һʹ�ʶ��ͼƬ��Ϊ�ӽ���ѵ��ͼƬ
% ���������׼ȷ��
num = 0;
for j = 1:col_of_test;
    distance = 1000000000000;
    for k = 1:col_of_data;
        % ����ŷʽ����
        temp = norm(object(:,j) - reference(:,k));
        if(distance>temp)
            aimone = k;
            distance = temp;
        end
    end
    if ceil(j/5)==ceil(aimone/15)
       num = num + 1;
    end
end
accuracy = num/col_of_test
%}