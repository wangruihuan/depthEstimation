
function result = algo_center_depth(img_h_RGB,img_v_RGB, NumberOfBins, alpha, nD, opts,sigma)

[cost_h, cost_v] = LocalDepthSPO_owner5_colo2(img_h_RGB, img_v_RGB, NumberOfBins, alpha, nD, opts);


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
        q = guidedfilter_color(double(img_view), double(p), r, eps);        
        weight_cost(:,:,d) = q;
        msg = sprintf('Processing: %d/%d done!\n',d, nD)  ;
        fprintf([reverseStr, msg]);
        reverseStr = repmat(sprintf('\b'), 1, length(msg));
end
fprintf('Final depth estimation completed in %.2f sec\n', toc);

[~,weightD] = max(weight_cost,[],3);
result = weightD;
%result = uint8((256/(nD))*(weightD-1));
