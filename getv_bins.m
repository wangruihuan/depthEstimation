function k = getv_bins(img_v ,k,edgescv)
kv = img_v;
a=zeros(size(kv));
b=a;
c =a;
a(kv<=edgescv(k)  ) = 0;
b(kv > edgescv(k) & kv <=edgescv(k+1) ) = 1;
c(kv >edgescv(k+1))=0;
k = a+b+c;
