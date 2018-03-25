%-------小波包分解与重构----
%----data:信号-------
data=[];
T=wpdec(data,3,'haar');  %3层小波包分解,T为获得的树
signal1=wprcoef(T,[level,N]);  %对level层的第N个节点系数重构
siganl2=wpcoef(T,[level,N]);   %获得level层的第N个节点的系数
T1=wpjoin(T,[7,8,9,10,11,12,13,14]); %收起第3层的节点
signal3=wprec(T);  %对树重构