%% ʵ�ֲ�ͬ�ӿ׾������ͼ�ļ���

clear all;
clc;
close all;

addpath(genpath('guidedfilter'));
addpath(genpath('preprocess'));


%% number of bins in the histogram �������һ���ף��Ժ�Ҫע�⣡����

NumberOfBins = 64;                  % for traditional images
% NumberOfBins = 32;                % for Lytro images
% NumberOfBins = 8 ;                % for nosiy images
% NumberOfBins = 128;               % for low-texture images

%% input and output path
input_path  = 'E:\��ҵ���\���蹤��\SPO_databases\medieval2\';
for i=1:9
    for j=1:9
    output_path =strcat('C:\Users\50260\Desktop\test\','medieval2_',num2str(i),'_',int2str(j),'\');
    mkdir(output_path);
    SPO_test5(input_path, output_path, NumberOfBins,j,i);% depth estimation
    %SPO_test_shunxu(input_path, output_path, NumberOfBins,j,i);% depth estimation
    end
end


