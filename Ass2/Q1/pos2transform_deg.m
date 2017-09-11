%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author : Satya Prakash Panuganti 
% EE698G - Assignment 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function H = pos2transform_deg (pos)
    % H = pos2transform_deg (pos)
    %
    % pos : The pose of B w.r.t A in the form of [x y z psi thetha phi] where
    % psi, theta & phi are the angles of rotation in degrees in the order x-y-z.
    %
    % H   : The transformation matrix from B to A in the form [R T;
    %                                                          0 1]
    
    angles = pos (4 : 6);
    trans  = pos (1 : 3);
    
    R = rotation_matrix_deg  (angles);
    
    H = [      R,       trans';
         zeros(1, 3),    1   ];
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%