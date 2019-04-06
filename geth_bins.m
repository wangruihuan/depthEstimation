function k = geth_bins(img_h ,k,edgesch)
% ( ]

kh = img_h;
a=zeros(size(kh));
b=a;
c =a;
a(kh<=edgesch(k)  ) = 0;
b(kh > edgesch(k) & kh <=edgesch(k+1) ) = 1;
c(kh >edgesch(k+1))=0;
k = a+b+c;