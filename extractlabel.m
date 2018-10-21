function label_struct = extractlabel(label_path,i)
%extractlabel reads the label from KITTI training label file
%and return the labelling as a structure.
% the 15 columns are type,
% truncated,occluded, alpha, bbox(left,top,right,bottom),height,width, length,
% camera location(x,y,z), rotation_y[-pi,pi],
%        3d XYZ in <label>.txt are in rect camera coord.
%        2d box xy are in image2 coord
%        Points in <lidar>.bin are in Velodyne coord.
% Input: (string)label text file directory 
% Output: structure

%define the label file directory
    label_file = dir(fullfile(label_path,'*.txt'));
%open the label file       
    training_label = fopen(label_file(i).name);
    A = textscan(training_label,'%s %f %u %f %f %f %f %f %f %f %f %f %f %f %f');
    fclose(training_label);

    %save to structure
    type = A{1}; truncated = num2cell(A{2}); occluded = num2cell(A{3});
    alpha = num2cell(A{4}); bbox_left = num2cell(A{5}); bbox_top = num2cell(A{6});
    bbox_right = num2cell(A{7});bbox_bottom = num2cell(A{8});
    h = num2cell(A{9});w = num2cell(A{10}); l = num2cell(A{11}); 
    cam_x = num2cell(A{12}); cam_y = num2cell(A{13});cam_z = num2cell(A{14});
    rotation_y = num2cell(A{15});
    label_struct = struct('type',type,'truncated',truncated,'occluded',occluded,'alpha',alpha,...,
        'bbox_left',bbox_left,'bbox_top',bbox_top,'bbox_right',bbox_right,'bbox_bottom',bbox_bottom,...
        'h', h,'w',w,'l',l,'cam_x',cam_x,'cam_y',cam_y,'cam_z',cam_z,...
        'rotation_y',rotation_y);
end