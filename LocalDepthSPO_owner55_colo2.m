%% ����Ǽ������������ӽǵ���ͼ��
function [cost_h, cost_v] = LocalDepthSPO_owner55_colo2(img_h_RGB, img_v_RGB, NumberOfBins, alpha, nD, opts,uView,vView)
%% �㷨ʵ��
%{
    RGB�ֱ�����������bins��
    �ڷֱ�������*Ȩֵ������ֵ���Ϊÿһ�����ص��RGB��࣬
    �����ȡ������ͼ���ƥ����ۣ��ڽ���ƽ�����
    ����ǰ�RGB�����г���������죬Ȼ����������
    uView,vView �ֱ���������к��е��ӿ׾�����uView=5,vView=1 Ϊ5��1�е��ӿ׾�
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
%���ͼ��������ɫ����С��ɫ
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
%    test3;
    wh = geth55_weight(alpha , nD , opts,d,uView,vView); % ������Ϊ�˵õ�Ȩ��
    wv = getv55_weight(alpha , nD , opts,d ,uView,vView);
    yh = zeros(hangh,lieh);
    yv = zeros(hangv,liev);
    for k = 1:NumberOfBins

        khr = getv_bins(img_hr ,k,edgeschr);
        khg = getv_bins(img_hg ,k,edgeschg);
        khb = getv_bins(img_hb ,k,edgeschb);
        
        kvr = getv_bins(img_vr ,k,edgescvr);
        kvg = getv_bins(img_vg ,k,edgescvg);
        kvb = getv_bins(img_vb ,k,edgescvb);

        yhr = sumh_convolution(wh,khr,uView,vView,opts,alpha);
        yhg = sumh_convolution(wh,khg,uView,vView,opts,alpha);
        yhb = sumh_convolution(wh,khb,uView,vView,opts,alpha);
        
        yvr = sumv_convolution(wv,kvr,uView,vView,opts,alpha);
        yvg = sumv_convolution(wv,kvg,uView,vView,opts,alpha);
        yvb = sumv_convolution(wv,kvb,uView,vView,opts,alpha);
        
        yh =yh + abs(yhr).^2 + abs(yhg).^2+ abs(yhb).^2;
        yv = yv + abs(yvr).^2 + abs(yvg).^2 + abs(yvb).^2;

    end
    cost_h (:,:,d ) = abs(yh);
    cost_v (:,:,d ) = abs(yv);
    
    msg = sprintf('EPI: %d/%d done!\n',d, nD)  ;
    fprintf([reverseStr, msg]);
    reverseStr = repmat(sprintf('\b'), 1, length(msg));
end
end