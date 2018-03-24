import pywt
#--信号data---
cA,cD1,cD2,cD3=pywt.wavedec(data,'haar',level=3)  #分解
data=pywt.waverec([cA,cD1,cD2,cD3],'haar')    #重构
x1=pywt.upcoef('a',cA,'haar',level=3,take=N)   #计算第3层尺度系数的信号，长度为N
x2=pywt.upcoef('d',cD1,'haar',level=3,take=N)   #计算第3层细节系数的信号，长度为N
