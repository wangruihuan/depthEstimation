function yv = sumv_convolution_f(wv,kv,uView,vView,opt,alpha)
%{
    ������ʵ��filter�����ã�����filterֻ��ʵ�����ص�Ϊ���ĵ��˲���
 ��������ʵ�����ص�Ϊ�����ĵ��˲����˴�������ָ�����˲����������ģ�
    w,ΪȨֵ
    k,Ϊ��ֵͼ��
    uView,Ϊ�ӿ׾���������
    vView Ϊ�ӿ׾���������
    yΪk��w��Ӧ�Ա�˻��ĺ͡�
%}
width = ceil( max(opt.Dmax , opt.Dmin) + 3*alpha ); %������Ȩ���������Ϊ���ĵ����ߵĿ�ȣ��ܿ��Ϊ2*width
[hangk,liek,~] = size(kv);
f=1;
yv = zeros(hangk,liek/opt.NumView);
%for i = uView: (opt.NumView) :hangk %��ʱ��õ������Ϊ��i��j��,�������Ϊk�ϵ����꣬������ԭͼ��
for i = 1: (opt.NumView) :liek
    for j = 1:hangk %
        
        Pmin = j-width; %  PminΪ�ھ����е����ص�������һ�е����ص��������
        Pmax = j+width; %  PmaxΪ�ھ����е����ص�����ұ�һ�е����ص��������
        yv(j,f) = getv_sum(kv,wv,Pmin,Pmax,i,opt);
    end
    f= f+1;

end

