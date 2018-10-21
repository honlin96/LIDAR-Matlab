function prep_training_data(label_path,training_path,object_type)
%prep_training_data takes 3 strings as input and save all matlab .mat file in
%the current folder
training_pc = dir(fullfile(training_path,'*.bin'));
counter = 1;
for i = 1:length(training_pc);
%% Read label file
    training_label = extractlabel(label_path,i);
%% Crop Point Cloud  
    pt_cloud = load_pc(training_pc(i).name); 
    for j = 1:length(training_label)
        %Extract type car, pedestrian or cyclist
        if strcmp(training_label(j).type,object_type)
        %note that the camera coordinate and velodyne coordinate are different
        % velodyne coordinate: Camera coordinate
        % x : z, y : -x, z : -y
        x = training_label(j).cam_z;     
        y = -training_label(j).cam_x;
        z = -training_label(j).cam_y;
        height = training_label(j).h;
        len = training_label(j).l;
        width = training_label(j).w;
        %crop point cloud
        pc = crop_pc3d(pt_cloud, x, y, z, height, width, len);
        figure(1)
        pcshow(pc);
        xlabel('x');
        ylabel('y');
        zlabel('z');
        set(gca,'Color','k')
        drawnow;
        name = horzcat(sprintf('%07d',counter)); 
        counter = counter + 1;
        mat = pc.Location;
        save(name,'mat');
        end
    end
end