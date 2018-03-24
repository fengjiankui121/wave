%----------小波变换--------
%-----分解1层---------
%----信号data--
[cA,cD]=dwt(data,'haar');   %cA:尺度系数，cD细节系数
%重构
newdata=idwt(cA,cD,'haar');%重构
newdata=idwt(cA,[],'haar');%获得尺度系数的信号
newdata=idwt([],cD,'haar');%获得细节系数的信号
%--------分解多层-----
[c,l]=wavedec(data,3,'haar');
newdata=waverec(c,l,'haar');%重构
newdata=wrcoef('a',c,l,3);%计算第3层的尺度系数的信号
newdata=wrcoef('d',c,l,3);%计算第3层的细节系数的信号
