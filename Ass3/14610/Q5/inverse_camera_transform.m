%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author : Satya Prakash Panuganti 
% EE698G - Assignment 3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function cord_points = inverse_camera_transform (K, points)
    % cord_points = inverse_camera_transform (K, points). Transforms 'points'
    % which lie on the projection plane back on onto the cooridnate frame
    % corresponding to the camera's frame of reference.
    %
    % K      : The intrinsic matrix which transforms points from the camera's
    % frame of reference to the camera's projection plane.
    % points : The 'points' to be transformed.
    
    cord_points = K ^ (-1) * points;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%