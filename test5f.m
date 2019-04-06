% % A = zeros(9,3);
% % A(3:7,2:2) = ones(5,1);
% % mesh(A)
% % H = [1 2 1; 0 0 0; -1 -2 -1];
% % Y = filter2(H,A,'same');
% % mesh(Y)
% % 
% % khr = getv_bins(img_hr ,k,edgeschr);
% % 
% % w = [1 0 9;
% %     81 0 100 ];
% 
% 
% target_cost_h = zeros(5,3,2);
% target_cost_h(1,1,:)=[1,0];
% for i = 1:5
%     for j = 1:3
%         if((target_cost_h(i,j,:))==0)
%             target_cost_h(i,j,:)=1;
%         end
%     end
% end
% 
% 
% 
%  
% 
% nD = 64;
% [~,labels_max] = max(center_cost_h ,[],3);                                          
% save_img = uint8((256/(nD))*(labels_max-1));
% 
% [~,labels_max] = max(center_cost_v ,[],3);                                          
% save_img = uint8((256/(nD))*(labels_max-1));
% 
% 
% [~,labels_max] = max(target_cost_h ,[],3);                                          
% save_img = uint8((256/(nD))*(labels_max-1));
% 
% [~,labels_max] = max(target_cost_v ,[],3);                                          
% save_img = uint8((256/(nD))*(labels_max-1));
% 
% 
% [~,labels_max] = max(cost_h ,[],3);                                          
% save_img = uint8((256/(nD))*(labels_max-1));
% 
% [~,labels_max] = max(cost_v ,[],3);                                          
% save_img = uint8((256/(nD))*(labels_max-1));
% 
% QA = [0,6,10,13,18,22,27,32,37];
% for i = 1:9
% 
% 
% output_path =strcat( 'D:\czt_finally_database\SPO_database\vinyl\vinyl_',int2str(QA(i)),'\8-8\'); 
% mkdir(output_path);
% end

clear all;
clc;
close all;
cost_h = zeros(100,100);
tic;
for x = 1:100
    for  y = 1:100
        
               cost_h(x,y)=x+y;
    end
end
toc;
tic
m = 1:100;
n = 1:100;
[M N]= meshgrid(m, n);
t = M+N;
cost=t;
toc;

 output_path = strcat('C:\Users\50260\Desktop\hope\medieval2_2-4\');
save( (strcat(output_path,'计算其他视角的整体匹配代价_cost_h_',int2str(2),'_',int2str(4), '.mat')),'cost_h');
