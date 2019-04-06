
function SPO_test5f(input_path, output_path, NumberOfBins,uView,vView)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Parameter setting
nD = 64;                               % number of depth labels
alpha = 0.8;                           % alpha in Eq (3)
sigma = 0.26;                          % sigma in Eq (6)   
run(strcat(input_path,'depth_opt.m')); % parameter of the light field image
% opts.Dmin: the minimum disparity between the border view and the central view; (-2 default)
% opts.Dmax: the maximum disparity between the border iew and the central view; (2 default)
% opts.NumView: the angular resolution; (9 default)

%% Image loading  
% light field image: 3-dimension (height*NumView, width*NumView, nB)
img = double(imread(strcat(input_path,'lf.bmp')));                          

%% ��ȡ����EPI
%ExtractEPI_alone(img, opts.NumView,uView,vView,output_path);  %%%%%%%%%%%%%    
%% ��ȡEPI����
ucenter = ceil(opts.NumView/2);
vcenter = ucenter;
% ��������ȡ��Ŀ���ӿ׾���EPI
[img_h_RGB, img_v_RGB, img_view] = ExtractEPI_test(img, opts.NumView,uView,vView,output_path);  %%%%%%%%%%%%% 
% ������ȡ���������ӿ׾���EPI
[img_h_RGB_center, img_v_RGB_center, img_view_center] = ExtractEPI_test(img, opts.NumView,ucenter,vcenter,output_path);  %%%%%%%%%%%%%  

%%   Edge detection and orientation computation ��������������ӿ׾�
dilate_amount = 4;  % �����Ǳ�Ե��������ŵ���
tic; disp('1. Edge detection')
im_edge = edge(img_view_center(:,:,1), 'canny') | edge(img_view_center(:,:,2), 'canny') | edge(img_view_center(:,:,3), 'canny');
orient = skeletonOrientation(im_edge, [5 5]);
orient(~im_edge) = -100; 
dir = imdilate(orient, strel('disk', dilate_amount));
flag = erzhi(dir);
fprintf('Edge detecion completed in %.2f sec\n', toc);

[hang,lie,~]=size(img_view);


% %% ��ȡ������ͼ�е�ÿ�����ص��label
% center_label = algo_center_depth(img_h_RGB_center, img_v_RGB_center, NumberOfBins, alpha, nD, opts,sigma);

%% ���������ӽǵ�����ƥ����ۣ�

[cost_h, cost_v] = LocalDepthSPO_owner55_fast_colo2(img_h_RGB, img_v_RGB, NumberOfBins, alpha, nD, opts,uView,vView);


%% ��ȡ������ͼ�е�ÿ�����ص��ƥ�����
[center_cost_h, center_cost_v] = LocalDepthSPO_owner5_colo2(img_h_RGB_center, img_v_RGB_center, NumberOfBins, alpha, nD, opts);


center_label = algo_label(center_cost_h, center_cost_v,sigma, nD,img_view_center);
%% ����Ŀ������ķ��ڵ����label

for x = 1:hang
    for  y = 1:lie
        if (flag(x,y) ==0) % ���������˵�Ϊ���ڵ���
            offset = opts.Dmin + (center_label(x,y)-1) * (opts.Dmax - opts.Dmin)/(nD-1); %offsetΪ��һ�е�ƫ��
            tan = offset/(floor(opts.NumView/2)-1);
            tx = round(x +(ucenter - uView)*tan);
            ty = round(y + (vcenter - vView)*tan);
            if(ty <=lie && ty>0 && tx <= hang && tx >0)
               cost_h(x,ty,:)=center_cost_h(x,y,:);
               cost_v(tx,y,:)=center_cost_v(x,y,:);
            end
        end
    end
end



% winner-takes-all strategy in Eq.5                                                 
[~,labels_max] = max(cost_h ,[],3);                                          
save_img = uint8((256/(nD))*(labels_max-1));
%save_img = uint8((256/(nD))* (64./(labels_max-1)));
imwrite(save_img,(strcat(output_path,'_local_depth_h',int2str(uView),'_',int2str(vView), '.png')));


[~,labels_max] = max(cost_v,[],3);                                         
save_img = uint8((256/(nD))*(labels_max-1));
imwrite(save_img,(strcat(output_path,'_local_depth_v',int2str(uView),'_',int2str(vView), '.png')));


%% Confidence calculation  %����ֱ�Ӽ������7����û�е�������6.
% the weighted cost volume calculated in Eq.7
weight_cost = ConfidenceCal(cost_h, cost_v, sigma, nD);                 
 % weight_cost �Ĵ�СΪ 512*512 *64 
[~,labels_max] = max(weight_cost,[],3);
save_img = uint8((256/(nD))*(labels_max-1));
imwrite(save_img,(strcat(output_path,'_local_depth_integration',int2str(uView),'_',int2str(vView), '.png')));

r = 7;                               
eps = 0.0001; 

tic;
reverseStr = ''  ;
for d=1:nD 
        p = weight_cost(:,:,d);
        q = guidedfilter_color(double(img_view), double(p), r, eps);        
        weight_cost(:,:,d) = q;
        msg = sprintf('Processing: %d/%d done!\n',d, nD)  ;
        fprintf([reverseStr, msg]);
        reverseStr = repmat(sprintf('\b'), 1, length(msg));
end
fprintf('Final depth estimation completed in %.2f sec\n', toc);


[~,weightD] = max(weight_cost,[],3);
save_img = uint8((256/(nD))*(weightD-1));
imwrite(save_img,strcat(output_path,'SPO_depth',int2str(uView),'_',int2str(vView), '.png'));

fprintf('Edge detecion completed in %.2f sec\n', toc);

