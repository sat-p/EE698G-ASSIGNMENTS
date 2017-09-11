%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author : Satya Prakash Panuganti 
% EE698G - Assignment 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function camera_points = camera_transform (H, K, points, h)
    % camera_points = camera_transform (H, K, points, h). Transforms 'points'
    % which are below 'h' height from the camera in the camera's reference
    % frame onto the the camera's projection plane, provided that the they also
    % lie in front of the camera lens.
    %
    % H      : The extrinsic matrix which transforms points to the camera's
    % frame of reference.
    % K      : The intrinsic matrix which transforms points from the camera's
    % frame of reference to the camera's projection plane.
    % points : The 'points' to be transformed.
    % h      : The height below which points will be ignored
    
    R = H (1 : 3,...
           1 : 3);
    
    T = H (1 : 3,...
           4);

    transformed_points = bsxfun (@plus, points * R', T');
    
    % Points in front of the camera
    chosen_points  = transformed_points (:, 3) > 0.25;
    % Points which are not below 'h' height
    chosen_points_ = transformed_points (:, 1) < h;
    
    camera_points = transformed_points (chosen_points & chosen_points_, :) * K';
    
    camera_points = bsxfun (@rdivide, camera_points, camera_points (:, 3));
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%