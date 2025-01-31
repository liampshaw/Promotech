function PPT52 = BPB5(Name5,testD5)
load F-scorezhiL2_5.mat F2
[hp2,positive2]=fastaread('sigma28promoter.txt');
Np2=length(hp2);
[hp5,positive5]=fastaread('sigma54promoter.txt');
Np5=length(hp5);

for i=1:Np2
    Str=positive2{1,i};
    Str=char(Str);
    Str=upper(Str);%将正样本中的小写序列一律换成大写
    positive2{1,i}=Str;
end
for i=1:Np5
    Str=positive5{1,i};
    Str=char(Str);
    Str=upper(Str);%将正样本中的小写序列一律换成大写
    positive5{1,i}=Str;
end

positive=positive2;
negative=positive5;
Np=length(positive);
Nn=length(negative);
%—————————————————————————
%—————————————————————————
AA='ACGT';
%记录每个氨基酸在每个位置出现的次数
M=length(positive{1,1});
F11=zeros(4,M);%记录每个氨基酸在每个位置出现的次数
F12=zeros(4,M);
for m=1:Np
    for j=1:M
        t=positive{1,m}(j);
        k=strfind(AA,t);
        F11(k,j)=F11(k,j)+1;
    end
end
%
for m=1:Nn
    for j=1:M
        t=negative{1,m}(j);
        k=strfind(AA,t);
        F12(k,j)=F12(k,j)+1;
    end
end
F11= F11/Np;
F12= F12/Nn;

x1=Name5;
WNp=length(x1);%number of positive samples

for i=1:WNp
    Str=testD5{1,i};
    Str=char(Str);
    Str=upper(Str);%将测试样本中的小写序列一律换成大写
    testD5{1,i}=Str;
    %testD1(i,:)=Str;
end

testBPB=zeros(WNp,2*M);
for m=1:WNp
    l=M;
    for j=1:l
        t=testD5{1,m}(j);
        k=strfind(AA,t);
        testBPB(m,j)=F11(k,j);
        testBPB(m,l+j)=F12(k,j);
     end
end
for i=1:140
    k=F2(2,i);
    PPT52(:,i)=testBPB(:,k);%将正负样本的所有特征按F-score分数进行排序
end






