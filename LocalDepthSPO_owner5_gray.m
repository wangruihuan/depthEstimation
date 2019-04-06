function [cost_h, cost_v] = LocalDepthSPO_owner5_gray(img_h_RGB, img_v_RGB, NumberOfBins, alpha, nD, opts)

img_h = double(rgb2gray(img_h_RGB));
img_v = double(rgb2gray(img_v_RGB));

%
[hangh,lieh,~] = size(img_h_RGB);
[hangv,liev,~] = size(img_v_RGB);
liev = liev/opts.NumView;
hangh = hangh/opts.NumView;
cost_h = zeros(hangh,lieh,nD);
cost_v = zeros(hangv,liev,nD);
%���ͼ��������ɫ����С��ɫ
minh = min(img_h(:));
maxh = max(img_h(:));
minv = min(img_v(:));
maxv = max(img_v(:));

edgeh = linspace(minh,maxh,NumberOfBins+1); %�õ�ˮƽ�ļ��
binwidth_h = edgeh(2) - edgeh(1);
edgesch = edgeh + eps(edgeh);
edgesch(1) = -Inf;
edgesch(end) = Inf;

edgev = linspace(minv,maxv,NumberOfBins+1); %�õ���ֱ�ļ����
binwidth_v = edgev(2) - edgev(1);
edgescv = edgev + eps(edgev);
edgescv(1) = -Inf;
edgescv(end) = Inf;

reverseStr = '';
for d = 1:nD
    wh = geth_weight(alpha , nD , opts,d); % ������Ϊ�˵õ�Ȩ��
    wv = getv_weight(alpha , nD , opts,d);
    yh_cost = zeros(hangh,lieh);
    yv_cost =zeros(hangv,liev);
    for k = 1:NumberOfBins
        
        kh = geth_bins(img_h ,k,edgesch); %����ÿһ��EPI���ϵõ���Ӧ�ĵ㡣��ѡ������ĵ㣬
%         sum1(k) = sum(sum(kh));
        kv = getv_bins(img_v ,k,edgescv);
        yh = filter2(wh,kh,'same');
        yv = filter2(wv,kv,'same');
        yh_cost = yh_cost+ (get_costh(yh,hangh,lieh ,opts)).^2; % yh�ǣ�hang*9 �� lie���Ĵ�СҪ��ȡ���м�һ�еĴ�С��
        yv_cost = yv_cost + get_costv(yv,hangv,liev , opts).^2;
    end
    cost_h (:,:,d ) = abs(yh_cost);
    cost_v (:,:,d ) = abs(yv_cost);
    
    msg = sprintf('EPI: %d/%d done!\n',d, nD)  ;
    fprintf([reverseStr, msg]);
    reverseStr = repmat(sprintf('\b'), 1, length(msg));
end