%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author : Satya Prakash Panuganti 
% EE698G - Assignment 3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [m, c] = cam1_2_cam2 (K1, K2, R, T, POI)
    % [m, c] = cam1_2_cam2 (K1, K2, R, T, POI). Returns the coefficients of
    % the epipolar line on camera 2's projection plane given the
    % 'point of interest's' pixel coordinates in camera 1's projection plane.
    %
    % K1  : The intrinsic matrix of camera 1
    % K2  : The intrinsic matrix of camera 2
    % R   : The rotation matrix from camera 1's frame to camera 2's frame
    % T   : The translation vector from camera 1's frame to camera 2's frame
    % POI : The pixel cooridnates of the point of interest
    % 
    % m : The slope of the epipolar line
    % c : The y-intercept of the epipolar line

    %% Points belonging to the line along which the POI can exist %%%%%%%%%%%%%
    
    z_range = -1 : 2 : 1; % z_range must have atleast 2 points and should not
                          % include 0.
    POI_c1 = POI * z_range;
    % points in camera 1's frame
    cord_c1 = inverse_camera_transform (K1, POI_c1);

    [~, n] = size (cord_c1);

    % The points in camera 2's frame
    cord_c2 = R * cord_c1 + repmat (T, 1, n);

    POI_c2 = camera_transform (K2, cord_c2);

    %% Computing the coefficients of the epipolar line in C2's projection plane

    POI_c2 (1, :) = POI_c2 (1, :) ./ POI_c2 (3, :);
    POI_c2 (2, :) = POI_c2 (2, :) ./ POI_c2 (3, :);

    [m, c] = OLS (POI_c2 (1, :)', POI_c2 (2, :)');

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%