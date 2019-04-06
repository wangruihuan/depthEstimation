function yv = sumv_convolution_f(wv,kv,uView,vView,opt,alpha)
%{
    本部分实现filter的作用，由于filter只能实现像素点为中心的滤波，
 本部分想实现像素点为非中心的滤波（此处的中心指的是滤波函数的中心）
    w,为权值
    k,为二值图像
    uView,为子孔径所处的行
    vView 为子孔径所处的列
    y为k与w对应对标乘积的和。
%}
width = ceil( max(opt.Dmax , opt.Dmin) + 3*alpha ); %这里是权重以中央点为中心的两边的宽度，总宽度为2*width
[hangk,liek,~] = size(kv);
f=1;
yv = zeros(hangk,liek/opt.NumView);
%for i = uView: (opt.NumView) :hangk %此时求得点的坐标为（i，j）,这个坐标为k上的坐标，并不是原图像。
for i = 1: (opt.NumView) :liek
    for j = 1:hangk %
        
        Pmin = j-width; %  Pmin为在矩阵中的像素点的最左边一列的像素点的列坐标
        Pmax = j+width; %  Pmax为在矩阵中的像素点的最右边一列的像素点的列坐标
        yv(j,f) = getv_sum(kv,wv,Pmin,Pmax,i,opt);
    end
    f= f+1;

end

