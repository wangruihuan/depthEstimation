%% 这个是计算中央视图的
function [cost_h, cost_v] = LocalDepthSPO_owner5_colo2(img_h_RGB, img_v_RGB, NumberOfBins, alpha, nD, opts)
%% 算法实现
%{
    RGB分别处理，划分最bins，
    在分别处理个数*权值，绝对值相加为每一个像素点得RGB差距，
    最后在取出中央图像得匹配代价，在进行平方求和
这个是把RGB单独列出来，求差异，然后在相加求和

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
img_hr = img_h(:,:,1);
img_hg = img_h(:,:,2);
img_hb = img_h(:,:,3);
img_vr = img_v(:,:,1);
img_vg = img_v(:,:,2);
img_vb = img_v(:,:,3);

minhr = min(img_hr(:));
maxhr = max(img_hr(:));
minhg = min(img_hg(:));
maxhg = max(img_hg(:));
minhb = min(img_hb(:));
maxhb = max(img_hb(:));

minvr = min(img_vr(:));
maxvr = max(img_vr(:));
minvg = min(img_vg(:));
maxvg = max(img_vg(:));
minvb = min(img_vb(:));
maxvb = max(img_vb(:));

edgeschr = get_edgesc(minhr,maxhr,NumberOfBins);
edgeschg = get_edgesc(minhg,maxhg,NumberOfBins);
edgeschb = get_edgesc(minhb,maxhb,NumberOfBins);

edgescvr = get_edgesc(minvr,maxvr,NumberOfBins);
edgescvg = get_edgesc(minvg,maxvg,NumberOfBins);
edgescvb = get_edgesc(minvb,maxvb,NumberOfBins);


reverseStr = '';
for d = 1:nD
    wh = geth_weight(alpha , nD , opts,d); % 这里是为了得到权重
    wv = getv_weight(alpha , nD , opts,d);
    yh_cost = zeros(hangh,lieh);
    yv_cost =zeros(hangv,liev);
    
    for k = 1:NumberOfBins
        yh = zeros(hangh* opts.NumView,lieh);
        yv = zeros(hangv,liev *opts.NumView);
        
        khr = getv_bins(img_hr ,k,edgeschr);
        khg = getv_bins(img_hg ,k,edgeschg);
        khb = getv_bins(img_hb ,k,edgeschb);
        
        kvr = getv_bins(img_vr ,k,edgescvr);
        kvg = getv_bins(img_vg ,k,edgescvg);
        kvb = getv_bins(img_vb ,k,edgescvb);
        
        yhr = filter2(wh,khr,'same');
        yhg = filter2(wh,khg,'same');
        yhb = filter2(wh,khb,'same');
        
        yvr = filter2(wv,kvr,'same');
        yvg = filter2(wv,kvg,'same');
        yvb = filter2(wv,kvb,'same');
        
        yh =yh + abs(yhr).^2 + abs(yhg).^2+ abs(yhb).^2;
        yv = yv + abs(yvr).^2 + abs(yvg).^2 + abs(yvb).^2;
        
        
        yh_cost = yh_cost + (get_costh(yh,hangh,lieh ,opts)); % yh是（hang*9 ， lie）的大小要提取出中间一行的大小来
        yv_cost = yv_cost + get_costv(yv,hangv,liev , opts);
    end
    cost_h (:,:,d ) = abs(yh_cost);
    cost_v (:,:,d ) = abs(yv_cost);
    
    msg = sprintf('EPI: %d/%d done!\n',d, nD)  ;
    fprintf([reverseStr, msg]);
    reverseStr = repmat(sprintf('\b'), 1, length(msg));
end