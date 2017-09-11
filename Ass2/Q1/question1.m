%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author : Satya Prakash Panuganti 
% EE698G - Assignment 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc; close all; clear all;

%%%%%%The height below which points are not projected onto the images%%%%%%%%%%

h = 2.125;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load 'Problem.mat'

%%%%%%Calculating the extrinsic matrices%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

H_hl = pos2transform_deg (Problem.X_hl);

H_ch = zeros (4, 4, 5);
H_cl = zeros (4, 4, 5);

for i = 1 : 5
    H_ch (:, :, i) = pos2transform_deg (Problem.X_hc(i).X_hc)^(-1);
    H_cl (:, :, i) = H_ch (:, :, i) * H_hl;
end

%%%%%%Calculating the points in the camera projection planes%%%%%%%%%%%%%%%%%%

for i = 1 : 5
    camera_points{i} = camera_transform (H_cl (:, :, i),...
                                         Problem.K(i).K,...
                                         Problem.scan,...
                                         h);
end

%%%%%%Plotting the images%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[x_size, y_size, c] = size (Problem.Image(i).I);

for i = 1 : 5
    subplot (1, 5, i);
    
    imshow (rot90 (Problem.Image(i).I, 3)); % Rotating the image 270 degrees
                                            % clockwise and then plotting
    hold on;
    
    plot (x_size - camera_points {i}(:, 2),... % Effectively rotating the
          camera_points {i}(:, 1),...          % points in the camera plane by
          '.',...                              % 270 degrees clockwise
          'MarkerSize', 1);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%