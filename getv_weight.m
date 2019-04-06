function wv = getv_weight(alpha , nD , opt,label)

width = ceil( max(opt.Dmax , opt.Dmin) + 3*alpha ); %�������������Ϊ���ĵ����ߵĿ�ȣ��ܿ��Ϊ2*width

wv = zeros(width*2,opt.NumView);

offset = opt.Dmin + (label-1) * (opt.Dmax - opt.Dmin)/(nD-1);
mid = width +1;
for i = 1:opt.NumView
    tag = mid + offset - (i-1)*offset/floor(opt.NumView/2); % б����i�е�����
    for j = 1 : 2*width +1
        dist = tag -j;
        wv(j,i) = dist * exp( - dist*dist/(2*alpha*alpha));
    end
end

% wh_sum = sum(sum(wv));
% wv = wv .*(1/wh_sum);
