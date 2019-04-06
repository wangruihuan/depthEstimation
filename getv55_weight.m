function wv = getv55_weight(alpha , nD , opt,label,uView,vView)

width = ceil( max(opt.Dmax , opt.Dmin) + 3*alpha ); %这里是以中央点为中心的两边的宽度，总宽度为2*width
%width = ceil( max(opt.Dmax , opt.Dmin)/(floor(opt.NumView/2)-1)*opt.NumView + 3*alpha ); %这里是以中央点为中心的两边的宽度，总宽度为2*width

wv = zeros(width*2,opt.NumView);
if (uView ~= 1)
    dmin = opt.Dmin/floor(opt.NumView/2)*(uView-1);%dmin 代表的是第vView列的子孔径与第一列的视差的最小值。
    dmax = opt.Dmax/floor(opt.NumView/2)*(uView-1);%dmax为第vView列的子孔径与第一列的视差的最大值
else
    dmax = opt.Dmin/floor(opt.NumView/2) ;%这里代表的是与vVIew=1，与第1列像素之间的视差。
    dmin = opt.Dmax/floor(opt.NumView/2);
end

if(uView ~=1)
    offset = dmin + (label-1) * abs(dmax- dmin)/(nD-1); % offset为在第一行中的横向偏移，
    
    opint = width +1;
    for i = 1:opt.NumView
        tag = opint + offset - (i-1)*offset/(uView-1); % 斜线上i列的坐标， opint + offset为第一列的坐标。
        for j = 1: 2*width+1
            dist =  tag - j ;
            wv(j,i) = dist * exp( - dist*dist/(2*alpha*alpha));
        end
    end
else
    offset = dmin - (label-1) * abs(dmax- dmin)/(nD-1); % offset为在第二列的偏移，
    
    opint = width +1;
    for i = 1:opt.NumView
        tag = opint  + (i-1)*offset; % 斜线上i列的坐标， opint 为第1列的坐标。
        for j = 1: 2*width+1
            dist =  tag - j ;
            wv(j,i) = dist * exp( - dist*dist/(2*alpha*alpha));
        end
    end
end

% wh_sum = sum(sum(wv));
% wv = wv .*(1/wh_sum);
