%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author : Satya Prakash Panuganti 
% EE698G - Assignment 3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function F = fundamental_matrix (K1, K2, R, T)
    % F = fundamental_matrix (K1, K2, R, T). Returns the fundamental matrix
    % given the intrinsic matrices, the rotation matrix and translation vectors
    % from camera 1's frame to camera 2's frame 
    % 
    % K1 : The intrinsic matrix of camera 1
    % K2 : The intrinsic matrix of camera 2
    % R  : The rotation matrix from camera 1's frame to camera 2's frame
    % T  : The translation vector from camera 1's frame to camera 2's frame
    % 
    % F  : The Fundamental matrix
    
    T_x = T (1);
    T_y = T (2);
    T_z = T (3);
    
    S = [   0, -T_z,  T_y;...
          T_z,   0,  -T_x;...
         -T_y,  T_x,   0 ];
     
    E = S * R; % The Essential matrix
    F = (K2' ^ -1) * E * (K1 ^ -1); % The Fundamental matrix
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%