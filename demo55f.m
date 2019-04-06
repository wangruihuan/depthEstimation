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



QA = [0,6,10,13,18,22,27,32,37];
for i = 1:9
    %% input and output path boardgames
    input_path  = strcat('D:\czt_finally_database\SPO_database\boardgames\boardgames_',int2str(QA(i)),'\');
    
    for m =7
        for n =7
            output_path = strcat('D:\czt_finally_database\SPO_result\medieval2\test5\boardgames_',int2str(QA(i)),'\',int2str(m),'_',int2str(n),'\');
            mkdir(output_path);
            SPO_test5f(input_path, output_path, NumberOfBins,m,n);
        end
    end
   
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%