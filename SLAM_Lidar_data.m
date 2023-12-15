clc
clear all
close all
%% load data %%
%load offlineSlamData.mat
load("offlineSlamData.mat");
scan_result=scans(1:50);
max_range_lidar=10;
map_res=20;
slam_obj=lidarSLAM(map_res,max_range_lidar);
for i=1:length(scan_result)
    [scan_valid,loopclosure_data,optimization_data]=...
        addScan(slam_obj,scan_result{i});
    if scan_valid
         fprintf('Added scan %d \n', i);
         figure();
         show(slam_obj)
    end
end

