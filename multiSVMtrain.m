function [ multiSVMstruct ] =multiSVMtrain( traindata,nclass,c)  
%������SVMѵ���� 
% ѡȡ����ͼƬ�е��������svmѵ������󱣴�ѵ�����صĽ��svmstruct���һ�����󣬷��ؽ��

%�����15��ֵ����ѵ��ͼƬ15�ţ�����ѵ��������ʱ��һ��Ҫ�ǵ��޸����������
%������ĺ�����������ˣ���15д�����������������
for i=1:nclass-1  
    for j=i+1:nclass          
        X=[traindata(15*(i-1)+1:15*i,:);traindata(15*(j-1)+1:15*j,:)];
        Y=[ones(15,1);zeros(15,1)];  
      %�򵥵�ѡȡrbf��Ϊ����ĺ˺���
       multiSVMstruct{i}{j}=svmtrain(X,Y,'Kernel_Function','rbf','boxconstraint',c); 
      end  
end  
end
