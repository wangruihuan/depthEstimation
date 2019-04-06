function flag = erzhi(dir)

a=zeros(size(dir));
b=a;

a(dir<=0  ) = 0;
b(dir > 0) = 1;

flag = a+b;