function calibra_struct = calibration(calibration_path,i)
%calibration reads the calibration parameter from KITTI calibration
%file and return the calibration parameter as a structure.
%        3d XYZ in <label>.txt are in rect camera coord.
%        2d box xy are in image2 coord
%        Points in <lidar>.bin are in Velodyne coord.
% Input: (string)calibration text file directory 
% Output : Structure P0, P1, P2, P3, R0,Tr CV, Tr VC
%define the calibration file directory
calibration_file = dir(fullfile(calibration_path,'*.txt'));
calibration = fopen(calibration_file(i).name);
    B = textscan(calibration,'%s %f %f %f %f %f %f %f %f %f %f %f %f');
    
    P0 = horzcat(B{2}(1),B{3}(1),B{4}(1),B{5}(1),B{6}(1),B{7}(1),B{8}(1),B{9}(1),...
        B{10}(1),B{11}(1),B{12}(1),B{13}(1));
    P1 = horzcat(B{2}(2),B{3}(2),B{4}(2),B{5}(2),B{6}(2),B{7}(2),B{8}(2),B{9}(2),...
        B{10}(2),B{11}(2),B{12}(2),B{13}(2));
    P2 = horzcat(B{2}(3),B{3}(3),B{4}(3),B{5}(3),B{6}(3),B{7}(3),B{8}(3),B{9}(3),...
        B{10}(3),B{11}(3),B{12}(3),B{13}(3));
    P3 = horzcat(B{2}(4),B{3}(4),B{4}(4),B{5}(4),B{6}(4),B{7}(4),B{8}(4),B{9}(4),...
        B{10}(4),B{11}(4),B{12}(4),B{13}(4));
    R0 = horzcat(B{2}(5),B{3}(5),B{4}(5),B{5}(5),B{6}(5),B{7}(5),B{8}(5),B{9}(5),...
        B{10}(5),B{11}(5),B{12}(5),B{13}(5));
    Trvc = horzcat(B{2}(6),B{3}(6),B{4}(6),B{5}(6),B{6}(6),B{7}(6),B{8}(6),B{9}(6),...
        B{10}(6),B{11}(6),B{12}(6),B{13}(6));
    Trcv = horzcat(B{2}(7),B{3}(7),B{4}(7),B{5}(7),B{6}(7),B{7}(7),B{8}(7),B{9}(7),...
        B{10}(7),B{11}(7),B{12}(7),B{13}(7));
    R0 = R0(1:end-3);
    calibra_struct = struct('P0', P0,...
        'P1',P1,...
        'P2',P2,...
        'P3',P3,...
        'R0_rect',R0,...
        'Tr_velo_to_cam',Trvc,...
        'Tr_imu_to_velo',Trcv);
    fclose(calibration);
    calibra_struct.P0 = reshape(calibra_struct.P0,[4,3])';
    calibra_struct.P1 = reshape(calibra_struct.P1,[4,3])';
    calibra_struct.P2 = reshape(calibra_struct.P2,[4,3])';
    calibra_struct.P3 = reshape(calibra_struct.P3,[4,3])';
    calibra_struct.Tr_velo_to_cam = reshape(calibra_struct.Tr_velo_to_cam,[4,3])';
    calibra_struct.Tr_imu_to_velo = reshape(calibra_struct.Tr_imu_to_velo,[4,3])';
    %Rectified rotation matrix should be a 4x4 matrix, where the 4th column
    %and 4th row are zeros, and R0_rect(4,4)=1
    mat = reshape(calibra_struct.R0_rect,[3,3])';
    mat = horzcat(mat,zeros(3,1));
    mat = vertcat(mat,zeros(1,4));
    mat(4,4) = 1;
    calibra_struct.R0_rect = mat;
end