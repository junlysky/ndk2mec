# 数据说明
 ndk文件每5行存储一个地震事件，有用信息记录如下

## 第一行
1. reference catalog:  PDE for USGS, ISC for ISC catalog
2. date
3. time
4. latitude
5. longitude
6. depth
7. mag   两种震级格式的大小 Mb  Ms


## 第二行，
1. event name:    14-characters
2. data used in the inversion:
     B,Long-period body waves
     S,intermediate-period surface waves
     M,long-period mantle waves
3. type of source
     CMT: 0 ,general moment tensor
     CMT: 1 ,moment tensor with constrain of zero trace(standard)
     CMT: 2 ,double-couple source
4. type and duration of moment-rate function
   notice that the value given is half the duration

## 第三行
1. centroid parameters in the inversion
2. type of depth
   FREE: a result of the inversion
   FIX: indicates that the depth is fixed and not inverted for
   BDY: based on model of broad-band P waveforms
3. timestamp
   it is useful to distinguish Quick CMTs and standard CMTs
   Q- :Quick CMTs
   S- :standard CMTs

## 第四行
1. exponent 指定矩张量指数级的大小
   例如，exponent=24,表明后面所有矩张量的值都要乘 10**24
2. six moment-tensor elements
   Mrr,Mtt,Mpp,Mrt,Mrp,Mtp
   r: up
   t: south
   p: east
   notice that each moment-tensor element is followed by its standard error

## 第五行
1. version code
   useless
2. moment-tensor expressed in its principal-axis system:eigenvalue,plunge and azimuth of the three eigenvectors.
   eigenvalue, should be multiplied by 10**(exponent)
   plunge
   azimuth
3. scalar moment , to be multiplied by 10**(exponent)
4. strike,dip,rake
