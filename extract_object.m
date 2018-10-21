clear all
close all
%% Add file directory
function_path = 'C:\Users\honlin\Documents\MATLAB\functions_simplified'; 
training_path = 'C:\Users\honlin\Documents\MATLAB\object point cloud\training\velodyne';
label_path = 'C:\Users\honlin\Documents\MATLAB\object point cloud\label_2';
%calibration_path = 'C:\Users\honlin\Documents\MATLAB\object point cloud\training\calib';
addpath(function_path,training_path,label_path);
%define the training point cloud file directory
object_type = 'Car';
prep_training_data(label_path,training_path,object_type);

% for i = 1:length(training_pc);
% % Read calibration file
%    calibration = calibration(calibration_path,i);
% % Calibration
%    pt_cloud = load_pc(training_pc(i).name);
%    Location = pt_cloud.Location';
%    Location = vertcat(Location,ones(1,length(Location)));
%    cameracood = zeros(3,length(Location));
%    for i = 1:length(Location)
%        cameracood(:,i) = calibration.Tr_velo_to_cam*calibration.R0_rect*Location(:,1);
%    end
% end
