%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author : Satya Prakash Panuganti 
% EE698G - Assignment 3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function camera_points = camera_transform (K, points)
    % camera_points = camera_transform (K, points). Transforms points from the
    % camera's frame of reference onto the camera's projection plane.
    %
    % K      : The intrinsic matrix which transforms points from the camera's
    % frame of reference onto the camera's projection plane.
    % points : The 'points' to be transformed.
    
    camera_points = K * points;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%