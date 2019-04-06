function wh = geth_weight( alpha , nD , opt,label)

width = ceil( max(opt.Dmax , opt.Dmin) + 3*alpha ); %�������������Ϊ���ĵ����ߵĿ�ȣ��ܿ��Ϊ2*width
wh = zeros(opt.NumView,width*2);

offset = opt.Dmin + (label-1) * (opt.Dmax - opt.Dmin)/(nD-1); %offsetΪ��һ�е�ƫ��

mid = width +1;
for i = 1:opt.NumView
    tag = mid + offset - (i-1)*offset/floor(opt.NumView/2); % б����i�е�����
    for j = 1: 2*width+1
        dist =  tag - j ;
        wh(i,j) = dist * exp( - dist*dist/(2*alpha*alpha));
    end
end

% for i = 1:opt.NumView
%     tag = -offset/(floor(opt.NumView/2)-1); % б����i�е�����
%     for j = 1: 2*width+1
%         dist =  j- ((abs(i)-5)*tag +mid);
%         wh(i,j) = dist * exp( - dist*dist/(2*alpha*alpha));
%     end
% end

% wh_sum = sum(sum(wh));
% wh = wh .*(1/wh_sum);








