function [cost_h, cost_v] = LocalDepthSPO_owner5_colo(img_h_RGB, img_v_RGB, NumberOfBins, alpha, nD, opts)
%% 算法实现
%{
    RGB统一处理，划分最bins，在分别处理个数*权值，绝对值相加为每一个像素点得RGB差距，
    最后在取出中央图像得匹配代价，在进行平方求和
    这里的求法是把所有的RGB综合起来，同一求在哪个范围内的。

%}

img_h = double((img_h_RGB));
img_v = double((img_v_RGB));

%
[hangh,lieh,~] = size(img_h_RGB);
[hangv,liev,~] = size(img_v_RGB);
liev = liev/opts.NumView;
hangh = hangh/opts.NumView;
cost_h = zeros(hangh,lieh,nD);
cost_v = zeros(hangv,liev,nD);
%求出图像的最大颜色和最小颜色
minh = min(img_h(:));
maxh = max(img_h(:));
minv = min(img_v(:));
maxv = max(img_v(:));

edgeh = linspace(minh,maxh,NumberOfBins+1); %得到水平的间隔
binwidth_h = edgeh(2) - edgeh(1);
edgesch = edgeh + eps(edgeh);
edgesch(1) = -Inf;
edgesch(end) = Inf;

edgev = linspace(minv,maxv,NumberOfBins+1); %得到垂直的间隔。
binwidth_v = edgev(2) - edgev(1);
edgescv = edgev + eps(edgev);
edgescv(1) = -Inf;
edgescv(end) = Inf;

reverseStr = '';
for d = 1:nD
    wh = geth_weight(alpha , nD , opts,d); % 这里是为了得到权重
    wv = getv_weight(alpha , nD , opts,d);
    yh_cost = zeros(hangh,lieh);
    yv_cost =zeros(hangv,liev);
    for k = 1:NumberOfBins
        yh = zeros(hangh* opts.NumView,lieh);
        yv = zeros(hangv,liev *opts.NumView);
        kh = geth_bins_color(img_h ,k,edgesch); %处理每一个EPI集合得到对应的点。在选定区域的点，
        kv = geth_bins_color(img_v ,k,edgescv);
        for i = 1:3
        yh = filter2(wh,kh(:,:,i),'same');
        yv = filter2(wv,kv(:,:,i),'same');
        yh = yh+abs(yh);
        yv = yv+abs(yv);
        end
        yh_cost = yh_cost+ (get_costh(yh,hangh,lieh ,opts)).^2; % yh是（hang*9 ， lie）的大小要提取出中间一行的大小来
        yv_cost = yv_cost + get_costv(yv,hangv,liev , opts).^2;
    end
    cost_h (:,:,d ) = abs(yh_cost);
    cost_v (:,:,d ) = abs(yv_cost);
    
    msg = sprintf('EPI: %d/%d done!\n',d, nD)  ;
    fprintf([reverseStr, msg]);
    reverseStr = repmat(sprintf('\b'), 1, length(msg));
end