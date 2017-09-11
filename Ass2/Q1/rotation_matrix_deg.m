%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author : Satya Prakash Panuganti 
% EE698G - Assignment 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function R = rotation_matrix_deg (angles)
    % R = rotation_matrix_deg (angles). Computes the rotation matrix for a
    % given set of Tait-Bryan angles in degrees.
    %
    % angles : The Tait-Bryan angles (in degrees), with order of rotation being
    % assumed to be x-y-z, in the form of [phi, thetha, psi]
    % 
    % R      : The rotation matrix for the given angles.
    
    psi    = angles (1);
    thetha = angles (2);
    phi    = angles (3);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    c_x = cosd (phi);
    s_x = sind (phi);
    
    c_y = cosd (thetha);
    s_y = sind (thetha);
    
    c_z = cosd (psi);
    s_z = sind (psi);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    R = [c_x * c_y, -s_x * c_z + c_x * s_y * s_z,  s_x * s_z + c_x * s_y * c_z;
         s_x * c_y,  c_x * c_z + s_x * s_y * s_z, -c_x * s_z + s_x * s_y * c_z;
           -s_y,           c_y * s_z,                    c_y * c_z           ];

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%