function wh = geth55_weight( alpha , nD , opt,label,uView,vView)

width = ceil( max(opt.Dmax , opt.Dmin) + 3*alpha ); %�������������Ϊ���ĵ����ߵĿ�ȣ��ܿ��Ϊ2*width
%width = ceil( max(opt.Dmax , opt.Dmin)/(floor(opt.NumView/2)-1)*opt.NumView + 3*alpha ); %�������������Ϊ���ĵ����ߵĿ�ȣ��ܿ��Ϊ2*width

wh = zeros(opt.NumView,width*2);
if (vView ~=1)
    dmin = opt.Dmin/floor(opt.NumView/2)*(vView-1);%dmin ������ǵ�vView�е��ӿ׾����һ�е��Ӳ����Сֵ��
    dmax = opt.Dmax/floor(opt.NumView/2)*(vView-1);%dmaxΪ��uView�е��ӿ׾����һ�е��Ӳ�����ֵ
else
    dmax = opt.Dmin/floor(opt.NumView/2) ;%������������uVIew=1����ڶ�������֮����Ӳ
    dmin = opt.Dmax/floor(opt.NumView/2);
end

if(vView ~=1)
    offset = dmin + (label-1) * abs(dmax- dmin)/(nD-1); % offsetΪ�ڵ�һ���еĺ���ƫ�ƣ�
    
    opint = width +1;
    for i = 1:opt.NumView
        tag = opint + offset - (i-1)*offset/(vView-1); % б����i�е����꣬ opint + offsetΪ��һ�е����ꡣ
        for j = 1: 2*width+1
            dist =  tag - j ;
            wh(i,j) = dist * exp( - dist*dist/(2*alpha*alpha));
        end
    end
else
    offset = dmin - (label-1) * abs(dmax- dmin)/(nD-1); % offsetΪ�ڵڶ��е�ƫ�ƣ�
    
    opint = width +1;
    for i = 1:opt.NumView
        tag = opint  + (i-1)*offset; % б����i�е����꣬ opint Ϊ��1�е����ꡣ
        for j = 1: 2*width+1
            dist =  tag - j ;
            wh(i,j) = dist * exp( - dist*dist/(2*alpha*alpha));
        end
    end
end

% wh_sum = sum(sum(wh));
% wh = wh .*(1/wh_sum);

