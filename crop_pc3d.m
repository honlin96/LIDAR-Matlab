function pc = crop_pc3d (pt_cloud, x, y, z, height, width, length)
%keep points only between (x,y,z) and (x+length, y+width,z+height)

%Initialization
y_min = y - 0.5*width; y_max = y + 0.5*width; 
x_min = x - 0.5*length; x_max = x + 0.5*length; 
z_min = z; z_max = z + height;

%Get ROI
x_ind = find( pt_cloud.Location(:,1) < x_max & pt_cloud.Location(:,1) > x_min );
y_ind = find( pt_cloud.Location(:,2) < y_max & pt_cloud.Location(:,2) > y_min );  
z_ind = find( pt_cloud.Location(:,3) < z_max & pt_cloud.Location(:,3) > z_min );

crop_ind_xy = intersect(x_ind, y_ind); 
crop_ind = intersect(crop_ind_xy, z_ind); 

%Update point cloud 
pt_cloud = pt_cloud.Location(crop_ind, :); 
pc = pointCloud(pt_cloud); 

end