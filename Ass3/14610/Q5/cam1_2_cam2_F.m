%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author : Satya Prakash Panuganti 
% EE698G - Assignment 3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [m, c] = cam1_2_cam2_F (POI_c1, F)
    % [m, c] = cam1_2_cam2_F (POI_c1, F). Returns the
    % coefficients of the epipolar line on camera 2's projection plane
    % given the 'point of interest's' pixel coordinates in camera 1's
    % projection plane
    %
    % POI_c1 : The pixel cooridnates of the point of interest
    % F      : The fundamental matrix
    % 
    % m : The slope of the epipolar line
    % c : The y-intercept of the epipolar line
    
    % We know that :
    % p_2' * F * p_1 = 0
    % Hence, p_1' * F' * p_2 = 0;
    % Therefore, the locus of the epipolar line is given by the nullspace
    % of POI_c1' * F'
    
    [N] = null (POI_c1' * F');
    
    n1 = N (:, 1);
    n2 = N (:, 2);
    
    % Ensuring that p_2 is the form [c1; c2; 1], we have :
    % p_2 = a * n1 + b * n2 & a * n1 (3) + b * n2 (3) = 1
    % Therefore, b = (1 - a * n1 (3)) / n2 (3).
    % Hence p_a (a) = a * n1 + ((1 - a * n1 (3)) / n2 (3)) * n2
    
    a = -1 : 2 : 1; % a must have atleast 2 points
    b = (1 - a * n1 (3)) / n2 (3);
    
    p_2 = n1 * a  + n2 * b;
    
    %% Computing the coefficients of the epipolar line in C2's projection plane

    [m, c] = OLS (p_2 (1, :)', p_2 (2, :)');
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%