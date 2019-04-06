clear all;
clc;
close all;

addpath(genpath('guidedfilter'));
addpath(genpath('preprocess'));


%% number of bins in the histogram

NumberOfBins = 64;                  % for traditional images
% NumberOfBins = 32;                % for Lytro images
% NumberOfBins = 8 ;                % for nosiy images
% NumberOfBins = 128;               % for low-texture images

%% input and output path
input_path  = 'E:\毕业设计\毕设工程\SPO_databases\medieval2\medieval2_origa\';
output_path = 'C:\Users\50260\Desktop\hope\medieval2_2-4\'; 
mkdir(output_path);

%% depth estimation
SPO_test5f(input_path, output_path, NumberOfBins,2,4);

% 
% % input_path = 'E:\毕业设计\毕设工程\SPO_databases\pillow\'; 
% % output_path = 'E:\毕业设计\毕设工程\test\版本5\test5\pillow_8-8\'; 
% % mkdir(output_path);
% % SPO_test5(input_path, output_path, NumberOfBins,8,8);
% % 
% % 
% % input_path = 'E:\毕业设计\毕设工程\SPO_databases\platonic\'; 
% % output_path = 'E:\毕业设计\毕设工程\test\版本5\test5\platonic_8-8\'; 
% % mkdir(output_path);
% % SPO_test5(input_path, output_path, NumberOfBins,8,8);
% 
% 
% input_path = 'E:\毕业设计\毕设工程\SPO_databases\table\'; 
% output_path = 'E:\毕业设计\毕设工程\test\版本5\test5\table_8-8\'; 
% mkdir(output_path);
% SPO_test5(input_path, output_path, NumberOfBins,8,8);


% input_path = 'E:\毕业设计\毕设工程\SPO_databases\rosemary\'; 
% output_path = 'E:\毕业设计\毕设工程\test\版本5\test5\rosemary_8-8\'; 
% mkdir(output_path);
% SPO_test5(input_path, output_path, NumberOfBins,8,8);
% 
% 
% input_path = 'E:\毕业设计\毕设工程\SPO_databases\pillow\'; 
% output_path = 'E:\毕业设计\毕设工程\test\版本5\test5\pillow_5-2\'; 
% mkdir(output_path);
% SPO_test5(input_path, output_path, NumberOfBins,5,2);
% 
% 
% input_path = 'E:\毕业设计\毕设工程\SPO_databases\platonic\'; 
% output_path = 'E:\毕业设计\毕设工程\test\版本5\test5\platonic_5-2\'; 
% mkdir(output_path);
% SPO_test5(input_path, output_path, NumberOfBins,5,2);
% 
% 
% input_path = 'E:\毕业设计\毕设工程\SPO_databases\table\'; 
% output_path = 'E:\毕业设计\毕设工程\test\版本5\test5\table_5-2\'; 
% mkdir(output_path);
% SPO_test5(input_path, output_path, NumberOfBins,5,2);

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% input_path  = 'E:\毕业设计\毕设工程\SPO_databases\medieval2\medieval2_37\';
% 
% output_path = 'E:\毕业设计\毕设工程\test\版本5\medieval2\medieval2_37\8-8\'; 
% mkdir(output_path);
% 
% %% depth estimation
% SPO_test5f(input_path, output_path, NumberOfBins,8,8);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% input_path  = 'E:\毕业设计\毕设工程\SPO_databases\medieval2\medieval2_32\';
% 
% output_path = 'E:\毕业设计\毕设工程\test\版本5\medieval2\medieval2_32\8-8\'; 
% mkdir(output_path);
% 
% %% depth estimation
% SPO_test5f(input_path, output_path, NumberOfBins,8,8);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% input_path  = 'E:\毕业设计\毕设工程\SPO_databases\medieval2\medieval2_27\';
% 
% output_path = 'E:\毕业设计\毕设工程\test\版本5\medieval2\medieval2_27\8-8\'; 
% mkdir(output_path);
% 
% %% depth estimation
% SPO_test5f(input_path, output_path, NumberOfBins,8,8);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% input_path  = 'E:\毕业设计\毕设工程\SPO_databases\medieval2\medieval2_22\';
% 
% output_path = 'E:\毕业设计\毕设工程\test\版本5\medieval2\medieval2_22\8-8\'; 
% mkdir(output_path);
% 
% %% depth estimation
% SPO_test5f(input_path, output_path, NumberOfBins,8,8);