function y = sumh_convolution_f(w,k,uView,vView,opt,alpha)
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
[hangk,liek,~] = size(k);
f=1;
y = zeros(hangk/opt.NumView,liek);
%for i = uView: (opt.NumView) :hangk %��ʱ��õ������Ϊ��i��j��,�������Ϊk�ϵ����꣬������ԭͼ��
for i = 1: (opt.NumView) :hangk
    for j = 1:liek %
        
        Pmin = j-width; %  PminΪ�ھ����е����ص�������һ�е����ص��������
        Pmax = j+width; %  PmaxΪ�ھ����е����ص�����ұ�һ�е����ص��������
        y(f,j) = geth_sum(k,w,Pmin,Pmax,i,opt);
    end
    f= f+1;

end

