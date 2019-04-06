function wv = getv55_weight(alpha , nD , opt,label,uView,vView)

width = ceil( max(opt.Dmax , opt.Dmin) + 3*alpha ); %�������������Ϊ���ĵ����ߵĿ�ȣ��ܿ��Ϊ2*width
%width = ceil( max(opt.Dmax , opt.Dmin)/(floor(opt.NumView/2)-1)*opt.NumView + 3*alpha ); %�������������Ϊ���ĵ����ߵĿ�ȣ��ܿ��Ϊ2*width

wv = zeros(width*2,opt.NumView);
if (uView ~= 1)
    dmin = opt.Dmin/floor(opt.NumView/2)*(uView-1);%dmin ������ǵ�vView�е��ӿ׾����һ�е��Ӳ����Сֵ��
    dmax = opt.Dmax/floor(opt.NumView/2)*(uView-1);%dmaxΪ��vView�е��ӿ׾����һ�е��Ӳ�����ֵ
else
    dmax = opt.Dmin/floor(opt.NumView/2) ;%������������vVIew=1�����1������֮����Ӳ
    dmin = opt.Dmax/floor(opt.NumView/2);
end

if(uView ~=1)
    offset = dmin + (label-1) * abs(dmax- dmin)/(nD-1); % offsetΪ�ڵ�һ���еĺ���ƫ�ƣ�
    
    opint = width +1;
    for i = 1:opt.NumView
        tag = opint + offset - (i-1)*offset/(uView-1); % б����i�е����꣬ opint + offsetΪ��һ�е����ꡣ
        for j = 1: 2*width+1
            dist =  tag - j ;
            wv(j,i) = dist * exp( - dist*dist/(2*alpha*alpha));
        end
    end
else
    offset = dmin - (label-1) * abs(dmax- dmin)/(nD-1); % offsetΪ�ڵڶ��е�ƫ�ƣ�
    
    opint = width +1;
    for i = 1:opt.NumView
        tag = opint  + (i-1)*offset; % б����i�е����꣬ opint Ϊ��1�е����ꡣ
        for j = 1: 2*width+1
            dist =  tag - j ;
            wv(j,i) = dist * exp( - dist*dist/(2*alpha*alpha));
        end
    end
end

% wh_sum = sum(sum(wv));
% wv = wv .*(1/wh_sum);
