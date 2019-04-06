function wh = geth_weight( alpha , nD , opt,label)

width = ceil( max(opt.Dmax , opt.Dmin) + 3*alpha ); %这里是以中央点为中心的两边的宽度，总宽度为2*width
wh = zeros(opt.NumView,width*2);

offset = opt.Dmin + (label-1) * (opt.Dmax - opt.Dmin)/(nD-1); %offset为第一行的偏移

mid = width +1;
for i = 1:opt.NumView
    tag = mid + offset - (i-1)*offset/floor(opt.NumView/2); % 斜线上i行的坐标
    for j = 1: 2*width+1
        dist =  tag - j ;
        wh(i,j) = dist * exp( - dist*dist/(2*alpha*alpha));
    end
end

% for i = 1:opt.NumView
%     tag = -offset/(floor(opt.NumView/2)-1); % 斜线上i行的坐标
%     for j = 1: 2*width+1
%         dist =  j- ((abs(i)-5)*tag +mid);
%         wh(i,j) = dist * exp( - dist*dist/(2*alpha*alpha));
%     end
% end

% wh_sum = sum(sum(wh));
% wh = wh .*(1/wh_sum);








