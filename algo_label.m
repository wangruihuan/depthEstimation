function center_label = algo_label(cost_h, cost_v,sigma, nD,img_view_center)

%% Confidence calculation  %这里直接计算的是7，并没有单独计算6.
% the weighted cost volume calculated in Eq.7
weight_cost = ConfidenceCal(cost_h, cost_v, sigma, nD);                 

%% Depth Optimization
% guided filter for the cost volume
r = 7;                                                                  
eps = 0.0001; 

tic;
reverseStr = ''  ;
for d=1:nD 
        p = weight_cost(:,:,d);
        q = guidedfilter_color(double(img_view_center), double(p), r, eps);        
        weight_cost(:,:,d) = q;
        msg = sprintf('Processing: %d/%d done!\n',d, nD)  ;
        fprintf([reverseStr, msg]);
        reverseStr = repmat(sprintf('\b'), 1, length(msg));
end
fprintf('Final depth estimation completed in %.2f sec\n', toc);

[~,weightD] = max(weight_cost,[],3);
center_label = weightD;
%result = uint8((256/(nD))*(weightD-1));