%---------wpd计算各频段的能量特征---------------
clear
clc
load('data_set_IVa_aa.mat');
load('true_labels_aa.mat');
y=true_y;
pos=mrk.pos;
for i=1:280
    sample(i,:,:)=double(cnt(pos(i):pos(i)+299,51:57)).*0.1;
end
[b,a]=butter(5,[8,30]/50);
for i=1:280
    for j =1:7
        sample(i,:,j)=filter(b,a,sample(i,:,j));
        wpt(i,j,:)=wpdec(sample(i,:,j),3,'haar');
        energy(i,j,:)=wenergy(wpt(i,j,:));
    end
end
class1=reshape(energy(y==1,:,:),140,56);
class2=reshape(energy(y==2,:,:),140,56);
a=1:140;
b1=reshape(a,10,14);
for k=10
    b2=setdiff(a,b1(k,:));
    class1_train=class1(b2,:,:);
    class2_train=class2(b2,:,:);
    class1_test=class1(b1(k,:),:,:);
    class2_test=class2(b1(k,:),:,:);
    trainlabel=[ones(1,126),ones(1,126).*2];
    testlabel=[ones(1,14),ones(1,14).*2];
    traindata=[class1_train;class2_train];
    w=lasso(traindata,trainlabel,'lambda',0.1);
    testdata=[class1_test;class2_test];
    Struct=svmtrain(traindata,trainlabel);
    Group=svmclassify(Struct,testdata);
    acc(k)=sum(Group==testlabel)/28;
end

